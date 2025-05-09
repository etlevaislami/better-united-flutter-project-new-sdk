import 'dart:convert';
import 'dart:io';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_better_united/run.dart';
import 'package:flutter_better_united/util/navigation_service.dart';
import 'package:flutter_better_united/util/notifications/handlers/default_handler.dart';
import 'package:flutter_better_united/util/notifications/handlers/finished_friend_league_handler.dart';
import 'package:flutter_better_united/util/notifications/handlers/finished_public_league_handler.dart';
import 'package:flutter_better_united/util/notifications/handlers/friend_invitation_accepted_handler.dart';
import 'package:flutter_better_united/util/notifications/handlers/friend_invitation_handler.dart';
import 'package:flutter_better_united/util/notifications/handlers/public_invitation_handler.dart';
import 'package:flutter_better_united/util/notifications/handlers/push_types.dart';
import 'package:flutter_better_united/util/notifications/handlers/team_of_season_ranking_handler.dart';
import 'package:flutter_better_united/util/notifications/handlers/team_of_week_ranking_handler.dart';
import 'package:flutter_better_united/util/notifications/handlers/tip_settlement_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import 'handlers/login_handler.dart';
import 'handlers/public_league_creation_handler.dart';
import 'handlers/push_handler.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationManager {
  /// Streams are created so that app can respond to notification-related events
  /// since the plugin is initialised in the `main` function
  final BehaviorSubject<String> didReceiveLocalNotificationSubject =
      BehaviorSubject<String>();
  final NavigationService _navigationService;

  String? selectedNotificationPayload;
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'Title',
    importance: Importance.max,
  );

  NotificationManager(this._navigationService) {
    didReceiveLocalNotificationSubject.stream.listen((payload) {
      handlePushType(payload);
    });
  }

  configureNotification() async {
    /// Sets up foreground push notifications for iOS devices
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
          android: AndroidInitializationSettings("background"),
          iOS: DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
          )),
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        final String? payload = response.payload;
        logger.e(payload);
        if (payload != null) {
          didReceiveLocalNotificationSubject.add(payload);
        }
      },
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        !kIsWeb && Platform.isLinux
            ? null
            : await flutterLocalNotificationsPlugin
                .getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedNotificationPayload = notificationAppLaunchDetails!.notificationResponse!.payload;
    }

    RemoteMessage? initialData =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialData != null) {
      selectedNotificationPayload = json.encode(initialData.data);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final payload = json.encode(message.data);
      logger.e(message.toMap());
      final pushHandler = getPushType(payload);
      if (pushHandler.displayForegroundNotification) {
        _displayNotification(message);
      }
      final context = _navigationService.getContext();
      if (context != null) {
        pushHandler.onForegroundMessageReceived(message.data, context);
      }
      selectedNotificationPayload = null;
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      didReceiveLocalNotificationSubject.add(json.encode(remoteMessage.data));
    });
  }

  _displayNotification(RemoteMessage message) {
    RemoteNotification? remoteNotification = message.notification;
    AndroidNotification? androidNotification = message.notification?.android;
    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (remoteNotification != null && androidNotification != null) {
      flutterLocalNotificationsPlugin.show(
          remoteNotification.hashCode,
          remoteNotification.title,
          remoteNotification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: androidNotification.smallIcon,
            ),
          ),
          payload: json.encode(message.data));
    }
  }

   Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    final pendingNotifications = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return pendingNotifications;
  }

  PushHandler getPushType(String payload) {
    final Map<String, dynamic> data = jsonDecode(payload);
    PushType? pushType;
    try {
      pushType = EnumToString.fromString(PushType.values, data["type"]);
    } catch (e) {
      logger.e(e);
    }
    if (pushType == null) {
      logger.i(
          "push type is missing from the payload. Executing default push handler");
      return DefaultPushHandler();
    }
    return getPushHandlerForType(pushType);
  }

  handlePushType(String payload) {
    logger.i("Handling push notification");
    logger.i("payload:$payload");
    final Map<String, dynamic> data = jsonDecode(payload);
    final pushType = EnumToString.fromString(PushType.values, data["type"]);
    final context = _navigationService.getContext();
    selectedNotificationPayload = null;
    if (context == null && pushType == null) {
      return;
    }
    getPushHandlerForType(pushType!).handle(data, context!);
  }

  PushHandler getPushHandlerForType(final PushType pushType) {
    switch (pushType) {
      case PushType.login:
        return LoginPushHandler();
      case PushType.friendLeagueInvitation:
        return FriendInvitationHandler();
      case PushType.friendInvitationAccepted:
        return FriendInvitationAcceptedHandler();
      case PushType.finishedFriendLeague:
        return FinishedFriendLeagueHandler();
      case PushType.finishedPublicLeague:
        return FinishedPublicLeagueHandler();
      case PushType.tipSettlement:
        return TipSettlementHandler();
      case PushType.publicLeagueInvitation:
        return PublicInvitationHandler();
      case PushType.publicLeagueCreation:
        return PublicLeagueCreationHandler();
      case PushType.teamOfWeekWin:
        return TeamOfWeekRankingHandler();
      case PushType.teamOfWeekLose:
        return TeamOfWeekRankingHandler();
      case PushType.teamOfSeasonWin:
        return TeamOfSeasonRankingHandler();
      case PushType.teamOfSeasonLose:
        return TeamOfSeasonRankingHandler();
      default:
        return DefaultPushHandler();
    }
  }
}

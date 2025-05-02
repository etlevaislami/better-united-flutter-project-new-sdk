import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' as dialog;
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';
import 'package:flutter_better_united/widgets/secondary_button.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../flavors.dart';
import '../../run.dart';
import '../../widgets/primary_button.dart';

class ReviewDialog extends StatefulWidget {
  static const String route = "/settings/appReview";

  const ReviewDialog({Key? key}) : super(key: key);

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();

  static showDialog(BuildContext context) {
    dialog.showDialog(
      context: context,
      builder: (BuildContext _) {
        return const ReviewDialog();
      },
    );
  }
}

class _ReviewDialogState extends State<ReviewDialog> {
  bool _isUserRated = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xff2B2B2B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        child: _isUserRated
            ? const _ReviewActions()
            : _RateStep(
                onRatingTap: onRatingSelected,
              ),
      ),
    );
  }

  onRatingSelected(String rating) {
    setState(() {
      _isUserRated = true;
    });
    _logAnalyticEvent(rating);
  }
}

class _ReviewActions extends StatelessWidget {
  const _ReviewActions({Key? key}) : super(key: key);
  final iosStore = "App Store";
  final androidStore = "Play Store";
  final otherStore = "Store";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("rateApp".tr().toUpperCase(),
            textAlign: TextAlign.center, style: context.titleH1White),
        const SizedBox(
          height: 10,
        ),
        Text(
          "tellUsMore".tr(),
          textAlign: TextAlign.center,
          style: context.bodyRegularWhite,
        ),
        const SizedBox(
          height: 40,
        ),
        PrimaryButton(
          text: "reviewOnStore".tr(args: [_getStoreName()]),
          onPressed: () async {
            _openAppReview();
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(
          height: 8,
        ),
        SecondaryButton(
          withBorders: false,
          backgroundColor: const Color(0xff535353),
          text: "writeMessage".tr().toUpperCase(),
          onPressed: () async {
            _openEmail();
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(
          height: 16,
        ),
        SecondaryButton.labelText(
          "maybeLater".tr().toUpperCase(),
          withUnderline: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  String _getStoreName() {
    if (Platform.isIOS) {
      return iosStore;
    }

    if (Platform.isAndroid) {
      return androidStore;
    }
    return otherStore;
  }

  _openEmail() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();
    final appVersion = "appVersion".tr(args: [packageInfo.version]);
    late final String osName;
    late final String deviceName;

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      osName = "iOS: ${iosInfo.systemVersion}";
      deviceName = "device".tr(args: [iosInfo.utsname.machine]);
    }

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      osName = "Android: ${androidInfo.version.release}";
      deviceName = "device".tr(args: [androidInfo.device]);
    }
    final mailBody = "$osName\n$deviceName\n$appVersion";

    final Uri emailLaunchUri = Uri(
      scheme: "mailto",
      path: F.feedbackEmail,
      query: _encodeQueryParameters(<String, String>{
        "subject": "mailSubject".tr(),
        "body": mailBody,
      }),
    );

    launchUrl(emailLaunchUri);
  }

  _openAppReview() async {
    LaunchReview.launch(iOSAppId: F.iosStoreAppId, androidAppId: F.packageName);
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}

class _RateStep extends StatelessWidget {
  const _RateStep({Key? key, this.onRatingTap}) : super(key: key);
  final Function(String)? onRatingTap;
  static const worstRating = "WORST";
  static const poorRating = "POOR";
  static const averageRating = "AVERAGE";
  static const goodRating = "GOOD";
  static const excellentRating = "EXCELLENT";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("rateApp".tr().toUpperCase(),
            textAlign: TextAlign.center, style: context.titleH1White),
        const SizedBox(
          height: 16,
        ),
        Text(
          "enjoyingApp".tr(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () => onRatingTap?.call(excellentRating),
          child: Row(
            children: [
              _buildRating(
                worstRating,
                iconData: BetterUnited.tired,
                onTap: (ratingIdentifier) =>
                    onRatingTap?.call(ratingIdentifier),
              ),
              const SizedBox(
                width: 5,
              ),
              _buildRating(
                poorRating,
                iconData: BetterUnited.frown,
                onTap: (ratingIdentifier) =>
                    onRatingTap?.call(ratingIdentifier),
              ),
              const SizedBox(
                width: 5,
              ),
              _buildRating(
                averageRating,
                iconData: BetterUnited.meh,
                onTap: (ratingIdentifier) =>
                    onRatingTap?.call(ratingIdentifier),
              ),
              const SizedBox(
                width: 5,
              ),
              _buildRating(
                goodRating,
                iconData: BetterUnited.smile,
                onTap: (ratingIdentifier) =>
                    onRatingTap?.call(ratingIdentifier),
              ),
              const SizedBox(
                width: 5,
              ),
              _buildRating(
                excellentRating,
                iconData: BetterUnited.starsHappy,
                onTap: (ratingIdentifier) =>
                    onRatingTap?.call(ratingIdentifier),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SecondaryButton.labelText(
          "notNow".tr().toUpperCase(),
          withUnderline: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _buildRating(String ratingIdentifier,
      {required Function(String) onTap, required IconData iconData}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap.call(ratingIdentifier),
        child: Icon(
          iconData,
          size: 30,
          shadows: const [
            Shadow(
              color: Color(0XFF0000007F),
              offset: Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
      ),
    );
  }
}

_logAnalyticEvent(String rating) {
  analytics.logEvent(
    name: "User_rating_entry",
    parameters: {
      "rating": rating,
    },
  );
}

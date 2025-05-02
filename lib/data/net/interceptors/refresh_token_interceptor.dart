import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/net/auth_manager.dart';
import 'package:flutter_better_united/util/exceptions/custom_exceptions.dart';
import 'package:flutter_better_united/util/navigation_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../flavors.dart';
import '../../../pages/login/login_page.dart';
import '../../../run.dart';
import '../../../util/ui_util.dart';
import '../models/auth_response.dart';
import 'error_interceptor.dart';

class RefreshTokenInterceptor extends QueuedInterceptor {
  final AuthenticatorManager _authenticatorManager;
  final NavigationService _navigationService;
  final Dio dio;
  final int maximumRetryAttempts = 3;
  final Duration retryDelay = const Duration(seconds: 2);

  //  dio instance to request token
  final Dio tokenDio = Dio();
  static const String authHeader = "Authorization";

  RefreshTokenInterceptor(
      this.dio, this._authenticatorManager, this._navigationService) {
    tokenDio.interceptors.add(ErrorInterceptor());
    tokenDio.interceptors.add(PrettyDioLogger());
    tokenDio.options = dio.options;
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    bool isRefreshRequired =
        await _authenticatorManager.getAccessToken() != null;
    bool isRequestPublic =
        err.requestOptions.extra.containsKey("requiresToken") &&
            err.requestOptions.extra["requiresToken"] == false;

    if (!isRequestPublic &&
        isRefreshRequired &&
        (err.response?.statusCode == 401)) {
      int retryAttempts = 0;
      while (retryAttempts < maximumRetryAttempts) {
        logger.i("attempting to refresh token (Attempt ${retryAttempts + 1})");
        AuthResponse? authResponse;
        try {
          authResponse = await _refreshToken();
        } on RefreshTokenExpiredException catch (_) {
          logger.i("refresh token invalid/expired");
          final context = _navigationService.navigatorKey.currentContext;
          if (context != null) {
            showToast("accessTokenExpired".tr());
            await _authenticatorManager.removeAuthenticationCredentials();
            Navigator.of(context)
                .pushNamedAndRemoveUntil(LoginPage.route, (route) => false);
            return handler.next(err);
          }
        }

        if (authResponse != null) {
          logger.i("token successfully refreshed");
          _authenticatorManager.setAccessToken(authResponse.accessToken);
          _authenticatorManager.setRefreshToken(authResponse.refreshToken);
          return _retryRequest(err, handler, authResponse.accessToken);
        } else {
          if ((retryAttempts + 1) != maximumRetryAttempts) {
            logger.i(
                "refresh token failed, attempting to retry after $retryDelay");
            await Future.delayed(retryDelay);
          }
        }
        retryAttempts++;
      }
      logger.i("refresh token failed");
    }
    return handler.next(err);
  }

  _retryRequest(DioError dioError, ErrorInterceptorHandler handler,
      String accessToken) async {
    dioError.requestOptions.headers.addAll({authHeader: "Bearer $accessToken"});
    final opts = Options(
        method: dioError.requestOptions.method,
        headers: dioError.requestOptions.headers);
    try {
      final cloneReq = await tokenDio.request(dioError.requestOptions.path,
          options: opts,
          data: dioError.requestOptions.data,
          queryParameters: dioError.requestOptions.queryParameters);
      return handler.resolve(cloneReq);
    } on DioError catch (error) {
      return handler.next(error);
    }
  }

  Future<AuthResponse?> _refreshToken() async {
    final refreshToken = await _authenticatorManager.getRefreshToken();
    if (refreshToken == null) return null;
    try {
      final response = await tokenDio.post('/auth/login', data: {
        "grant_type": "refresh_token",
        "client_id": F.clientId,
        "refresh_token": refreshToken
      });
      if (response.statusCode == 200) {
        return AuthResponse.fromJson(response.data);
      }
      return null;
    } catch (e) {
      if (e is DioError &&
          e.type == DioErrorType.response &&
          e.response?.statusCode == 400) {
        throw RefreshTokenExpiredException();
      }
      FirebaseCrashlytics.instance.recordError(e, null);
      return null;
    }
  }
}
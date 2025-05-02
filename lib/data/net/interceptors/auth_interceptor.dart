import 'package:dio/dio.dart';
import 'package:flutter_better_united/data/net/auth_manager.dart';

class AuthInterceptor extends Interceptor {
  final AuthenticatorManager _authenticatorManager;
  final Dio dio;
  static const String authHeader = "Authorization";

  AuthInterceptor(this.dio, this._authenticatorManager);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.extra.containsKey("requiresToken") &&
        options.extra["requiresToken"] == false) {
      return handler.next(options);
    }

    String? token = await _authenticatorManager.getAccessToken();
    if (token != null) {
      options.headers.addAll({authHeader: "Bearer $token"});
    }
    return handler.next(options);
  }
}

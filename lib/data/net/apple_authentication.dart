import 'package:flutter_better_united/data/enum/grant_type.dart';
import 'package:flutter_better_united/data/net/api_service.dart';
import 'package:flutter_better_united/data/net/auth_result.dart';
import 'package:flutter_better_united/data/net/models/auth_request.dart';
import 'package:flutter_better_united/data/net/token_authentication.dart';
import 'package:flutter_better_united/run.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../flavors.dart';
import 'interceptors/error_interceptor.dart';

class AppleAuthentication extends TokenAuthentication {
  AppleAuthentication(ApiService restClient) : super(restClient);
  static const String appleSignInServiceId = "nl.betterunited.web";

  @override
  Future<AuthResult> loginWithToken() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
              clientId: appleSignInServiceId,
              redirectUri: Uri.parse("${F.baseUrl}/auth/apple-callback")));

      final idToken = credential.identityToken;
      logger.e(credential.identityToken);
      if (idToken != null) {
        Map<String, dynamic> payload = Jwt.parseJwt(idToken);
        final authResponse = await restClient
            .login(AuthRequest(GrantType.appleToken, appleIdToken: idToken));
        return AuthResult.success(
            email: payload["email"], authResponse: authResponse);
      }
      return AuthResult.failed();
    } on SignInWithAppleAuthorizationException catch (e) {
      switch (e.code) {
        case AuthorizationErrorCode.canceled:
          return AuthResult.canceled();
        case AuthorizationErrorCode.failed:
        case AuthorizationErrorCode.invalidResponse:
        case AuthorizationErrorCode.notHandled:
        case AuthorizationErrorCode.notInteractive:
        case AuthorizationErrorCode.unknown:
          return AuthResult.failed();
      }
    } on BadRequestException {
      return AuthResult.accountNotFound();
    } catch (exception) {
      logger.e(exception);
      return AuthResult.failed();
    }
  }
}

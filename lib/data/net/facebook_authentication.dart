import 'package:flutter_better_united/data/enum/grant_type.dart';
import 'package:flutter_better_united/data/net/api_service.dart';
import 'package:flutter_better_united/data/net/auth_result.dart';
import 'package:flutter_better_united/data/net/models/auth_request.dart';
import 'package:flutter_better_united/data/net/token_authentication.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'interceptors/error_interceptor.dart';

class FacebookAuthentication extends TokenAuthentication {
  FacebookAuthentication(ApiService restClient) : super(restClient);

  @override
  Future<AuthResult> loginWithToken() async {
    final LoginResult result = await FacebookAuth.instance.login();
    switch (result.status) {
      case LoginStatus.success:
        final AccessToken accessToken = result.accessToken!;
        final userData = await FacebookAuth.instance.getUserData();
        try {
          final authResponse = await restClient.login(AuthRequest(
              GrantType.facebookToken,
              facebookToken: accessToken.token));
          return AuthResult.success(
              email: userData["email"], authResponse: authResponse);
        } on BadRequestException {
          return AuthResult.accountNotFound();
        } catch (e) {
          return AuthResult.failed();
        }

      case LoginStatus.cancelled:
        return AuthResult.canceled();
      case LoginStatus.failed:
        return AuthResult.failed();
      case LoginStatus.operationInProgress:
        return AuthResult.inProgress();
    }
  }
}

import 'package:flutter_better_united/data/enum/grant_type.dart';
import 'package:flutter_better_united/data/net/auth_result.dart';
import 'package:flutter_better_united/data/net/models/auth_request.dart';
import 'package:flutter_better_united/data/net/token_authentication.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'api_service.dart';
import 'interceptors/error_interceptor.dart';

class GoogleAuthentication extends TokenAuthentication {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  GoogleAuthentication(ApiService restClient) : super(restClient);

  @override
  Future<AuthResult> loginWithToken() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      final authentication = await googleSignInAccount?.authentication;
      final idToken = authentication?.idToken;
      final email = googleSignInAccount?.email;
      if (email != null && idToken != null) {
        final authResponse = await restClient
            .login(AuthRequest(GrantType.googleToken, googleIdToken: idToken));
        return AuthResult.success(email: email, authResponse: authResponse);
      }
      return AuthResult.canceled();
    } on BadRequestException {
      return AuthResult.accountNotFound();
    } catch (e) {
      return AuthResult.failed();
    }
  }
}

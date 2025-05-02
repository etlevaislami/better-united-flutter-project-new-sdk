import 'package:flutter_better_united/data/net/token_authentication.dart';

import 'models/auth_response.dart';

class AuthResult {
  final AuthStatus loginStatus;
  final String? email;
  final AuthResponse? authResponse;

  AuthResult.failed() : this(AuthStatus.failed);

  AuthResult.canceled() : this(AuthStatus.cancelled);

  AuthResult.inProgress() : this(AuthStatus.operationInProgress);

  AuthResult.accountNotFound() : this(AuthStatus.accountNotFound);

  AuthResult.success({required String email, required authResponse})
      : this(AuthStatus.success, email: email, authResponse: authResponse);

  AuthResult(this.loginStatus, {this.email, this.authResponse});
}

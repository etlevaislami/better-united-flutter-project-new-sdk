import 'package:flutter_better_united/data/net/auth_result.dart';

import 'api_service.dart';

enum AuthStatus {
  success,
  cancelled,
  failed,
  operationInProgress,
  invalidCredentials,
  accountNotFound
}

abstract class TokenAuthentication {
  final ApiService restClient;

  TokenAuthentication(this.restClient);

  Future<AuthResult> loginWithToken();
}

import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_better_united/util/ui_util.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/net/auth_manager.dart';
import '../../data/net/token_authentication.dart';

enum LoginEvent { idle, success, createProfile }

class LoginProvider with ChangeNotifier {
  String? validationMessage;
  bool isLoginAllowed = false;
  final AuthenticatorManager _authenticatorManager;
  String email = "";
  String password = "";
  final BehaviorSubject<LoginEvent> redirectionEvent =
      BehaviorSubject<LoginEvent>();

  LoginProvider(this._authenticatorManager);

  validate() {
    isLoginAllowed = EmailValidator.validate(email) && password.isNotEmpty;
    validationMessage = null;
    notifyListeners();
  }

  loginWithFacebook() {
    login(_authenticatorManager.loginWithFacebook());
  }

  loginWithGoogle() {
    login(_authenticatorManager.loginWithGoogle());
  }

  loginWithApple() {
    login(_authenticatorManager.loginWithApple());
  }

  loginWithCredentials() {
    login(_authenticatorManager.loginWithPassword(email, password));
  }

  login(Future<AuthStatus> login) async {
    try {
      beginLoading();
      final loginStatus = await login;

      switch (loginStatus) {
        case AuthStatus.cancelled:
        case AuthStatus.operationInProgress:
          return;
        case AuthStatus.accountNotFound:
          showError("accountNotFound".tr());
          return;
        case AuthStatus.failed:
          showError("unknownError".tr());
          return;
        case AuthStatus.invalidCredentials:
          validationMessage = "invalidCredentials".tr();
          isLoginAllowed = false;
          notifyListeners();
          return;
        case AuthStatus.success:
          //continue
          break;
      }

      if (_authenticatorManager.isProfileCompleted()) {
        redirectionEvent.value = LoginEvent.success;
      } else {
        redirectionEvent.value = LoginEvent.createProfile;
      }
    } catch (exception) {
      showGenericError(exception);
    } finally {
      endLoading();
    }
  }

  @override
  void dispose() {
    redirectionEvent.close();
    super.dispose();
  }
}

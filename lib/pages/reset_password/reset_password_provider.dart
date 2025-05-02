import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_better_united/util/ui_util.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/net/auth_manager.dart';
import '../../run.dart';
import '../../util/exceptions/custom_exceptions.dart';

class ResetPasswordProvider with ChangeNotifier {
  final AuthenticatorManager authenticatorManager;
  final String userId;
  final String token;
  final BehaviorSubject<bool> redirectionEvent = BehaviorSubject<bool>();
  String? validationMessage;
  bool isResetPasswordAllowed = false;
  String password = "";
  String confirmPassword = "";

  ResetPasswordProvider(this.authenticatorManager, this.userId, this.token);

  void resetPassword() {
    if (!checkPasswordCombination()) {
      validationMessage = "passwordNotMatch".tr();
      isResetPasswordAllowed = false;
      notifyListeners();
      return;
    }

    beginLoading();
    authenticatorManager.resetPassword(userId, token, password).then((value) {
      redirectionEvent.value = true;
      endLoading();
    }).catchError((error, stackTrace) {
      switch (error.runtimeType) {
        case ServiceUnavailableException:
          {
            showToast("service_unavailable".tr());
          }
          break;
        default:
          {
            logger.e(error);
            showToast("apiErrorTitle".tr());
          }
          break;
      }
      endLoading();
    });
  }

  validate() {
    isResetPasswordAllowed =
        confirmPassword.isNotEmpty && password.characters.length >= 8;
    validationMessage = null;
    notifyListeners();
  }

  bool checkPasswordCombination() {
    return password == confirmPassword;
  }

  @override
  void dispose() {
    redirectionEvent.close();
    super.dispose();
  }
}

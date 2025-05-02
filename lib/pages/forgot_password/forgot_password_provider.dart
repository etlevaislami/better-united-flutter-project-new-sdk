import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_better_united/util/ui_util.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/net/auth_manager.dart';
import '../../data/net/interceptors/error_interceptor.dart';

class ForgotPasswordProvider with ChangeNotifier {
  final AuthenticatorManager _authenticatorManager;
  final BehaviorSubject<bool> redirectionEvent = BehaviorSubject<bool>();
  bool isForgotPasswordAllowed = false;
  String email = "";

  ForgotPasswordProvider(this._authenticatorManager);

  void sendEmail() {
    beginLoading();
    _authenticatorManager.forgotPassword(email).then((value) {
      endLoading();
      redirectionEvent.value = true;
    }).catchError((error, stackTrace) {
      switch (error.runtimeType) {
        case NotFoundException:
          {
            // even though email is not found we intentionally navigate to success screen in order to not give any info to 3rd users about registered e-mail addresses.
            endLoading();
            redirectionEvent.value = true;
          }
          break;
        default:
          {
            endLoading();
            redirectionEvent.value = false;
            showGenericError(error);
          }
          break;
      }
    });
  }

  validate() {
    isForgotPasswordAllowed = EmailValidator.validate(email);
    notifyListeners();
  }

  @override
  void dispose() {
    redirectionEvent.close();
    super.dispose();
  }
}

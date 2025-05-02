// ignore_for_file: unused_field

import 'package:easy_localization/src/public_ext.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_better_united/data/net/interceptors/error_interceptor.dart';
import 'package:flutter_better_united/util/ui_util.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/net/auth_manager.dart';
import '../../data/repo/profile_repository.dart';

class RegisterProvider with ChangeNotifier {
  String? emailValidationMessage;
  String? passwordValidationMessage;
  String? privacyValidationMessage;
  String? termsValidationMessage;
  String? termsAndPrivacyValidationMessage;
  bool isRegisterAllowed = false;
  String email = "";
  String password = "";
  String confirmPassword = "";
  bool isTermsAccepted = false;
  bool isPrivacyAccepted = false;
  final AuthenticatorManager _authenticatorManager;
  final ProfileRepository _profileRepository;

  RegisterProvider(this._authenticatorManager, this._profileRepository);

  final BehaviorSubject<String> redirectionEvent = BehaviorSubject<String>();

  void register() async {
    _validateFields();

    if (!isRegisterAllowed) {
      notifyListeners();
      return;
    }

    beginLoading();
    _authenticatorManager
        .register(email, password)
        .then((_) {
      redirectionEvent.value = email;
      endLoading();
    }).catchError((error, stackTrace) {
      switch (error.runtimeType) {
        case ConflictException:
          {
            emailValidationMessage = "emailAlreadyUsed".tr();
            notifyListeners();
          }
          break;
        default:
          {
            showGenericError(error);
          }
          break;
      }
      endLoading();
    });
  }

  bool _checkEmailFormat() {
    return EmailValidator.validate(email);
  }

  bool _checkPasswordCombination() {
    return password == confirmPassword;
  }

  _validateFields() {
    if (!_checkEmailFormat()) {
      emailValidationMessage = "invalidEmailAddress".tr();
      isRegisterAllowed = false;
    } else {
      emailValidationMessage = null;
    }

    if (!_checkPasswordCombination()) {
      passwordValidationMessage = "passwordNotMatch".tr();
      isRegisterAllowed = false;
    } else {
      passwordValidationMessage = null;
    }
    final missingAggeementTexts = [];

    if (!isTermsAccepted) {
      missingAggeementTexts.add("termsAndCondition".tr().toLowerCase());
      termsValidationMessage = "termsNotAccepted".tr();
      isRegisterAllowed = false;
    }

    if (!isPrivacyAccepted) {
      missingAggeementTexts.add("privacyPolicy".tr().toLowerCase());
      isRegisterAllowed = false;
      privacyValidationMessage = "privacyNotAccepted".tr();
    }

    if (missingAggeementTexts.isNotEmpty) {
      termsAndPrivacyValidationMessage = "pleaseAgreeTo".tr() +
          " " +
          missingAggeementTexts.join(" " + "and".tr() + " ") +
          ".";
    } else {
      termsAndPrivacyValidationMessage = null;
    }
  }

  updateTermSwitch(bool value) {
    isTermsAccepted = value;
    validate();
  }

  updatePrivacySwitch(bool value) {
    isPrivacyAccepted = value;
    validate();
  }

  validate() {
    isRegisterAllowed =
        email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty;
    notifyListeners();
  }

  @override
  void dispose() {
    redirectionEvent.close();
    super.dispose();
  }
}

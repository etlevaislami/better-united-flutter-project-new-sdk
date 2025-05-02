import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../data/net/interceptors/error_interceptor.dart';
import '../run.dart';

beginLoading() {
  EasyLoading.show();
}

hiddenLoading() {
  EasyLoading.show(
    dismissOnTap: false,
    indicator: const SizedBox(),
    maskType: EasyLoadingMaskType.clear,
  );
}

endLoading() {
  EasyLoading.dismiss();
}

showSuccess(String status) {
  EasyLoading.showSuccess(status);
}

showError(String status) {
  showToast(status);
}

showGenericError(Object? error) {
  logger.e(error);
  if (error is UnauthorizedException) {
    return;
  }
  showError("unknownError".tr());
  FirebaseCrashlytics.instance.recordError(error, null);
}

showToast(String toast) {
  Fluttertoast.showToast(
    msg: toast,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    textColor: Colors.white,
  );
}

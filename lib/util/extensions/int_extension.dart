import 'package:easy_localization/easy_localization.dart';

extension IntExtension on int? {
  bool toBool() {
    if (this == null) {
      return false;
    }
    return this == 0 ? false : true;
  }

  String formatNumber() {
    //@todo: remove locale and use nl_EN by default
    return NumberFormat.decimalPattern("nl_EN").format(this);
  }
}

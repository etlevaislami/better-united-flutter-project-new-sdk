extension BoolExtension on bool? {
  int? toInt() {
    final value = this;
    if (value == null) {
      return null;
    }
    return value ? 1 : 0;
  }
}

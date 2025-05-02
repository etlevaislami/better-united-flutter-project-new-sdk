extension StringExtension on String {
  removeTrailingZeros() {
    return replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
  }
}

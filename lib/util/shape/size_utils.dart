import 'package:flutter/material.dart';

extension SizeExtensions on Size {
  Size addPadding(EdgeInsets padding) {
    return Size(
      width + padding.horizontal,
      height + padding.vertical,
    );
  }
}
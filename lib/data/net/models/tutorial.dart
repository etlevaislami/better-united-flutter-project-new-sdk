import 'package:flutter/material.dart';

class Tutorial {
  final String title;
  final String content;
  final int verticalPosition;
  final GlobalKey visibleWidgetKey;
  final Path Function(Offset, Size) buildPath;
  final TapType tapType;

  Tutorial(this.title, this.content, this.verticalPosition, this.visibleWidgetKey, this.buildPath, {this.tapType = TapType.anywhere});
}

/// All types of tap events for continuing to next tutorial.
enum TapType {
  /// Click anywhere on screen to continue
  anywhere,
  /// Click widget to continue
  onWidget,
  /// Click done button to continue
  onDoneButton;
}

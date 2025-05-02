import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class ModalBackgroundWidget extends StatelessWidget {
  const ModalBackgroundWidget({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      color: AppColors.primaryColor,
      child: Container(
          decoration: const BoxDecoration(
            color: AppColors.pearlPowder,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: child),
    );
  }
}

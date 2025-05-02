import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';

import '../figma/colors.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            height: 1,
            color: AppColors.buttonInnactive,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Text("or".tr(), style: context.labelRegular),
        const SizedBox(
          width: 12,
        ),
        const Expanded(
          child: Divider(
            height: 1,
            color: AppColors.buttonInnactive,
          ),
        )
      ],
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';

import 'carousel.dart';

class RulesWidget extends StatelessWidget {
  const RulesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "rulesOfPoule".tr().toUpperCase(),
              style: context.bodyBold.copyWith(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Carousel(),
      ],
    );
  }
}

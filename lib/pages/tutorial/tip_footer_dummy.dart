import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_colors.dart';

class TipFooter extends StatelessWidget {
  const TipFooter({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 1,
          color: AppColors.lightHouse,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/images/ic_like.svg",
                color: AppColors.christmasSilver,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "1.5K",
                  style: context.titleLarge,
                ).fontSize(12),
              ),
              SvgPicture.asset(
                "assets/images/ic_watch.svg",
                color: AppColors.christmasSilver,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "45",
                  style: context.titleLarge,
                ).fontSize(12),
              ),
              Expanded(
                child: child,
              )
            ],
          ),
        ),
      ],
    );
  }
}

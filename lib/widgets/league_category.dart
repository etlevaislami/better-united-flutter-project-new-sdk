import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_colors.dart';

class LeagueCategory extends StatelessWidget {
  final String text;
  final Widget child;
  final bool isActive;
  final int? matches;
  final bool useOpacity;
  final GestureTapCallback? onInfoTap;

  const LeagueCategory({
    Key? key,
    required this.text,
    required this.child,
    this.isActive = false,
    this.matches,
    this.useOpacity = true,
    this.onInfoTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: (!useOpacity || useOpacity && isActive) ? 1 : 0.5,
      child: Stack(
        children: [
          Container(
            width: context.width * 0.3,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: isActive ? AppColors.mysticGreen : Colors.transparent,
                  width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: child,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: context.labelSmall?.copyWith(letterSpacing: 0.1),
                  ),
                ),
                matches == null
                    ? const SizedBox()
                    : Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: double.infinity,
                        child: Text(
                          "matchesArgs".plural(matches ?? 0),
                          style: context.labelSmall?.copyWith(
                              letterSpacing: 0.1,
                              color: AppColors.dollarBill,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
              ],
            ),
          ),
          onInfoTap == null
              ? const SizedBox()
              : GestureDetector(
                  onTap: onInfoTap,
                  child: Container(
                    margin: const EdgeInsets.only(left: 5, top: 5),
                    child: SvgPicture.asset(
                      "assets/icons/ic_info.svg",
                      height: 24,
                      color: AppColors.christmasSilver,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

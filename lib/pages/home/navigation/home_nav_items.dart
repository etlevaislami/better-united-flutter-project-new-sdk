import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/app_colors.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class HomeNavItems {
  static List<ItemConfig> getNavItems({
    GlobalKey? homeIconKey,
    GlobalKey? rankingIconKey,
    GlobalKey? shopIconKey,
    GlobalKey? profileIconKey,
  }) {
    return [
      ItemConfig(
        icon: Icon(key: homeIconKey, BetterUnited.home),
        iconSize: 25,
        activeForegroundColor: AppColors.primaryColor,
        inactiveForegroundColor: const Color(0xff9A9A9A),
      ),
      ItemConfig(
        icon: Icon(key: rankingIconKey, BetterUnited.ranking),
        activeForegroundColor: AppColors.primaryColor,
        iconSize: 25,
        inactiveForegroundColor: const Color(0xff9A9A9A),
      ),
      ItemConfig(
        icon: Stack(
          key: shopIconKey,
          fit: StackFit.passthrough,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Icon(BetterUnited.shop),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3, right: 1),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            )
          ],
        ),
        activeForegroundColor: AppColors.primaryColor,
        iconSize: 25,
        inactiveBackgroundColor: const Color(0xff9A9A9A),
      ),
      ItemConfig(
        icon: Icon(key: profileIconKey, BetterUnited.profile),
        activeForegroundColor: AppColors.primaryColor,
        iconSize: 25,
        inactiveForegroundColor: const Color(0xff9A9A9A),
      ),
    ];
  }
}

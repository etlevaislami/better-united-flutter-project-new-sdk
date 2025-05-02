import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import '../../widgets/button.dart';

class RefillCoinDialog extends StatelessWidget {
  const RefillCoinDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Align(
                alignment: const FractionalOffset(0.5, -0.8),
                child: SvgPicture.asset("assets/icons/ic_shimmer.svg",
                    width: context.width),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: const FractionalOffset(0.5, -1.4),
                child: SvgPicture.asset(
                  "assets/icons/ic_modal_icon_background",
                  height: context.width * 0.7,
                ),
              ),
            ),
            Positioned(
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20, top: 70, right: 20, bottom: 0),
                margin: const EdgeInsets.only(top: 76.5, right: 35, left: 35),
                width: context.width,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "weeklyBonusTitle".tr(),
                      style: context.titleLarge,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        "weeklyBonusSubtitle".tr(),
                        style: context.titleSmall?.copyWith(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Button(
                      foregroundColor: AppColors.forgedSteel,
                      backgroundColor: AppColors.goldenHandshake,
                      text: "ok".tr(),
                      onPressed: () => context.pop(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 5,
              left: 20,
              right: 0,
              child: Align(
                child: SvgPicture.asset(
                  "assets/icons/ic_wallet.svg",
                  width: context.width * 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_colors.dart';
import '../../data/net/models/tutorial.dart';
import '../../widgets/button.dart';

class TutorialCard extends StatelessWidget {
  const TutorialCard(
      {Key? key,
      required this.tutorial,
      this.child,
      this.isLast = false,
      required this.onButtonClick,
      required this.onSkipTutorialClick})
      : super(key: key);

  final Tutorial tutorial;
  final Widget? child;
  final bool isLast;
  final VoidCallback onButtonClick;
  final GestureTapCallback onSkipTutorialClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: Transform.translate(
                    offset: const Offset(20, 40),
                    child: SvgPicture.asset(
                      "assets/images/img_coach_tip_neutral.svg",
                      height: 200,
                    )),
              ),
              isLast
                  ? const SizedBox()
                  : Positioned(
                      right: 24,
                      bottom: 10,
                      child: GestureDetector(
                        onTap: onSkipTutorialClick,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          width: 160,
                          height: 48,
                          child: Text(
                            "skipTutorial".tr(),
                            style: context.titleMedium
                                ?.copyWith(color: AppColors.dollarBill),
                          ),
                        ),
                      ))
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 24, right: 24),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 27, vertical: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tutorial.title,
                      style: context.titleLarge
                          ?.copyWith(color: AppColors.forgedSteel),
                    ),
                    Text(
                      tutorial.content,
                      style: context.titleSmall?.copyWith(
                          height: 2, color: AppColors.tundora, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    child: child,
                    clipBehavior: Clip.none,
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 27),
                child: SizedBox(
                  height: 48,
                  child: Button(
                      fontSize: 16,
                      onPressed: onButtonClick,
                      text: isLast ? "done".tr() : "next".tr()),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

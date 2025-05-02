import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/figma/shadows.dart';
import 'package:flutter_better_united/pages/nav_page.dart';
import 'package:flutter_better_united/pages/profile/create_profile_provider.dart';
import 'package:flutter_better_united/pages/tutorial/tutorial_launcher_page.dart';
import 'package:flutter_better_united/pages/tutorial/tutorial_consts.dart';
import 'package:flutter_better_united/widgets/coach_profile_widget.dart';
import 'package:flutter_better_united/widgets/language_widget.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/secondary_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../constants/app_colors.dart';
import '../../run.dart';

class StartTutorialPage extends StatelessWidget {
  const StartTutorialPage({Key? key}) : super(key: key);
  static const route = "/start-tutorial";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Not able to go back, use is able to choose 'skip' on the page.
        return false;
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        alignment: Alignment.bottomCenter,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 45.0),
                child: SvgPicture.asset(
                  "assets/figma/svg/components/bg_tutorial_gradient_shape.svg",
                ),
              ),
            ),
            Align(
              alignment: const FractionalOffset(0.5, 0.1),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  boxShadow: [AppShadows.outerGlowIcon],
                ),
                child: SvgPicture.asset(
                  "assets/icons/ic_all_leagues.svg",
                  color: AppColors.primaryColor,
                  height: 100,
                ),
              ),
            ),
            Align(
              alignment: const FractionalOffset(0, 1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CoachProfileWidget(coachState: CoachState.neutral),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    margin:
                        const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "tutorial_start_description".tr(),
                            textAlign: TextAlign.center,
                            style: context.titleSmall?.copyWith(
                                height: 1.5, color: Colors.white, fontSize: 12),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const LanguageWidget(
                          fromRoute: route,
                        ),
                        PrimaryButton(
                            onPressed: () => _onStartTutorial(context),
                            text: "discoverMore".tr()),
                        const SizedBox(
                          height: 10,
                        ),
                        SimpleShadow(
                          opacity: 1,
                          color: AppColors.shadow,
                          offset: const Offset(0, 0),
                          sigma: 5,
                          child: SecondaryButton.labelText(
                            "skipTutorial".tr(),
                            withUnderline: true,
                            onPressed: () => _onSkipTutorial(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onStartTutorial(BuildContext context) async {
    await context.pushNamed(TutorialLauncherPage.route);
    context.pop();
  }

  _onSkipTutorial(BuildContext context) {
    analytics.logEvent(
        name: TutorialUtils.tutorialSkipEvent, parameters: {TutorialUtils.stepParamKey: TutorialUtils.welcomeStep});
    Navigator.of(context)
        .pushNamedAndRemoveUntil(NavPage.route, (route) => false);
  }
}

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/pages/login/login_page.dart';
import 'package:flutter_better_united/pages/nav_page.dart';
import 'package:flutter_better_united/pages/profile/select_birthdate_page.dart';
import 'package:flutter_better_united/pages/profile/select_favorite_club_page.dart';
import 'package:flutter_better_united/pages/profile/select_nickname_page.dart';
import 'package:flutter_better_united/pages/profile/select_picture_page.dart';
import 'package:flutter_better_united/pages/tutorial/start_tutorial_page.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../run.dart';
import 'create_profile_provider.dart';

class CreateProfilePage extends StatefulWidget {
  static const String route = '/create-profile';

  const CreateProfilePage({Key? key}) : super(key: key);

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final PageController _controller = PageController();
  final List<Widget> _pages = [
    const SelectNicknamePage(),
    const SelectBirthdatePage(),
    SelectPicturePage(),
    const SelectFavoriteClubsPage(),
  ];
  late final ProfileProvider _createProfileProvider;

  @override
  void initState() {
    super.initState();
    _createProfileProvider =
        ProfileProvider(context.read(), context.read(), context.read());
    _observeStepChanges();
    _logProfileCreationStepEvent(
        ProfileStep.values[_createProfileProvider.currentStepIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _createProfileProvider,
      child: Selector<ProfileProvider, int>(
          selector: (p0, p1) => p1.currentStepIndex,
          builder: (context, step, child) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: RegularAppBar.fromModal(
                onCloseTap: () {
                  _logProfileCreationCancelledEvent(ProfileStep
                      .values[_createProfileProvider.currentStepIndex]);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginPage.route, (route) => false);
                },
                title: step == ProfileStep.favoriteClubsStep.index
                    ? "favoriteClubs".tr()
                    : "createProfile".tr(),
              ),
              body: SafeArea(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: [
                        _buildBody(),
                        _buildStepper(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _buildStepper() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Selector<ProfileProvider, int>(
            selector: (p0, p1) => p1.currentStepIndex,
            builder: (context, stepIndex, child) => StepProgressIndicator(
              currentStep: stepIndex + 1,
              size: 8,
              padding: 2,
              selectedColor: AppColors.primary,
              unselectedColor: AppColors.secondary,
              customStep: (index, _, ___) {
                if (index == stepIndex) {
                  return const _ActiveStep();
                } else if (index < stepIndex) {
                  return const _PreviousStep();
                } else {
                  return const _NextStep();
                }
              },
              totalSteps: _pages.length,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: _pages,
      ),
    );
  }

  _observeStepChanges() async {
    _createProfileProvider.redirectionSubject.listen((event) async {
      _logProfileCreationStepEvent(event);
      if (event == ProfileStep.successStep) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(StartTutorialPage.route, (route) => false);
      } else {
        FocusScope.of(context).requestFocus(FocusNode());
        _controller.jumpToPage(event.index);
      }
    });
  }
}

const profileCreationEvent = "PROFILE_CREATION_STEP";
const profileCreationSuccessEvent = "PROFILE_CREATION_SUCCESS";
const profileCreationCancelledEvent = "PROFILE_CREATION_CANCELLED";

const stepParamKey = "step";
const nameStep = "NAME";
const ageStep = "AGE";
const profilePictureStep = "PROFILE_PICTURE";
const favoriteClubsStep = "FAVORITE_CLUBS";

_logProfileCreationStepEvent(ProfileStep event) async {
  switch (event) {
    case ProfileStep.nicknameStep:
      await analytics.logEvent(
        name: profileCreationEvent,
        parameters: {
          stepParamKey: nameStep,
        },
      );
      break;
    case ProfileStep.birthdateStep:
      await analytics.logEvent(
        name: profileCreationEvent,
        parameters: {
          stepParamKey: ageStep,
        },
      );
      break;
    case ProfileStep.photoStep:
      await analytics.logEvent(
        name: profileCreationEvent,
        parameters: {
          stepParamKey: profilePictureStep,
        },
      );
      break;
    case ProfileStep.successStep:
      await analytics.logEvent(name: profileCreationSuccessEvent);
      break;
    case ProfileStep.favoriteClubsStep:
      await analytics.logEvent(
        name: profileCreationEvent,
        parameters: {
          stepParamKey: favoriteClubsStep,
        },
      );
      break;
  }
}

_logProfileCreationCancelledEvent(ProfileStep event) async {
  switch (event) {
    case ProfileStep.nicknameStep:
      await analytics.logEvent(
        name: profileCreationCancelledEvent,
        parameters: {
          stepParamKey: nameStep,
        },
      );
      break;
    case ProfileStep.birthdateStep:
      await analytics.logEvent(
        name: profileCreationCancelledEvent,
        parameters: {
          stepParamKey: ageStep,
        },
      );
      break;
    case ProfileStep.photoStep:
      await analytics.logEvent(
        name: profileCreationCancelledEvent,
        parameters: {
          stepParamKey: profilePictureStep,
        },
      );
      break;
    case ProfileStep.successStep:
      await analytics.logEvent(name: profileCreationSuccessEvent);
      break;
    case ProfileStep.favoriteClubsStep:
      await analytics.logEvent(
        name: profileCreationCancelledEvent,
        parameters: {
          stepParamKey: favoriteClubsStep,
        },
      );
      break;
  }
}

class _ActiveStep extends StatelessWidget {
  const _ActiveStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: const Color(0xff9A9A9A),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.primary,
            Color(0xFF727272),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(154, 227, 67, 0.24),
            blurRadius: 24,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
    );
  }
}

class _PreviousStep extends StatelessWidget {
  const _PreviousStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: AppColors.primary,
      ),
    );
  }
}

class _NextStep extends StatelessWidget {
  const _NextStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: AppColors.secondary,
      ),
    );
  }
}

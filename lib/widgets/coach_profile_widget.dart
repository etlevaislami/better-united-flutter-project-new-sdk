import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';

import '../pages/profile/create_profile_provider.dart';

class CoachProfileWidget extends StatelessWidget {
  const CoachProfileWidget({Key? key, required this.coachState})
      : super(key: key);
  final CoachState coachState;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.height * 0.3,
      height: context.height * 0.3,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: buildCoachImage(coachState),
        ),
      ),
    );
  }

  AssetImage buildCoachImage(CoachState coachState) {
    late String assetName;
    switch (coachState) {
      case CoachState.happy:
        assetName = "assets/images/img_coach_happy.png";
        break;
      case CoachState.sad:
        assetName = assetName = "assets/images/img_coach_sad.png";
        break;
      case CoachState.neutral:
      default:
        assetName = assetName = "assets/images/img_coach_neutral.png";
        break;
    }
    return AssetImage(
      assetName,
    );
  }
}

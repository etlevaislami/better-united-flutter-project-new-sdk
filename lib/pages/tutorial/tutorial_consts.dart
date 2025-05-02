import 'package:flutter_better_united/run.dart';



class TutorialUtils {
  static const int homeIndex = 0;
  static const int friendLeague = 1;
  static const int createATip = 2;
  static const int shopIndex = 3;
  static const int moreTeam = 4;
  static const int revealTip = 5;
  static const tutorialStartedStepEvent = "TUTORIAL_STARTED";
  static const tutorialStepEvent = "TUTORIAL_STEP";
  static const tutorialSkipEvent = "TUTORIAL_SKIP";
  static const tutorialCompletedEvent = "TUTORIAL_COMPLETED";
  static const stepParamKey = "step";
  static const welcomeStep = "WELCOME";
  static const homeStep = "HOME";
  static const friendLeagueStep = "FRIENDS LEAGUE";
  static const createTipStep = "CREATE A TIP";
  static const shopStep = "SHOP";
  static const moreStep = "MORE";
  static const revealTipStep = "REVEAL A TIP";

  static logTutorialStepAnalyticEvents(int index) async {
    switch (index) {
      case homeIndex:
        analytics.logEvent(
          name: tutorialStepEvent,
          parameters: {
            stepParamKey: homeStep,
          },
        );
        break;
      case friendLeague:
        analytics.logEvent(
          name: tutorialStepEvent,
          parameters: {
            stepParamKey: friendLeagueStep,
          },
        );
        break;
      case createATip:
        analytics.logEvent(
          name: tutorialStepEvent,
          parameters: {
            stepParamKey: createTipStep,
          },
        );
        break;

      case shopIndex:
        analytics.logEvent(
          name: tutorialStepEvent,
          parameters: {
            stepParamKey: shopStep,
          },
        );
        break;

      case moreTeam:
        analytics.logEvent(
          name: tutorialStepEvent,
          parameters: {
            stepParamKey: moreStep,
          },
        );
        break;

      case revealTip:
        analytics.logEvent(
          name: tutorialStepEvent,
          parameters: {
            stepParamKey: revealTipStep,
          },
        );
        break;
    }
  }

  static logTutorialSkippedStepAnalyticEvents(int index) async {
    switch (index) {
      case homeIndex:
        analytics.logEvent(
          name: tutorialSkipEvent,
          parameters: {
            stepParamKey: homeStep,
          },
        );
        break;
      case friendLeague:
        analytics.logEvent(
          name: tutorialSkipEvent,
          parameters: {
            stepParamKey: friendLeagueStep,
          },
        );
        break;
      case createATip:
        analytics.logEvent(
          name: tutorialSkipEvent,
          parameters: {
            stepParamKey: createTipStep,
          },
        );
        break;

      case shopIndex:
        analytics.logEvent(
          name: tutorialSkipEvent,
          parameters: {
            stepParamKey: shopStep,
          },
        );
        break;

      case moreTeam:
        analytics.logEvent(
          name: tutorialSkipEvent,
          parameters: {
            stepParamKey: moreStep,
          },
        );
        break;

      case revealTip:
        analytics.logEvent(
          name: tutorialSkipEvent,
          parameters: {
            stepParamKey: revealTipStep,
          },
        );
        break;
    }
  }
}

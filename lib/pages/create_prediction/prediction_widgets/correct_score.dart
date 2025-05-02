import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/figma/text_styles.dart';

import '../../../data/repo/league_repository.dart';
import '../../../figma/colors.dart';
import '../../../util/betterUnited_icons.dart';
import 'commons.dart';
import 'home_draw_away.dart';

class ScorePoints {
  final String score;
  final int points;
  final String hint;
  final int betId;

  ScorePoints(
      {required this.score,
      required this.points,
      required this.betId,
      required this.hint});
}

class CorrectScoreData extends OddData {
  final String homeTeamName;
  final String awayTeamName;
  final int otherPoints;
  final String otherBetHint;
  final int otherBetId;
  final List<ScorePoints> scores;

  CorrectScoreData(super.id, super.isFolded, super.isEnabled,
      {required this.homeTeamName,
      required this.awayTeamName,
      required this.otherPoints,
      required this.otherBetId,
      required this.scores,
      required this.otherBetHint});
}

class CorrectScoreWidget extends StatefulWidget {
  const CorrectScoreWidget(
      {super.key, required this.data, required this.onBetTap});

  final CorrectScoreData data;
  final OnBetTap onBetTap;

  @override
  State<CorrectScoreWidget> createState() => _CorrectScoreWidgetState();
}

class _CorrectScoreWidgetState extends State<CorrectScoreWidget> {
  int homeTeamScoreCounter = 0;
  int awayTeamScoreCounter = 0;
  late int points;
  late String hint;
  late int betId;

  @override
  void initState() {
    super.initState();
    _updatePoints();
  }

  @override
  Widget build(BuildContext context) {
    return PredictionContainer(
        isFolded: widget.data.isFolded,
        isEnabled: widget.data.isEnabled,
        title: "correctScore".tr(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stepper(
                onMinusTap: () {
                  homeTeamScoreCounter--;
                  _updatePoints();
                  setState(() {});
                },
                onPlusTap: () {
                  homeTeamScoreCounter++;
                  _updatePoints();
                  setState(() {});
                },
                text: widget.data.homeTeamName,
                counter: homeTeamScoreCounter,
                isPlusEnabled: homeTeamScoreCounter < 10,
                isMinusEnabled: homeTeamScoreCounter > 0,
              ),
              Stepper(
                onMinusTap: () {
                  awayTeamScoreCounter--;
                  _updatePoints();
                  setState(() {});
                },
                onPlusTap: () {
                  awayTeamScoreCounter++;
                  _updatePoints();
                  setState(() {});
                },
                text: widget.data.awayTeamName,
                counter: awayTeamScoreCounter,
                isPlusEnabled: awayTeamScoreCounter < 100,
                isMinusEnabled: awayTeamScoreCounter > 0,
              ),
            ],
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () => widget.onBetTap(points, betId, hint),
            child: BetCard(
              widthRatio: 0.1,
              centerChild: PointsText(
                points: points,
              ),
            ),
          )
        ]);
  }

  _updatePoints() {
    final score = "$homeTeamScoreCounter-$awayTeamScoreCounter";
    final scorePoints = widget.data.scores
        .firstWhereOrNull((element) => element.score == score);
    if (scorePoints != null) {
      points = scorePoints.points;
      hint = scorePoints.hint;
      betId = scorePoints.betId;
    } else {
      points = widget.data.otherPoints;
      hint = widget.data.otherBetHint;
      betId = widget.data.otherBetId;
    }
  }
}

class Stepper extends StatelessWidget {
  const Stepper(
      {super.key,
      required this.text,
      required this.counter,
      required this.isPlusEnabled,
      required this.isMinusEnabled,
      required this.onPlusTap,
      required this.onMinusTap});

  final String text;
  final int counter;
  final bool isPlusEnabled;
  final bool isMinusEnabled;
  final GestureTapCallback onPlusTap;
  final GestureTapCallback onMinusTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: context.labelBold.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: isMinusEnabled ? onMinusTap : null,
              child: _Button(
                isEnabled: isMinusEnabled,
                icon: const Icon(
                  BetterUnited.minus,
                  size: 19,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              counter.toString(),
              style: AppTextStyles.textStyle5,
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: isPlusEnabled ? onPlusTap : null,
              child: _Button(
                isEnabled: isPlusEnabled,
                icon: const Icon(
                  BetterUnited.plus,
                  size: 19,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({required this.isEnabled, required this.icon});

  final Widget icon;

  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
          color: isEnabled ? AppColors.primary : AppColors.buttonInnactive,
          borderRadius: BorderRadius.circular(8),
        ),
        child: icon);
  }
}

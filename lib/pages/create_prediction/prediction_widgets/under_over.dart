import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/figma/text_styles.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

import '../../../data/repo/league_repository.dart';
import '../../../figma/colors.dart';
import 'commons.dart';
import 'home_draw_away.dart';

class UnderOverWidget extends StatefulWidget {
  const UnderOverWidget({
    super.key,
    required this.data,
    required this.onBetTap,
  });

  final UnderOverData data;
  final OnBetTap onBetTap;

  @override
  State<UnderOverWidget> createState() => _UnderOverWidgetState();
}

class _UnderOverWidgetState extends State<UnderOverWidget> {
  late UnderOverItem selectedBet;
  late double value;
  late final double min;
  late final double max;
  late final List<FlutterSliderFixedValue> fixedValues;
  late final slider = FlutterSlider(
    fixedValues: fixedValues,
    tooltip: FlutterSliderTooltip(
        textStyle: AppTextStyles.textStyle6,
        boxStyle: FlutterSliderTooltipBox(
            decoration: BoxDecoration(
          color: AppColors.primary,
          border: Border.all(color: Colors.white, width: 2),
        ))),
    trackBar: const FlutterSliderTrackBar(
      inactiveTrackBar: BoxDecoration(
        color: AppColors.secondary,
      ),
      activeTrackBarHeight: 4,
      activeTrackBar: BoxDecoration(
        color: AppColors.primary,
      ),
    ),
    handler: FlutterSliderHandler(
        decoration: const BoxDecoration(),
        child: Container(
          height: 22,
          width: 22,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
            color: AppColors.primary,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
        )),
    values: [min],
    max: max,
    min: min,
    onDragCompleted: (handlerIndex, lowerValue, upperValue) {
      //print(lowerValue);
      // _updateValue(lowerValue);
    },
    onDragging: (handlerIndex, lowerValue, upperValue) {
      if (lowerValue is double) {
        _updateValue(lowerValue);
      }
    },
  );

  @override
  void initState() {
    super.initState();
    final values = widget.data.groupedBets.keys;
    min = values.first;
    value = min;
    selectedBet = widget.data.groupedBets[value]!;
    max = values.last;
    fixedValues = values
        .map((e) =>
            FlutterSliderFixedValue(percent: (e / max * 100).toInt(), value: e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return PredictionContainer(
      isFolded: widget.data.isFolded,
      isEnabled: widget.data.isEnabled,
      title: "underOver".tr(),
      children: [
        Row(
          children: [
            Expanded(
                child: GestureDetector(
                    onTap: () => widget.onBetTap(selectedBet.overPoints,
                        selectedBet.overBetId, selectedBet.overHint),
                    child: PointsCard(
                        text: "${"moreThan".tr()} $value",
                        points: selectedBet.overPoints,
                        widthRatio: 0.6))),
            const SizedBox(
              width: 12,
            ),
            Expanded(
                child: GestureDetector(
                    onTap: () => widget.onBetTap(selectedBet.underPoints,
                        selectedBet.underBetId, selectedBet.underHint),
                    child: PointsCard(
                        text: "${"lessThan".tr()} $value",
                        points: selectedBet.underPoints,
                        widthRatio: 0.6))),
          ],
        ),
        slider
      ],
    );
  }

  _updateValue(double value) {
    setState(() {
      this.value = value;
      selectedBet = widget.data.groupedBets[value]!;
    });
  }
}

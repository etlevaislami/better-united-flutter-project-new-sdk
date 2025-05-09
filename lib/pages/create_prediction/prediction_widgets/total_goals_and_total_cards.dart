import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/figma/text_styles.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

import '../../../figma/colors.dart';
import '../../../util/betterUnited_icons.dart';
import '../../../util/common_ui.dart';
import 'commons.dart';

class TotalGoalsAndTotalCards extends StatefulWidget {
  const TotalGoalsAndTotalCards(
      {super.key,
        required this.onMoreThanSelected,
        required this.onLessThanSelected});

  final Function onMoreThanSelected;
  final Function onLessThanSelected;

  @override
  State<TotalGoalsAndTotalCards> createState() =>
      _TotalGoalsAndTotalCardsState();
}

class _TotalGoalsAndTotalCardsState extends State<TotalGoalsAndTotalCards> {
  final list = ["totalGoals".tr(), "totalCards".tr()];
  late String text = list.first;
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return PredictionContainer(
      title: "totalGoalsAndCards".tr().toUpperCase(),
      isFolded: false,
      isEnabled: true,
      children: [
        SizedBox(
          width: double.infinity,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isDense: true,
              buttonStyleData: ButtonStyleData(
                  padding: EdgeInsets.zero,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.textFilled,
                    boxShadow: appBoxShadow,
                    border: Border.all(
                      color: AppColors.buttonInnactive,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  )
              ),
              iconStyleData: const IconStyleData(
                icon: Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(
                    BetterUnited.arrowDown,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                iconSize: 16,
              ),
              dropdownStyleData: DropdownStyleData(
                padding: EdgeInsets.zero,
                maxHeight: context.height / 3,
                elevation: 0,
                decoration: const BoxDecoration(
                  color: AppColors.textFilled,
                  boxShadow: appBoxShadow,
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                ),
              ),
              value: text,
              items: list
                  .mapIndexed(
                    (index, name) => DropdownMenuItem<String>(
                  alignment: Alignment.center,
                  value: name,
                  child: Container(
                    color: AppColors.textFilled,
                    child: Text(
                      name,
                      style:
                      context.labelBold.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              )
                  .toList(),
              onChanged: (name) {
                if (name != null) {
                  setState(() {
                    text = name;
                  });
                }
              },
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Expanded(
                child: GestureDetector(
                    onTap: () => widget.onMoreThanSelected(),
                    child: PointsCard(
                        text: "${"moreThan".tr()} $value",
                        points: 133,
                        widthRatio: 0.6))),
            const SizedBox(
              width: 12,
            ),
            Expanded(
                child: GestureDetector(
                    onTap: () => widget.onLessThanSelected(),
                    child: PointsCard(
                        text: "${"lessThan".tr()} $value",
                        points: 133,
                        widthRatio: 0.6))),
          ],
        ),
        FlutterSlider(
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
          values: [value],
          max: 500,
          min: 0,
          onDragCompleted: (handlerIndex, lowerValue, upperValue) {
            setState(() {
              value = lowerValue;
            });
          },
          onDragging: (handlerIndex, lowerValue, upperValue) {},
        )
      ],
    );
  }
}

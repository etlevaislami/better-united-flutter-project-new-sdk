import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_horizontal_date_picker/flutter_horizontal_date_picker.dart'
    as flutter_horizontal_date_picker;

import '../figma/colors.dart';
import '../util/betterUnited_icons.dart';

class HorizontalDatePicker extends StatelessWidget {
  HorizontalDatePicker({
    Key? key,
    required this.begin,
    required this.end,
    this.selectedDate,
    this.onSelected,
    required this.todayDate,
  }) : super(key: key);
  final DateTime begin;
  final DateTime end;
  final DateTime? selectedDate;
  final Function(DateTime selected)? onSelected;
  final DateTime todayDate;
  final dayFormatter = DateFormat('EEE');
  final monthFormatter = DateFormat('dd MMM');

  @override
  Widget build(BuildContext context) {
    final itemCount = end.difference(begin).inDays;
    return Container(
      color: const Color(0xff353535),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 14.0),
            child: const Icon(
              BetterUnited.triangle,
              size: 15,
            ),
          ),
          Expanded(
              child: flutter_horizontal_date_picker.HorizontalDatePicker(
            needFocus: true,
            begin: begin,
            end: end,
            selected: selectedDate,
            onSelected: onSelected,
            itemBuilder: (DateTime itemValue, DateTime? selected) {
              var isSelected = itemValue == selected;
              final bool isToday = itemValue == todayDate;
              final bool isBeforeToday = itemValue.isBefore(todayDate);
              return Opacity(
                opacity: isBeforeToday ? 0.5 : 1,
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          (isToday
                                  ? "today".tr()
                                  : dayFormatter.format(itemValue))
                              .toUpperCase(),
                          style: context.labelBold.copyWith(
                              color: isSelected
                                  ? AppColors.primary
                                  : const Color(0xffC6C6C6)),
                        ),
                        Text(
                          monthFormatter.format(itemValue).toUpperCase(),
                          style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xffC6C6C6),
                              fontSize: 10,
                              fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const SizedBox(
                          height: 2,
                        )
                      ],
                    ),
                    if (isSelected)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColors.primary,
                          ),
                          height: 2,
                        ),
                      )
                  ],
                ),
              );
            },
            itemCount: itemCount,
            itemSpacing: 12,
            itemHeight: 50,
            selectedColor: Colors.transparent,
            unSelectedColor: Colors.transparent,
          )),
          Container(
            padding: const EdgeInsets.only(right: 14.0),
            child: const RotatedBox(
              quarterTurns: 2,
              child: Icon(
                BetterUnited.triangle,
                size: 15,
              ),
            ),
          )
        ],
      ),
    );
  }
}

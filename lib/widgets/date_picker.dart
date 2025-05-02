import 'dart:ui';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';
import 'package:flutter_better_united/widgets/secondary_button.dart';

import '../util/date_util.dart';

class DatePicker extends StatefulWidget {
  final void Function(DateTime)? onDateSelected;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const DatePicker({
    Key? key,
    this.onDateSelected,
    required this.initialDate,
    this.firstDate,
    this.lastDate,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();

  static Future<DateTime?> showDate(BuildContext context, {
    DateTime? date,
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    return showDialog(
      useSafeArea: false,
      context: context,
      useRootNavigator: false,
      builder: (context) => DatePicker(
        firstDate: firstDate,
        lastDate: lastDate,
        initialDate: date,
      ),
    );
  }
}

class _DatePickerState extends State<DatePicker> {

  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(),
        )),
        AlertDialog(
          backgroundColor: const Color(0xff2B2B2B),
          clipBehavior: Clip.antiAlias,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: context.height * 0.5,
            width: context.width * 0.9,
            color: const Color(0xff2B2B2B),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 4,
                  child: CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                      firstDayOfWeek: 0,
                      firstDate: widget.firstDate,
                      lastDate: widget.lastDate,
                      yearTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                      controlsHeight: 100,
                      dayBorderRadius: BorderRadius.circular(4),
                      yearBorderRadius: BorderRadius.circular(4),
                      selectedDayTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                      modePickerTextHandler: ({required monthDate}) =>
                          monthFormatter.format(monthDate),
                      customModePickerIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Icon(
                          BetterUnited.arrowDown,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                      lastMonthIcon: const Icon(
                        BetterUnited.backward,
                        size: 24,
                        color: Colors.white,
                      ),
                      nextMonthIcon: const Icon(
                        BetterUnited.forward,
                        size: 24,
                        color: Colors.white,
                      ),
                      dayTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                      disabledDayTextStyle: TextStyle(
                        color: Colors.white.withOpacity(0.3),
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                      weekdayLabels: [
                        'weekdayMonday'.tr(),
                        'weekdayTuesday'.tr(),
                        'weekdayWednesday'.tr(),
                        'weekdayThursday'.tr(),
                        'weekdayFriday'.tr(),
                        'weekdaySaturday'.tr(),
                        'weekdaySunday'.tr()
                      ],
                      weekdayLabelTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      selectedDayHighlightColor: const Color(0xff9AE343),
                      controlsTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    value: [_selectedDate],
                    onValueChanged: (dates) {
                      final firstDate = dates.first;
                      if (firstDate != null) {
                        _selectedDate = firstDate;
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: SecondaryButton.labelText(
                          "cancel".tr().toUpperCase(),
                          onPressed: () {
                            context.pop();
                          },
                        ),
                      ),
                      Expanded(
                          child: SecondaryButton(
                        withBorders: false,
                        onPressed: () {
                          context.pop(result: _selectedDate);
                        },
                        text: "done".tr().toUpperCase(),
                      )),
                      const SizedBox(
                        width: 32,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

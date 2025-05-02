import 'package:flutter/material.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';
import 'package:flutter_better_united/widgets/input_field.dart';

import '../util/date_util.dart';
import 'date_picker.dart';

class DateWidget extends StatefulWidget {
  DateWidget({
    Key? key,
    this.displayDate,
    this.displayTodayLabel = false,
    this.hintText,
    this.errorMessage,
    this.padding = const EdgeInsets.all(10),
    this.onDateSelected,
  }) : super(key: key) {
    formattedDate =
        displayDate == null ? "" : dayMonthYearFormatter.format(displayDate!);
  }

  late final String formattedDate;
  final DateTime? displayDate;
  final bool displayTodayLabel;
  final String? hintText;
  final String? errorMessage;
  final EdgeInsets padding;
  final Function(DateTime date)? onDateSelected;

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.formattedDate;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () async {
            final date = await DatePicker.showDate(
              context,
              date: widget.displayDate,
            );
            if (date != null) {
              _controller.text = dayMonthYearFormatter.format(date);
              widget.onDateSelected?.call(date);
            }
          },
          child: InputField(
            prefixIcon: const Icon(
              BetterUnited.calendar,
            ),
            controller: _controller,
            errorText: widget.errorMessage,
            enabled: false,
            labelText: widget.hintText,
          ),
        ),
      ],
    );
  }
}
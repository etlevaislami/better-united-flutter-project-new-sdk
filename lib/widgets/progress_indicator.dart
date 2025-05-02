import 'package:flutter/cupertino.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../figma/colors.dart';

class ProgressPercentIndicator extends StatefulWidget {
  const ProgressPercentIndicator({super.key, this.percent = 0});

  final double percent;

  @override
  State<ProgressPercentIndicator> createState() =>
      _ProgressPercentIndicatorState();
}

class _ProgressPercentIndicatorState extends State<ProgressPercentIndicator> {
  @override
  void didUpdateWidget(covariant ProgressPercentIndicator oldWidget) {
    if (oldWidget.percent != widget.percent) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: const GradientBoxBorder(
          gradient:
              LinearGradient(colors: [Color(0xffAAAAAA), Color(0xff5C5C5C)]),
          width: 2,
        ),
      ),
      child: LinearPercentIndicator(
        animation: true,
        animationDuration: 1000,
        padding: EdgeInsets.zero,
        backgroundColor: AppColors.secondary,
        linearGradient: const LinearGradient(
          colors: [Color(0xffDAFFAE), Color(0xff9AE343)],
        ),
        lineHeight: 8,
        percent: widget.percent,
        barRadius: const Radius.circular(10),
      ),
    );
  }
}

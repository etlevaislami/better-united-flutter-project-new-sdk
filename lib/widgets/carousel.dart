import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import '../constants/rules.dart';
import '../figma/colors.dart';

class Carousel extends StatelessWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel.builder(
      itemCount: rules.length,
      itemBuilder: (context, index, realIndex) {
        final rule = rules[index];
        return Container(
          margin: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  color: const Color(0xffAAE15E),
                  child: AutoSizeText(
                    rule.title.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    color: AppColors.background,
                    child: AutoSizeText(
                      rule.description.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      options: FlutterCarouselOptions(
          disableCenter: false,
          initialPage: 0,
          indicatorMargin: 8,
          floatingIndicator: false,
          height: 130,
          viewportFraction: 0.8,
          showIndicator: true,
          enlargeCenterPage: true,
          slideIndicator: CircularSlideIndicator(
              slideIndicatorOptions: SlideIndicatorOptions(
                  itemSpacing: 12,
                  indicatorRadius: 4,
                  currentIndicatorColor: AppColors.primary,
                  indicatorBackgroundColor: AppColors.buttonInnactive))),
    );
  }
}

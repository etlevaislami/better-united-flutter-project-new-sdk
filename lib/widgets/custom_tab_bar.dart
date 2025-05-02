import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

typedef OnTabChanged = void Function(int index);

class CustomTabBar extends StatelessWidget {
  const CustomTabBar(
      {Key? key,
      required this.firstTabText,
      required this.secondTabText,
      required this.tabController,
      this.backgroundColor = const Color(0xff353535)})
      : super(key: key);
  final String firstTabText;
  final String secondTabText;
  final TabController tabController;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final autoSizeGroup = AutoSizeGroup();
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: const Color(0xff9AE343)),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
        ),
        tabs: [
          Tab(
            child: AutoSizeText(
              firstTabText.toUpperCase(),
              group: autoSizeGroup,
              maxLines: 1,
              minFontSize: 1,
            ),
          ),
          Tab(
              child: AutoSizeText(
            secondTabText.toUpperCase(),
            maxLines: 1,
            minFontSize: 1,
            group: autoSizeGroup,
          )),
        ],
      ),
    );
  }
}

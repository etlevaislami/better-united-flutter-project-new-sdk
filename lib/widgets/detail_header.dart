import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';

class DetailHeader extends StatelessWidget {
  const DetailHeader({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text.toUpperCase(),
        style: context.bodyBold.copyWith(color: Colors.white),
      ),
    );
  }
}

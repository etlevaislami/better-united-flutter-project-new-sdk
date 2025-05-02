import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';

class AuthenticationTitleWidget extends StatelessWidget {
  const AuthenticationTitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 32,
        ),
        Image.asset(
          "assets/images/logo_glow.png",
          height: 120,
        ),
        const SizedBox(
          height: 18,
        ),
        Text(
          title.toUpperCase(),
          style: context.titleH1White,
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
          shadows: [
            Shadow(
              offset: Offset(0, 2),
              blurRadius: 16,
              color: Color.fromRGBO(0, 0, 0, 0.5),
            ),
          ],
          fontSize: 22,
          color: Colors.white,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w700),
    );
  }
}

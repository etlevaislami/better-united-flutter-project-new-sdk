import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DialogBar extends StatelessWidget {
  const DialogBar({Key? key, required this.title, required this.onTap})
      : super(key: key);
  final String title;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: context.titleLarge,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: SvgPicture.asset("assets/icons/ic_close.svg"),
              onPressed: onTap,
            ),
          )
        ],
      ),
    );
  }
}

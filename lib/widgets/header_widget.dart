import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget(
      {Key? key,
      required this.title,
      required this.onTap,
      this.icon,
      this.endIcon,
      this.onEndTap})
      : super(key: key);
  final String title;
  final GestureTapCallback? onTap;
  final Widget? icon;
  final Widget? endIcon;
  final GestureTapCallback? onEndTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: SvgPicture.asset(
              "assets/images/ic_back.svg",
              color: Colors.white,
            ),
            onPressed: onTap,
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: context.width / 1.4,
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon == null
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child: icon,
                          ),
                        ),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: context.titleLarge?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        endIcon == null
            ? const SizedBox()
            : Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: endIcon!,
                  onPressed: onEndTap,
                ),
              ),
      ],
    );
  }
}

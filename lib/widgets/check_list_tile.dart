import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../figma/colors.dart';

class CheckListTile extends StatelessWidget {
  const CheckListTile(
      {Key? key,
      this.onTap,
      required this.isActive,
      required this.hasError,
      required this.onChanged,
      required this.text,
      this.isOptional = false,
      this.unselectedWidgetColor = const Color(0xff161616),
      this.borderColor = const Color(0xff353535)})
      : super(key: key);
  final String text;
  final GestureTapCallback? onTap;
  final bool isActive;
  final bool hasError;
  final ValueChanged<bool?> onChanged;
  final bool isOptional;
  final Color unselectedWidgetColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : unselectedWidgetColor,
                border: isActive
                    ? null
                    : Border.all(
                        color:
                            !hasError ? borderColor : const Color(0xffF13E3E)),
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              child: Transform.scale(
                scale: 1.2,
                child: Theme(
                  data: ThemeData(
                      unselectedWidgetColor: Colors.transparent,
                      useMaterial3: false // Your color
                      ),
                  child: Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    value: isActive,
                    onChanged: onChanged,
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                ),
              ),
            )),
        Expanded(
          child: Wrap(
            children: [
              RichText(
                text: TextSpan(style: context.bodyMedium, children: [
                  TextSpan(
                    text: "agreeTo".tr(),
                  ),
                  const TextSpan(text: " "),
                  TextSpan(
                    text: text,
                    recognizer: TapGestureRecognizer()..onTap = onTap,
                    style: context.bodyMedium?.copyWith(
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primary,
                      decorationThickness: 3,
                    ),
                  ),
                  TextSpan(text: isOptional ? " " : ""),
                  TextSpan(
                      text: isOptional ? "(${"optional".tr()})" : "",
                      style: const TextStyle(
                          color: Color(0xff989898), fontSize: 10)),
                ]),
              ),
            ],
          ),
        )
      ],
    );
  }
}

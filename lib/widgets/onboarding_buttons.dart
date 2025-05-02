import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_better_united/widgets/secondary_button.dart';

class OnboardingButtons extends StatelessWidget {
  const OnboardingButtons({
    Key? key,
    this.onBackPressed,
    this.onPressed,
    required this.primaryButtonText,
  }) : super(key: key);
  final VoidCallback? onBackPressed;
  final VoidCallback? onPressed;
  final String primaryButtonText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 5),
            child: SecondaryButton.labelText(
              "back".tr(),
              onPressed: onBackPressed,
              withUnderline: true,
            ),
          ),
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 5),
              child: SecondaryButton(
                text: primaryButtonText,
                onPressed: onPressed,
              )),
        ),
      ],
    );
  }
}

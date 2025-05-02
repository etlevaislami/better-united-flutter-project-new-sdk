import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/figma/dimensions.dart';
import 'package:flutter_better_united/pages/settings/language/available_language.dart';
import 'package:flutter_better_united/pages/settings/settings_language_page.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({
    Key? key,
    required this.fromRoute,
    this.padding = EdgeInsets.zero,
    this.onLanguageSelected,
  }) : super(key: key);

  final String fromRoute;
  final EdgeInsets padding;
  final Function(DateTime date)? onLanguageSelected;

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  SupportedLanguage? currentLanguage;

  @override
  void initState() {
    _initLanguage();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: const Color(0xff353535),
        border: Border.all(
          color: AppColors.buttonInnactive, // Specify the border color
          width: 2.0, // Optional: Specify border width
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (currentLanguage != null)
            Image.asset(
              currentLanguage!.flagFileLocation,
              width: AppDimensions.defaultIconSize,
              height: AppDimensions.defaultIconSize,
            ),
          if (currentLanguage != null)
            Text(
              currentLanguage!.name.toUpperCase(),
              style: context.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          const Spacer(),
          _buildChangeButton(),
        ],
      ),
    );
  }

  void _initLanguage() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String language = context.locale.languageCode;
      setState(() {
        currentLanguage = SupportedLanguage.fromLocale(language);
      });
    });
  }

  _buildChangeButton() {
    return GestureDetector(
      onTap: () async {
        final args = SettingsLanguagePageArgs(
          fromRoute: widget.fromRoute,
        );
        Navigator.of(context)
            .pushNamed(SettingsLanguagePage.route, arguments: args);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Text(
          "change".tr().toUpperCase(),
          style: context.bodyBoldUnderlinePrimary,
        ),
      ),
    );
  }
}

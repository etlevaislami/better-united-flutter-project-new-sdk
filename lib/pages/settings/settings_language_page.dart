import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/app_colors.dart';
import 'package:flutter_better_united/pages/settings/settings_page.dart';
import 'package:flutter_better_united/pages/tutorial/start_tutorial_page.dart';
import 'package:flutter_better_united/util/locale_util.dart';
import 'package:flutter_better_united/util/ui_util.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:provider/provider.dart';

import '../nav_page.dart';
import '../shop/user_provider.dart';

class SettingsLanguagePage extends StatefulWidget {
  static const String route = "/settings/language";

  const SettingsLanguagePage(
      {Key? key, this.args})
      : super(key: key);
  final SettingsLanguagePageArgs? args;

  @override
  State<SettingsLanguagePage> createState() => _SettingsLanguagePageState();
}

class _SettingsLanguagePageState extends State<SettingsLanguagePage> {
  Locale? locale;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String language = locale?.languageCode ?? context.locale.languageCode;
    return Scaffold(
      appBar: RegularAppBar.withBackButton(
        title: "settingsLanguageTitle".tr(),
        onBackTap: () => context.pop(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 32,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "selectLanguage".tr(),
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            _LanguageButton(
              text: "dutch".tr(),
              isSelected: language == "nl",
              onPressed: () {
                setState(() {
                  locale = const Locale('nl', 'NL');
                  language = locale!.languageCode;
                });
              },
              prefixIcon: Image.asset("assets/icons/ic_nl.png"),
            ),
            const SizedBox(
              height: 32,
            ),
            _LanguageButton(
                text: "english".tr(),
                isSelected: language == "en",
                onPressed: () {
                  setState(() {
                    locale = const Locale('en', '');
                    language = locale!.languageCode;
                  });
                },
                prefixIcon: Image.asset("assets/icons/ic_eg.png")),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: PrimaryButton(
          text: "saveChanges".tr(),
          onPressed: locale != null ? () => _changeLocale(language) : null,
        ),
      ),
    );
  }

  _changeLocale(String languageCode) async {
    try {
      beginLoading();
      final updatedLocale = Locale(languageCode);
      await context.read<UserProvider>().updateRemoteLanguage(updatedLocale);
      await context.applyLocale(updatedLocale);
      await Devicelocale.setLanguagePerApp(updatedLocale);

      if (widget.args?.fromRoute == SettingsPage.route) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(NavPage.route, (route) => false);
      } else if(widget.args?.fromRoute == StartTutorialPage.route){
        Navigator.of(context)
            .pushNamedAndRemoveUntil(StartTutorialPage.route, (route) => false);
      }
    } catch (exception) {
      showGenericError(exception);
    } finally {
      endLoading();
    }
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton(
      {Key? key,
      required this.text,
      this.onPressed,
      required this.prefixIcon,
      required this.isSelected})
      : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final bool isSelected;
  final Widget prefixIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          padding: const EdgeInsets.all(4),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            boxShadow: !isSelected
                ? null
                : [
                    const BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.50),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
            borderRadius: BorderRadius.circular(8.0),
            gradient: !isSelected
                ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF7B7B7B), Color(0xFF454545)],
                  )
                : const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.primaryColor, Color(0xFF454545)],
                  ),
            color: Colors.grey,
          ),
          child: LayoutBuilder(builder: (p0, p1) {
            const inclinationRation = 1.0;
            return SizedBox(
              height: 48,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                                offset: Offset(0, 2),
                                blurRadius: 8,
                                spreadRadius: 0),
                          ],
                          color: const Color(0xff3C3C3C),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: CustomPaint(
                          painter: _ButtonPainter(
                            withGradient: isSelected,
                            inclinationRation: inclinationRation,
                            widthRatio: 0.24,
                            foregroundColor: isSelected
                                ? const Color(0xff1D1D1D)
                                : const Color(0xff353535),
                            backgroundColor: !isSelected
                                ? const Color(0xff535353)
                                : const Color(0xff535353),
                          ),
                        )),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 15, top: 4),
                          width: p1.maxWidth * 0.24,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: prefixIcon,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      text.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              ),
            );
          })),
    );
  }
}

class _ButtonPainter extends CustomPainter {
  final double widthRatio;

  final double inclinationRation;

  final double gradientLengthRatio;

  final Color foregroundColor;
  final Color backgroundColor;
  late final Paint foregroundPaint;
  late final Paint backgroundPaint;

  Paint? gradientPaint;
  late final LinearGradient linearGradient;

  _ButtonPainter({
    this.widthRatio = 0.9,
    this.inclinationRation = 0.6,
    this.gradientLengthRatio = 0.05,
    this.foregroundColor = const Color(0xFFAAE15E),
    this.backgroundColor = const Color(0xff2B2B2B),
    bool withGradient = true,
  }) {
    backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    foregroundPaint = Paint()
      ..color = foregroundColor
      ..style = PaintingStyle.fill;

    if (withGradient) {
      gradientPaint = Paint()..style = PaintingStyle.fill;
      linearGradient = LinearGradient(
        colors: [backgroundColor, const Color(0xFFAAE15E)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final startingWidth = size.width * widthRatio;
    final gradientLength = size.width * gradientLengthRatio;
    final inclinationWidth = gradientLength * inclinationRation;
    final backgroundRect =
        Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height));

    if (gradientPaint != null) {
      final rect =
          Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height));
      gradientPaint!.shader = linearGradient.createShader(rect);
      canvas.drawRect(backgroundRect, gradientPaint!);
    } else {
      canvas.drawRect(backgroundRect, backgroundPaint);
    }
    final path2 = Path()
      ..moveTo(0, 0)
      ..lineTo(startingWidth - gradientLength, 0)
      ..lineTo(startingWidth - gradientLength + inclinationWidth, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path2, foregroundPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

/// Args that should be passed to the SettingsLanguagePage.
class SettingsLanguagePageArgs {
  // Route from which this is launched, which should be restored after updating language.
  final String? fromRoute;

  const SettingsLanguagePageArgs({
    required this.fromRoute,
  });
}

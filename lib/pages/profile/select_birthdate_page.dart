import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/widgets/coach_profile_widget.dart';
import 'package:provider/provider.dart';

import '../../util/Debouncer.dart';
import '../../util/date_util.dart';
import '../../widgets/date_widget.dart';
import '../../widgets/onboarding_buttons.dart';
import '../../widgets/title_subtitle.dart';
import 'create_profile_provider.dart';

class SelectBirthdatePage extends StatefulWidget {
  const SelectBirthdatePage({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectBirthdatePage> createState() => _SelectBirthdatePageState();
}

class _SelectBirthdatePageState extends State<SelectBirthdatePage> {
  final _textDebouncer = Debouncer();
  final TextEditingController _textController = TextEditingController();
  final firstDate = DateTime(1900);

  @override
  void dispose() {
    super.dispose();
    _textDebouncer.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = context.read<ProfileProvider>();
      final date = provider.birthdate;
      _textController.text =
          date == null ? "" : dayMonthYearFormatterWithSeparator.format(date);
      provider.validateBirthdateField();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.read<ProfileProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Selector<ProfileProvider, CoachState>(
                        selector: (p0, p1) => p1.birthdateCoachState,
                        builder: (context, coachState, child) =>
                            CoachProfileWidget(coachState: coachState)),
                    HeaderTitle(
                      title: "setBirthdateTitle".tr(),
                      subTitle: "setBirthdateSubTitle".tr(),
                    ),
                    Selector<ProfileProvider, DateTime?>(
                        selector: (p0, p1) => p1.birthdate,
                        builder: (context, date, child) => Padding(
                              padding: const EdgeInsets.only(bottom: 27.0),
                              child: DateWidget(
                                onDateSelected: (date) {
                                  _onDateTap(context, date);
                                },
                                padding: const EdgeInsets.all(17),
                                displayDate: date,
                                hintText: "birthdateHint".tr(),
                                errorMessage: date != null &&
                                        context
                                                .read<ProfileProvider>()
                                                .isBirthdateValid ==
                                            false
                                    ? "birthdateRequirement".tr()
                                    : null,
                              ),
                            )),
                  ],
                ),
              ),
            ),
          ),
          Selector<ProfileProvider, bool>(
            selector: (p0, p1) => p1.isNextAllowed,
            builder: (context, isNextAllowed, child) => OnboardingButtons(
              onBackPressed: () {
                profileProvider.onBackClicked();
              },
              primaryButtonText: "next".tr(),
              onPressed: isNextAllowed
                  ? () {
                      profileProvider.onBirthdateStep();
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  _onDateTap(BuildContext context, DateTime dateTime) async {
    final provider = context.read<ProfileProvider>();
    provider.setBirthdate(dateTime);
  }
}

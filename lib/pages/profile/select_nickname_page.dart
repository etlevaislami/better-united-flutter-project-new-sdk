import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/widgets/coach_profile_widget.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:provider/provider.dart';

import '../../util/Debouncer.dart';
import '../../widgets/input_field.dart';
import '../../widgets/title_subtitle.dart';
import 'create_profile_provider.dart';

class SelectNicknamePage extends StatefulWidget {
  const SelectNicknamePage({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectNicknamePage> createState() => _SelectNicknamePageState();
}

class _SelectNicknamePageState extends State<SelectNicknamePage> {
  final _textDebouncer = Debouncer();
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textDebouncer.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _textController.text = context.read<ProfileProvider>().nickname;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.read<ProfileProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Selector<ProfileProvider, CoachState>(
                      selector: (p0, p1) => p1.nicknameCoachState,
                      builder: (context, coachState, child) =>
                          CoachProfileWidget(coachState: coachState),
                    ),
                    HeaderTitle(
                      title: "setNicknameTitle".tr(),
                      subTitle: "setNicknameSubtitle".tr(),
                    ),
                    Selector<ProfileProvider, bool>(
                      selector: (p0, p1) => p1.isNicknameInUse,
                      builder: (context, isNicknameInUse, child) => InputField(
                        controller: _textController,
                        errorText: isNicknameInUse
                            ? "nicknameAlreadyTaken".tr()
                            : null,
                        onChanged: (value) => _textDebouncer.run(() {
                          profileProvider.nickname = value;
                          profileProvider.validateNicknameField();
                        }),
                        labelText: "nickname".tr(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Selector<ProfileProvider, bool>(
            selector: (p0, p1) => p1.isNextAllowed,
            builder: (context, isNextAllowed, child) => Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: PrimaryButton(
                text: "next".tr(),
                onPressed: isNextAllowed
                    ? () {
                        profileProvider.onNicknameStep();
                      }
                    : null,
              ),
            ),
          )
        ],
      ),
    );
  }
}

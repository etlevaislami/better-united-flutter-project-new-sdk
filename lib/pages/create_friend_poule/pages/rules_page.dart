import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/figma/text_styles.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../figma/colors.dart';
import '../../../figma/shadows.dart';
import '../../../widgets/friend_league_circle_league.dart';
import '../create_friend_poule_provider.dart';

class RulesPage extends StatefulWidget {
  const RulesPage({super.key});

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  @override
  Widget build(BuildContext context) {
    final createFriendPouleProvider = context.read<CreateFriendPouleProvider>();

    final isBoxChecked = context.watch<CreateFriendPouleProvider>().showBox;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.secondary,
      appBar: RegularAppBarV6(
        icon: const FriendLeagueCircle(),
        onBackTap: () {},
        onCloseTap: () {},
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: _CheckBox(
                  onTap: () {},
                  isActive: isBoxChecked,
                  onChanged: (value) {
                    createFriendPouleProvider.setRulesShowBox(value ?? false);
                  }),
            ),
            PrimaryButton(
              text: 'next'.tr(),
              onPressed: () {
                createFriendPouleProvider.onNextClicked();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
            left: 24, right: 24, top: RegularAppBarV6.appBarHeight, bottom: 24),
        child: Column(
          children: [
            Text(
              "rulesOfFriendsPoule".tr(),
              style: context.bodyBold.copyWith(
                color: Colors.white,
                shadows: AppShadows.textShadows,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            _RuleWidget(
              title: "firstRuleTitle".tr(),
              description: "firstRuleDescription".tr(),
            ),
            const SizedBox(
              height: 16,
            ),
            _RuleWidget(
              title: "secondRuleTitle".tr(),
              description: "secondRuleDescription".tr(),
            ),
            const SizedBox(
              height: 16,
            ),
            _RuleWidget(
              title: "thirdRuleTitle".tr(),
              description: "thirdRuleDescription".tr(),
            ),
          ],
        ),
      ),
    );
  }
}

class _RuleWidget extends StatelessWidget {
  const _RuleWidget(
      {super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            color: const Color(0xffAAE15E),
            child: Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              style: AppTextStyles.textStyle3,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            width: double.infinity,
            color: AppColors.background,
            child: Text(
              description.toUpperCase(),
              textAlign: TextAlign.center,
              style: AppTextStyles.textStyle3,
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckBox extends StatelessWidget {
  const _CheckBox({
    Key? key,
    this.onTap,
    required this.isActive,
    required this.onChanged,
  }) : super(key: key);
  final GestureTapCallback? onTap;
  final bool isActive;

  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : Colors.transparent,
                border:
                    isActive ? null : Border.all(color: AppColors.background),
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
                    fillColor: WidgetStateProperty.all(Colors.transparent),
                  ),
                ),
              ),
            )),
        Text(
          "doNotShowAgain".tr(),
        ),
      ],
    );
  }
}

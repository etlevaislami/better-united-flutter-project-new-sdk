import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/pages/settings/settings_provider.dart';
import 'package:flutter_better_united/widgets/regular_app_bar.dart';
import 'package:provider/provider.dart';

import '../../figma/colors.dart';

class SettingsPushPage extends StatefulWidget {
  static const String route = "/settings/push";

  const SettingsPushPage({Key? key}) : super(key: key);

  @override
  State<SettingsPushPage> createState() => _SettingsPushPageState();
}

class _SettingsPushPageState extends State<SettingsPushPage> {
  late SettingsProvider _settingsProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _settingsProvider = SettingsProvider(Provider.of(context));
    _settingsProvider.fetchPushSettings();
  }

  @override
  void initState() {
    super.initState();
  }

  final _allNotificationController = ValueNotifier<bool>(false);
  final _predictionStatusController = ValueNotifier<bool>(false);
  final friendPouleController = ValueNotifier<bool>(false);
  final _accountController = ValueNotifier<bool>(false);
  final _appUpdatesController = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _allNotificationController.dispose();
    _predictionStatusController.dispose();
    friendPouleController.dispose();
    _accountController.dispose();
    _appUpdatesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _settingsProvider,
      builder: (context, child) => Scaffold(
        appBar: RegularAppBar.withBackButton(
          title: "settingsPushTitle".tr(),
          onBackTap: () {
            Navigator.pop(context);
          },
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Text("settingsPushSubtitle".tr(),
                  textAlign: TextAlign.center,
                  style: context.labelMedium?.copyWith(color: Colors.white)),
              const SizedBox(
                height: 32,
              ),
              const Divider(
                height: 1,
                color: Color(0xff353535),
              ),
              _SwitchTile(
                value: context.watch<SettingsProvider>().allNotification,
                onChanged: (bool value) {
                  context.read<SettingsProvider>().toggleNotifications(value);
                  context.read<SettingsProvider>().refreshView();
                },
                title: "settingsPushOption1".tr(),
              ),
              const Divider(
                height: 1,
                color: Color(0xff353535),
              ),
              const SizedBox(
                height: 12,
              ),
              _SwitchTile(
                title: "settingsPushOption2".tr(),
                value: context.watch<SettingsProvider>().notificationTipEnabled,
                onChanged: (bool value) {
                  context.read<SettingsProvider>().notificationTipEnabled =
                      value;
                  context.read<SettingsProvider>().refreshView();
                },
              ),
              _SwitchTile(
                value:
                    context.watch<SettingsProvider>().notificationPoulesEnabled,
                onChanged: (bool value) {
                  context.read<SettingsProvider>().notificationPoulesEnabled =
                      value;
                  context.read<SettingsProvider>().refreshView();
                },
                title: "settingsPushOption3".tr(),
              ),
              Text(
                "poulesNotificationDescription".tr(),
                style: context.labelRegular
                    .copyWith(color: AppColors.textInnactive),
              ),
              _SwitchTile(
                title: "settingsPushOption5".tr(),
                value: context
                    .watch<SettingsProvider>()
                    .notificationAccountEnabled,
                onChanged: (bool value) {
                  context.read<SettingsProvider>().notificationAccountEnabled =
                      value;
                  context.read<SettingsProvider>().refreshView();
                },
              ),
              _SwitchTile(
                title: "settingsPushOption4".tr(),
                value: context
                    .watch<SettingsProvider>()
                    .notificationAppUpdatesEnabled,
                onChanged: (bool value) {
                  context
                      .read<SettingsProvider>()
                      .notificationAppUpdatesEnabled = value;
                  context.read<SettingsProvider>().refreshView();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SwitchButton extends StatefulWidget {
  _SwitchButton({Key? key, this.onChanged, required this.value})
      : super(key: UniqueKey());
  final ValueChanged<bool>? onChanged;
  final bool value;

  @override
  State<_SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<_SwitchButton> {
  final ValueNotifier<bool> _controller = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _controller.value = widget.value;
    _controller.addListener(() {
      widget.onChanged?.call(_controller.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedSwitch(
      controller: _controller,
      initialValue: _controller.value,
      activeColor: AppColors.primary,
      inactiveColor: const Color(0xff9A9A9A),
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      thumb: Container(
        margin: const EdgeInsets.all(1),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
      ),
      width: 48.0,
      height: 24.0,
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    Key? key,
    required this.title,
    this.onChanged,
    required this.value,
  }) : super(key: key);
  final String title;
  final ValueChanged<bool>? onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Expanded(
              child: Text(title,
                  style: context.labelMedium?.copyWith(color: Colors.white))),
          const SizedBox(
            width: 8,
          ),
          _SwitchButton(
            onChanged: onChanged,
            value: value,
          ),
        ],
      ),
    );
  }
}

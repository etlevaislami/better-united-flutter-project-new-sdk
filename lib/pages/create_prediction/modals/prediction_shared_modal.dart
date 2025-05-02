import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/pages/shop/user_provider.dart';
import 'package:flutter_better_united/util/extensions/int_extension.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:flutter_better_united/widgets/rounded_container.dart';
import 'package:provider/provider.dart';

import '../../../figma/colors.dart';
import '../../../widgets/base_dialog.dart';
import '../../../widgets/user_coins.dart';

class PredictionSharedDialog extends StatefulWidget {
  const PredictionSharedDialog(
      {Key? key,
      required this.coins,
      required this.hasBookies,
      required this.onGetFreePredictionTap,
      required this.onBackToHomeTap})
      : super(key: key);
  final Function onGetFreePredictionTap;
  final Function onBackToHomeTap;
  final int? coins;
  final bool hasBookies;

  static Future<dynamic> displayDialog(BuildContext context,
      {required Function onBackToHomeTap,
      required Function onGetFreePredictionTap,
      required int? coins,
      required bool hasBookies}) {
    return showDialog(
      useSafeArea: false,
      barrierDismissible: false,
      context: context,
      useRootNavigator: false,
      builder: (context) => PredictionSharedDialog(
        coins: coins,
        hasBookies: hasBookies,
        onGetFreePredictionTap: onGetFreePredictionTap,
        onBackToHomeTap: onBackToHomeTap,
      ),
    );
  }

  @override
  State<PredictionSharedDialog> createState() => _PredictionSharedDialogState();
}

class _PredictionSharedDialogState extends State<PredictionSharedDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final coins = widget.coins;
        if (coins != null) {
          final userProvider = context.read<UserProvider>();
          userProvider.addUserCoins(coins);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BaseDialog(
          withConfetti: widget.coins != null,
          withAnimation: true,
          positionMultiplier: 1,
          icon: widget.coins != null
              ? Transform.translate(
                  offset: const Offset(0, -20),
                  child: Transform.scale(
                    scale: 1.8,
                    child: Image.asset("assets/images/ic_bag_coins.png"),
                  ),
                )
              : Transform.translate(
                  offset: const Offset(0, -10),
                  child: Transform.scale(
                    scale: 1.2,
                    child: Image.asset("assets/images/bu_bubble.png"),
                  ),
                ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              Text("thankYouForPrediction".tr().toUpperCase(),
                  textAlign: TextAlign.center, style: context.titleH1),
              const SizedBox(
                height: 15,
              ),
              _buildCoinsSection(context),
              _buildGuruSection(context),
              const SizedBox(
                height: 40,
              ),
              _buildButton(context),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        widget.coins != null
            ? const Positioned(
                right: 20,
                top: 20,
                child: SafeArea(child: UserCoins()),
              )
            : const SizedBox()
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: PrimaryButton(
        confineInSafeArea: false,
        text: widget.hasBookies
            ? "getFreePrediction".tr()
            : "backToOverview".tr(),
        onPressed: widget.hasBookies
            ? () {
                context.pop();
                widget.onGetFreePredictionTap();
              }
            : () {
                context.pop();
                widget.onBackToHomeTap();
              },
      ),
    );
  }

  Widget _buildCoinsSection(BuildContext context) {
    return widget.coins != null
        ? Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("youGet".tr()),
                  const SizedBox(
                    width: 12,
                  ),
                  RoundedContainer(
                    backgroundColor: AppColors.background,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/icons/ic_coins.png",
                          height: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          widget.coins.formatNumber(),
                          style: context.titleH2.copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          )
        : const SizedBox();
  }

  Widget _buildGuruSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Text(
        widget.hasBookies
            ? widget.coins != null
                ? "andPredictionFromOurGuru".tr().toLowerCase()
                : "getPredictionFromOurGuru".tr()
            : "noBookies".tr(),
        style: context.bodyRegularWhite,
        textAlign: TextAlign.center,
      ),
    );
  }
}

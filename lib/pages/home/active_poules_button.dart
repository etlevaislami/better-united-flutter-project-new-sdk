import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/pages/nav_page.dart';
import 'package:flutter_better_united/pages/poules/active_poule_page.dart';
import 'package:flutter_better_united/pages/poules/poules_provider.dart';
import 'package:flutter_better_united/pages/tutorial/start_tutorial_page.dart';
import 'package:flutter_better_united/widgets/background_container.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ActivePoulesButton extends StatelessWidget {
  final GlobalKey? unblurredActivePoulesButtonKey;

  const ActivePoulesButton({super.key, this.unblurredActivePoulesButtonKey});

  @override
  Widget build(BuildContext context) {
    final poulesCount = context.watch<PoulesProvider>().activePoulesCount;
    return Padding(
      padding: const EdgeInsets.only(
          left: 24, right: 24, bottom: NavPage.navBarHeight + 33),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .push(ActivePoulePage.route());
        },
        child: SizedBox(
          key: unblurredActivePoulesButtonKey,
          height: 66,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.50),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
              borderRadius: BorderRadius.circular(8.0),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF7B7B7B), Color(0xFF454545)],
              ),
              color: Colors.grey,
            ),
            child: BackgroundContainer(
                padding: EdgeInsets.zero,
                isInclinationReversed: false,
                widthRatio: 0.85,
                leadingChild: Align(
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                      child: Transform.translate(
                        offset: const Offset(-4, 4),
                        child: Transform.scale(
                            scale: 1.3,
                            child: SvgPicture.asset(
                              "assets/figma/svg/components/exported_icons/img_btn_trophy.svg",
                              clipBehavior: Clip.hardEdge,
                              color: Colors.white.withOpacity(0.44),
                            )),
                      ),
                    )),
                trailingChild: Align(
                    alignment: Alignment.center,
                    child: poulesCount == null
                        ? const SpinKitThreeBounce(
                        color: Colors.white, size: 16)
                        : Text(
                      poulesCount.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        fontSize: 32,
                        color: Colors.white,
                      ),
                    )),
                centerChild: Text("activePoule".tr().toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                      color: Colors.white,
                      leadingDistribution: TextLeadingDistribution.even,
                    )),
                withGradient: true,
                foregroundColor: AppColors.primary,
                backgroundColor: const Color(0xff2B2B2B)),
          ),
        ),
      ),
    );
  }
}
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/app_colors.dart';
import 'package:provider/provider.dart';

import '../../widgets/onboarding_buttons.dart';
import '../../widgets/team_icon.dart';
import 'create_profile_provider.dart';
import 'favorite_club_page.dart';

class SelectFavoriteClubsPage extends StatefulWidget {
  const SelectFavoriteClubsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectFavoriteClubsPage> createState() =>
      _SelectFavoriteClubsPageState();
}

class _SelectFavoriteClubsPageState extends State<SelectFavoriteClubsPage> {

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.read<ProfileProvider>();
    final favoriteTeamsCounter =
        context.watch<ProfileProvider>().userFavoriteTeamIds?.length ?? 0;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "favoriteClubsTitle".tr(),
                textAlign: TextAlign.center,
                style: context.titleSmall,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
              alignment: Alignment.center, child: FavoriteClubSelection()),
        ),
        Selector<ProfileProvider, bool>(
          selector: (p0, p1) => p1.isNextAllowed,
          builder: (context, isNextAllowed, child) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "clubSelectedArgs".plural(favoriteTeamsCounter),
                  style: context.bodyMedium
                      ?.copyWith(color: AppColors.primaryColor),
                ),
                const SizedBox(
                  height: 24,
                ),
                OnboardingButtons(
                    onBackPressed: () {
                      profileProvider.onBackClicked();
                    },
                    primaryButtonText:
                        favoriteTeamsCounter == 0 ? "skip".tr() : "done".tr(),
                    onPressed: () {
                      profileProvider.finishOnboarding();
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRectShimmer() {
    return SizedBox(
      height: 180,
      width: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 180,
            width: 120,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xff6B6B6B),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff535353),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Expanded(
                      flex: 5,
                      child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8))),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: const TeamIcon(
                            logoUrl: null,
                          ))),
                  Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xff353535),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                                baseColor:
                                    Colors.grey.shade300.withOpacity(0.1),
                                highlightColor:
                                    Colors.grey.shade100.withOpacity(0.2),
                                child: Container(
                                  width: 120,
                                  height: 20,
                                  color: Colors.black,
                                )),
                            SizedBox(
                              width: 40,
                              child: Shimmer.fromColors(
                                  baseColor:
                                      Colors.grey.shade300.withOpacity(0.1),
                                  highlightColor:
                                      Colors.grey.shade100.withOpacity(0.2),
                                  child: Container(
                                    width: 80,
                                    height: 10,
                                    color: Colors.black,
                                  )),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300.withOpacity(0.1),
            highlightColor: Colors.grey.shade100.withOpacity(0.2),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';

import '../figma/colors.dart';
import 'friend_poule_placeholder.dart';

class FriendPouleIconWithName extends StatelessWidget {
  const FriendPouleIconWithName({super.key, required this.name});

  final String? name;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(0.025 * context.width),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.1),
                  AppColors.primary.withOpacity(0.95)
                ],
              ),
            ),
          ),
        ),
        Transform.translate(
          // Offset the icon to make sure the bottom of the icon aligns with the top of the friendPoule name label.
          offset: Offset(0, -0.07 * context.width),
          child: const FriendPoulePlaceHolder(),
        ),
        name == null
            ? const SizedBox()
            : Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary, width: 1),
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    name!.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: context.titleH1White,
                  ),
                ),
              ),
      ],
    );
  }
}

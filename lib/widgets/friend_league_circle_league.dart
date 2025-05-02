import 'package:flutter/cupertino.dart';

import '../figma/colors.dart';

class FriendLeagueCircle extends StatelessWidget {
  const FriendLeagueCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 11),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.primary.withOpacity(0.25),
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          )),
      child: Image.asset(
        "assets/icons/ic-friendspoule.png",
        fit: BoxFit.cover,
      ),
    );
  }
}

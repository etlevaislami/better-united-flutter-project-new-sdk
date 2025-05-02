import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class VersusWidget extends StatelessWidget {
  const VersusWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Row(
            children: [
              Column(children: [
                Image.asset(
                  "assets/images/ic_club_tottenham.png",
                  width: 53,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Tottenham",
                  style: context.titleLarge,
                ).fontSize(14)
              ]),
              Expanded(
                child: Text(
                  "vs",
                  style: context.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Column(children: [
                Image.asset(
                  "assets/images/liverpool.png",
                  width: 53,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Liverpool",
                  style: context.titleLarge,
                ).fontSize(14)
              ]),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                margin:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.whiteout,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: const Text("10 Mar 2022 (20:00)")
                    .fontSize(11)
                    .textColor(AppColors.lunarBase),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

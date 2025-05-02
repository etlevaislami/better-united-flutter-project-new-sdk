import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';
import 'package:flutter_better_united/util/date_util.dart';
import 'package:flutter_better_united/widgets/team_icon.dart';

import '../figma/colors.dart';

class PouleInfoWidget extends StatelessWidget {
  const PouleInfoWidget({
    Key? key,
    required this.pouleName,
    required this.playerNumbers,
    required this.rank,
    required this.predictionNumbers,
    required this.daysLeft,
    required this.image,
    this.onInfoTap,
    required this.isFinished,
  }) : super(key: key);
  final String pouleName;
  final int playerNumbers;
  final int? rank;
  final int predictionNumbers;
  final int daysLeft;
  final bool isFinished;
  final Widget image;
  final GestureTapCallback? onInfoTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: CustomPaint(
        painter: BackgroundPainter(
          backgroundColor:
              isFinished ? const Color(0xff4B4B4B) : const Color(0xff353535),
          gradientColor:
              isFinished ? const Color(0xffC7C7C7) : AppColors.primary,
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Row(children: [
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    flex: 2,
                    child: Align(
                      child: SizedBox(
                        height: 101,
                        width: 101,
                        child: image,
                      ),
                    )),
                const SizedBox(
                  width: 24,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pouleName,
                        style: context.titleH2.copyWith(shadows: [
                          const Shadow(
                            offset: Offset(0, 2),
                            blurRadius: 16,
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                          ),
                        ], color: Colors.white),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _Row(
                        label: "playerArgs".plural(playerNumbers),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      rank != null
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: _Row(
                                label: "rankedAt".tr(args: [rank.toString()]),
                              ),
                            )
                          : const SizedBox(),
                      _Row(
                        label: "predictionLeftArgs".plural(predictionNumbers),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: 100,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isFinished
                              ? const Color(0xff353535)
                              : AppColors.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                            isFinished
                                ? "ended".tr()
                                : "dayLeft".tr(args: [daysLeft.toString()]),
                            style: context.labelSemiBold.copyWith(
                                color: Colors.white,
                                fontStyle: FontStyle.italic)),
                      )
                    ],
                  ),
                ),
              ]),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: GestureDetector(
                onTap: onInfoTap,
                child: const Icon(
                  BetterUnited.info,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PublicPouleInfoWidget extends StatelessWidget {
  const PublicPouleInfoWidget(
      {Key? key,
      required this.pouleName,
      required this.playerNumbers,
      required this.rank,
      required this.predictionNumbers,
      required this.daysLeft,
      required this.image,
      this.onInfoTap,
      required this.isFinished})
      : super(key: key);
  final String pouleName;
  final int playerNumbers;
  final int? rank;
  final int predictionNumbers;
  final int daysLeft;
  final Widget image;
  final bool isFinished;
  final GestureTapCallback? onInfoTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xff353535),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff7B7B7B), Color(0xff454545)],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: PouleInfoWidget(
          onInfoTap: onInfoTap,
          isFinished: isFinished,
          pouleName: pouleName,
          playerNumbers: playerNumbers,
          rank: rank,
          predictionNumbers: predictionNumbers,
          daysLeft: daysLeft,
          image: image,
        ));
  }
}

class FriendPouleWidget extends StatelessWidget {
  const FriendPouleWidget(
      {Key? key,
      required this.pouleName,
      required this.playerNumbers,
      required this.rank,
      required this.predictionNumbers,
      required this.daysLeft,
      required this.homeTeam,
      required this.awayTeam,
      required this.matchDate,
      required this.homeTeamLogoUrl,
      required this.awayTeamLogoUrl,
      this.onInfoTap,
      required this.isFinished})
      : super(key: key);
  final String pouleName;
  final int playerNumbers;
  final int? rank;
  final int predictionNumbers;
  final int daysLeft;
  final String homeTeam;
  final String awayTeam;
  final DateTime matchDate;
  final String? homeTeamLogoUrl;
  final String? awayTeamLogoUrl;
  final GestureTapCallback? onInfoTap;
  final bool isFinished;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xff353535),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff7B7B7B), Color(0xff454545)],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PouleInfoWidget(
            isFinished: isFinished,
            onInfoTap: onInfoTap,
            pouleName: pouleName,
            playerNumbers: playerNumbers,
            rank: rank,
            predictionNumbers: predictionNumbers,
            daysLeft: daysLeft,
            image: Transform.scale(
                scale: 1.1,
                child: Image.asset("assets/icons/ic-friendspoule.png")),
          ),
          const SizedBox(
            height: 8,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CustomPaint(
              painter: MatchDetailBackgroundPainter(),
              child: SizedBox(
                height: 73,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Align(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              fullDateFormatter.format(matchDate),
                              style: context.labelBold
                                  .copyWith(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              hoursMinutesFormatter.format(matchDate),
                              style: context.labelRegular
                                  .copyWith(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.center,
                        child: Align(
                          child: LayoutBuilder(builder: (context, constraints) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: constraints.maxWidth * 0.2, right: 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TeamIcon(
                                        height: 17,
                                        invertColor: true,
                                        logoUrl: homeTeamLogoUrl,
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: Text(
                                          homeTeam,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: context.labelBold
                                              .copyWith(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TeamIcon(
                                        height: 17,
                                        invertColor: true,
                                        logoUrl: awayTeamLogoUrl,
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: Text(
                                          awayTeam,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: context.labelBold
                                              .copyWith(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 7,
          width: 7,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            label,
            style: context.labelRegular.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final Color backgroundColor;
  final Color gradientColor;

  BackgroundPainter(
      {required this.backgroundColor, required this.gradientColor});

  @override
  void paint(Canvas canvas, Size size) {
    const gradientRatio = 0.05;
    const percent = 0.25;

    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0);

    canvas.drawPath(path, paint);

    final paint2 = Paint()
      ..color = const Color(0xff1E1E1E)
      ..style = PaintingStyle.fill;

    final paint3 = Paint()..style = PaintingStyle.fill;
    final linearGradient = LinearGradient(
      colors: [gradientColor, backgroundColor],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    final rect =
        Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height));
    paint3.shader = linearGradient.createShader(rect);

    final path2 = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * percent, 0)
      ..lineTo(size.width * percent + (size.width * percent) / 2, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0);

    final path3 = Path()
      ..moveTo(size.width * percent, 0)
      ..lineTo(size.width * percent + size.width * gradientRatio, 0)
      ..lineTo(
          size.width * percent +
              (size.width * percent) / 2 +
              size.width * gradientRatio,
          size.height)
      ..lineTo(size.width * percent, size.height);
    canvas.drawPath(path3, paint3);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MatchDetailBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const percent = 0.35;
    final paint = Paint()
      ..color = const Color(0xff1D1D1D)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0);

    canvas.drawPath(path, paint);

    final paint2 = Paint()
      ..color = const Color(0xff353535)
      ..style = PaintingStyle.fill;

    final path2 = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * percent, 0)
      ..lineTo(size.width * percent + (size.width * percent) / 5, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class PouleCardWidget extends StatelessWidget {
  const PouleCardWidget({
    Key? key,
    required this.image,
    required this.isActive,
    required this.child,
    this.childFlexValue = 3,
  }) : super(key: key);
  final Widget image;
  final bool isActive;
  final Widget child;
  final int childFlexValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xff353535),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff7B7B7B), Color(0xff454545)],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: CustomPaint(
          painter: BackgroundPainter(
            backgroundColor:
                isActive ? const Color(0xff4B4B4B) : const Color(0xff353535),
            gradientColor:
                isActive ? const Color(0xffC7C7C7) : AppColors.primary,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Row(children: [
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  flex: 2,
                  child: Align(
                    child: SizedBox(
                      height: 101,
                      width: 101,
                      child: image,
                    ),
                  )),
              const SizedBox(
                width: 24,
              ),
              Expanded(
                flex: childFlexValue,
                child: child,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

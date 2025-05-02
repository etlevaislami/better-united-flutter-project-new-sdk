import 'package:flutter/material.dart';
import 'package:flutter_better_united/widgets/team_icon.dart';

class LeagueCard extends StatelessWidget {
  const LeagueCard({
    Key? key,
    required this.isSelected,
    this.logoUrl,
    required this.teamName,
  }) : super(key: key);

  final bool isSelected;
  final String? logoUrl;
  final String teamName;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 180,
      width: 120,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        gradient: isSelected
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFAAE15E),
                  Color(0xff535353),
                ],
              )
            : null,
        color: const Color(0xff6B6B6B),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color(0x00000080),
              offset: Offset(0, 2),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
          color: const Color(0xff535353),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Expanded(
                flex: 5,
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xff535353),
                        gradient: isSelected
                            ? const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Color(0xFFAAE15E)],
                              )
                            : null,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8))),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: TeamIcon(
                      logoUrl: logoUrl,
                    ))),
            Expanded(
                flex: 3,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xff1D1D1D)
                          : const Color(0xff353535),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        teamName,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: isSelected
                                ? const Color(0xff9AE343)
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            shadows: const [
                              Shadow(
                                color: Color(0x00000080),
                                offset: Offset(0, 2),
                                blurRadius: 16,
                              ),
                            ],
                            fontSize: 12),
                      ),
                      //@todo remove later
                      const Text(
                        "Netherlands",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Color(0xff989898),
                          fontSize: 12,
                          shadows: [
                            Shadow(
                              color: Color(0x00000080),
                              offset: Offset(0, 2),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

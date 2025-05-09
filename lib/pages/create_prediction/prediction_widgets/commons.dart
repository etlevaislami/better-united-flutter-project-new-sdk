import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/figma/text_styles.dart';
import 'package:flutter_better_united/pages/create_prediction/prediction_widgets/handicap.dart';

import '../../../data/model/team.dart';
import '../../../figma/colors.dart';
import '../../../run.dart';
import '../../../util/betterUnited_icons.dart';
import '../../../util/common_ui.dart';
import '../../../widgets/background_container.dart';
import '../../../widgets/team_icon.dart';
import '../../../widgets/warning_toast.dart';
import 'home_draw_away.dart';

class PredictionContainer extends StatelessWidget {
  const PredictionContainer(
      {super.key,
        required this.children,
        required this.title,
        required this.isFolded,
        required this.isEnabled});

  final String title;
  final List<Widget> children;
  final bool isFolded;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return _ExpandablePanel(
      initialExpanded: (!isFolded),
      title: title,
      expandedChild: GestureDetector(
        onTap: isEnabled
            ? null
            : () {
          WarningToast.showToast(context,
              title: "betAlreadyMade".tr(),
              subtitle: "betTypeMaximumAllowed".tr());
        },
        child: AbsorbPointer(
          absorbing: !isEnabled,
          child: Opacity(
            opacity: isEnabled ? 1 : 0.5,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ExpandablePanel extends StatefulWidget {
  const _ExpandablePanel(
      {required this.expandedChild,
        required this.title,
        required this.initialExpanded});

  final String title;
  final Widget expandedChild;
  final bool initialExpanded;

  @override
  State<_ExpandablePanel> createState() => _ExpandablePanelState();
}

class _ExpandablePanelState extends State<_ExpandablePanel> {
  late final ExpandableController _controller;

  @override
  void initState() {
    logger.e(widget.title + widget.initialExpanded.toString());
    _controller = ExpandableController(initialExpanded: widget.initialExpanded);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondary,
      child: ExpandablePanel(
        controller: _controller,
        header: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            alignment: Alignment.centerLeft,
            height: 48,
            child: Text(
              widget.title.toUpperCase(),
              style: AppTextStyles.textStyle2,
            )),
        collapsed: Container(
          height: 1,
          color: AppColors.background,
        ),
        expanded: Container(
          color: AppColors.background,
          child: widget.expandedChild,
        ),
        theme: const ExpandableThemeData(
          headerAlignment: ExpandablePanelHeaderAlignment.center,
          tapBodyToCollapse: true,
          tapBodyToExpand: true,
          hasIcon: true,
          iconColor: Colors.white,
          iconSize: 16,
          iconPadding: EdgeInsets.symmetric(horizontal: 24),
          collapseIcon: BetterUnited.arrowUp,
          expandIcon: BetterUnited.arrowUp,
        ),
      ),
    );
  }
}

class PointsCard extends StatelessWidget {
  const PointsCard(
      {super.key,
        required this.text,
        required this.points,
        this.widthRatio = 0.8});

  final String text;
  final int points;
  final double widthRatio;

  @override
  Widget build(BuildContext context) {
    return BetCard(
      widthRatio: widthRatio,
      leadingChild: AutoSizeText(
        text,
        maxLines: 1,
        minFontSize: 1,
        stepGranularity: 0.1,
        style: context.labelBetType.copyWith(color: Colors.white),
      ),
      trailingChild: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: PointsText(points: points),
        ),
      ),
    );
  }
}

class BetCard extends StatelessWidget {
  const BetCard(
      {super.key,
        this.leadingChild,
        this.trailingChild,
        this.centerChild,
        this.widthRatio = 0.8});

  final Widget? leadingChild;
  final Widget? trailingChild;
  final Widget? centerChild;
  final double widthRatio;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFAEAEAE), Color(0xff5A5A5A)],
        ),
        color: Colors.grey,
      ),
      child: BackgroundContainer(
          widthRatio: widthRatio,
          isCenterChildConstrained: false,
          leadingChild: leadingChild,
          trailingChild: trailingChild,
          centerChild: centerChild,
          foregroundColor: AppColors.secondary,
          gradientEndColor: AppColors.primary,
          backgroundColor: AppColors.buttonInnactive),
    );
  }
}

class PointsText extends StatelessWidget {
  const PointsText({super.key, required this.points});

  final int points;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: "+$points",
          style: context.labelBold.copyWith(color: Colors.white),
        ),
        TextSpan(
          text: "pointArgs".plural(134),
          style: context.labelBold.copyWith(color: Colors.white, fontSize: 10),
        ),
      ]),
    );
  }
}

class PlayerBetDetail {
  final String name;
  final int points;
  final int position;

  PlayerBetDetail(this.name, this.points, this.position);
}

class TeamWithPlayersBet {
  final Team team;
  final List<PlayerBetDetail> players;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TeamWithPlayersBet &&
              runtimeType == other.runtimeType &&
              team == other.team &&
              players == other.players;

  ///ignore
  @override
  int get hashCode => super.hashCode;

  TeamWithPlayersBet({required this.team, required this.players});
}

class TeamWithPlayersBetWidget extends StatefulWidget {
  const TeamWithPlayersBetWidget(
      {super.key,
        required this.homeTeam,
        required this.awayTeam,
        required this.onSelected});

  final TeamWithPlayersBet homeTeam;
  final TeamWithPlayersBet awayTeam;
  final Function(String, int) onSelected;

  @override
  State<TeamWithPlayersBetWidget> createState() =>
      _TeamWithPlayersBetWidgetState();
}

class _TeamWithPlayersBetWidgetState extends State<TeamWithPlayersBetWidget> {
  late final list = [widget.homeTeam, widget.awayTeam];
  late TeamWithPlayersBet selectedTeam = list.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<TeamWithPlayersBet>(
              isDense: true,
              buttonStyleData: ButtonStyleData(
                  padding: EdgeInsets.zero,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.textFilled,
                    boxShadow: appBoxShadow,
                    border: Border.all(
                      color: AppColors.buttonInnactive,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  )),
              iconStyleData: const IconStyleData(
                icon: Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(
                    BetterUnited.arrowDown,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                iconSize: 16,
              ),
              dropdownStyleData: DropdownStyleData(
                padding: EdgeInsets.zero,
                maxHeight: context.height / 3,
                elevation: 0,
                decoration: const BoxDecoration(
                  color: AppColors.textFilled,
                  boxShadow: appBoxShadow,
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                ),
              ),
              value: selectedTeam,
              items: list
                  .mapIndexed(
                    (index, teamWithPlayersBet) =>
                    DropdownMenuItem<TeamWithPlayersBet>(
                      alignment: Alignment.center,
                      value: teamWithPlayersBet,
                      child: Container(
                        color: AppColors.textFilled,
                        child: Row(
                          children: [
                            const TeamIcon(
                              height: 18,
                              invertColor: true,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              teamWithPlayersBet.team.name,
                              style: context.labelBold
                                  .copyWith(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
              )
                  .toList(),
              onChanged: (team) {
                if (team != null) {
                  setState(() {
                    selectedTeam = team;
                  });
                }
              },
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final player = selectedTeam.players[index];
              return _PlayerNamesCard(
                name: player.name,
                points: player.points,
                position: player.position,
                onPointTap: () => widget.onSelected(player.name, player.points),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 12,
              );
            },
            itemCount: selectedTeam.players.length)
      ],
    );
  }
}

class _PlayerNamesCard extends StatelessWidget {
  const _PlayerNamesCard(
      {required this.name,
        required this.points,
        this.position,
        required this.onPointTap});

  final String name;
  final int points;
  final int? position;
  final GestureTapCallback onPointTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        position == null
            ? const SizedBox()
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            position.toString(),
            style: context.labelBold.copyWith(color: AppColors.primary),
          ),
        ),
        Expanded(
            child: Text(
              name,
              style: context.labelBold.copyWith(color: Colors.white),
            )),
        GestureDetector(
          onTap: onPointTap,
          child: SizedBox(
            width: 103,
            child: BetCard(
              widthRatio: 0.2,
              centerChild: PointsText(
                points: points,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class PlayersBetWidget extends StatelessWidget {
  const PlayersBetWidget({Key? key, required this.data, required this.onBetTap})
      : super(key: key);
  final List<BetData> data;
  final OnBetTap onBetTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final bet = data[index];
              return _PlayerNamesCard(
                  name: bet.text,
                  points: bet.points,
                  onPointTap: () => onBetTap(bet.points, bet.betId, bet.hint));
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 12,
              );
            },
            itemCount: data.length)
      ],
    );
  }
}

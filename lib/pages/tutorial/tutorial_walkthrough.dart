import 'dart:ui';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/net/models/tutorial.dart';
import 'package:flutter_better_united/pages/tutorial/blur_hole_painter.dart';
import 'package:flutter_better_united/pages/tutorial/tutorial_consts.dart';
import 'package:flutter_better_united/run.dart';
import 'package:flutter_better_united/widgets/info_bubble.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';

class TutorialWalkthrough extends StatefulWidget {
  const TutorialWalkthrough(
      {super.key,
      required this.child,
      required this.tutorials,
      required this.onFinished});

  final List<Tutorial> tutorials;
  final Widget child;
  final Function onFinished;

  @override
  State<TutorialWalkthrough> createState() => _TutorialWalkthroughState();
}

class _TutorialWalkthroughState extends State<TutorialWalkthrough> {
  int index = 0;
  Path holePath = Path();

  @override
  void initState() {
    index = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) => _calculateHole());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tutorials.length - 1 < index) {
      return const SizedBox.shrink();
    }
    return WillPopScope(
      onWillPop: () async {
        if (index == 0) {
          // Do nothing, not able to go back.
          // _onTutorialSkipped();
        } else {
          _onBackClicked();
        }
        return false;
      },
      child: Stack(
        children: [
          widget.child,
          _buildDimLayer(context),
          _buildInfoBubbleLayer(widget.tutorials[index]),
          Visibility(
            visible: widget.tutorials[index].tapType == TapType.anywhere,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: IgnorePointer(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 60, horizontal: 10),
                  child: Text('tapAnywhereToContinue'.tr()),
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.tutorials[index].tapType == TapType.onDoneButton,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 35, horizontal: 24),
                child: PrimaryButton(
                    onPressed: () => widget.onFinished(), text: "done".tr()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDimLayer(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onTapUp: (details) {
          _handleTapEvent(details.localPosition);
        },
        child: CustomPaint(
          painter: BlurHolePainter(holePath),
        ),
      ),
    );
  }

  Widget _buildInfoBubbleLayer(Tutorial tutorial) {
    final height =
        MediaQuery.of(context).size.height * 0.01 * tutorial.verticalPosition;
    const sideMargin = 24.0;

    return Positioned(
      bottom: height,
      child: IgnorePointer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: sideMargin),
          child: SizedBox(
              width: MediaQuery.of(context).size.width - 2 * sideMargin,
              child: InfoBubble(
                  title: tutorial.title.toUpperCase(),
                  description: tutorial.content)),
        ),
      ),
    );
  }

  void _calculateHole() {
    if (widget.tutorials[index].visibleWidgetKey.currentContext == null) {
      return;
    }
    final renderBox = widget.tutorials[index].visibleWidgetKey.currentContext
        ?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final offset = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;

      setState(() {
        holePath = widget.tutorials[index].buildPath(offset, size)
          ..fillType = PathFillType.evenOdd;
      });
    }
  }

  _onNextClicked() {
    if (widget.tutorials.length - 1 == index) {
      widget.onFinished();
      return;
    } else {
      setState(() {
        index++;
        TutorialUtils.logTutorialStepAnalyticEvents(index);
        WidgetsBinding.instance.addPostFrameCallback((_) => _calculateHole());
      });
    }
  }

  _onBackClicked() {
    setState(() {
      index--;
      TutorialUtils.logTutorialStepAnalyticEvents(index);
      WidgetsBinding.instance.addPostFrameCallback((_) => _calculateHole());
    });
  }

  _onTutorialSkipped() {
    TutorialUtils.logTutorialSkippedStepAnalyticEvents(index);
    context.pop();
  }

  _onTutorialCompleted() {
    analytics.logEvent(name: TutorialUtils.tutorialCompletedEvent);
    context.pop();
  }

  double _getXOffset(int index) {
    if (index == TutorialUtils.homeIndex) return context.width / 30;

    if (index == TutorialUtils.friendLeague) return context.width / 5;

    if (index == TutorialUtils.createATip) return context.width / 2.4;

    if (index == TutorialUtils.shopIndex) return context.width / 1.57;

    if (index == TutorialUtils.moreTeam) return context.width / 1.25;

    return context.width;
  }

  void _handleTapEvent(Offset tapPosition) {
    final tutorialTapType = widget.tutorials[index].tapType;
    if (tutorialTapType == TapType.anywhere) {
      _onNextClicked();
    } else if (tutorialTapType == TapType.onWidget) {
      if (isInsideHole(tapPosition)) {
        _onNextClicked();
      }
    }
  }

  bool isInsideHole(Offset point) {
    PathMetrics pathMetrics = holePath.computeMetrics();
    for (PathMetric metric in pathMetrics) {
      if (metric.getTangentForOffset(0) != null) {
        if (holePath.contains(point)) {
          return true;
        }
      }
    }
    return false;
  }
}

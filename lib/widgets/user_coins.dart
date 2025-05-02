import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/figma/colors.dart';
import 'package:flutter_better_united/pages/shop/user_provider.dart';
import 'package:flutter_better_united/widgets/rounded_container.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class UserCoins extends StatelessWidget {
  const UserCoins({
    super.key,
    this.onAnimationEnd,
    this.delayedAnimationCallBack = const Duration(seconds: 1),
    this.backgroundColor = AppColors.background,
  });

  final Function? onAnimationEnd;
  final Duration delayedAnimationCallBack;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final coins = context.watch<UserProvider>().userCoins;
    return AnimatedCoinsWidget(
      coins: coins,
      onAnimationEnd: onAnimationEnd,
      delayedAnimationCallBack: delayedAnimationCallBack,
      backgroundColor: backgroundColor,
    );
  }
}

class AnimatedCoinsWidget extends StatefulWidget {
  const AnimatedCoinsWidget({
    super.key,
    required this.coins,
    this.onAnimationEnd,
    this.delayedAnimationCallBack = const Duration(seconds: 1),
    this.backgroundColor = AppColors.background,
  });

  final Function? onAnimationEnd;
  final int coins;
  final Duration delayedAnimationCallBack;
  final Color backgroundColor;

  @override
  State<AnimatedCoinsWidget> createState() => _AnimatedCoinsWidgetState();
}

class _AnimatedCoinsWidgetState extends State<AnimatedCoinsWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late AnimationController _textAnimationController;
  late Animation<Offset> _textTranslationAnimation;
  late Animation<double> _fadeAnimation;
  final autoSizeGroup = AutoSizeGroup();
  int _coins = 0;
  String _newCoins = "";
  static const String earnedCoinAsset = "assets/animations/coin-reward.json";
  static const String spentCoinAsset = "assets/animations/coin-payment.json";
  String _lottieAsset = earnedCoinAsset;

  @override
  void didUpdateWidget(covariant AnimatedCoinsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.coins != widget.coins ? _beginAnimation(oldWidget.coins) : null;
  }

  _handleInitialization() {
    _coins = widget.coins;
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _textAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _textTranslationAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -1),
    ).animate(_textAnimationController);
    _fadeAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 0.0),
        weight: 1,
      ),
    ]).animate(_controller);
  }

  _beginAnimation(int oldCoins) async {
    _controller.reset();
    _textAnimationController.reset();
    final coins = widget.coins - oldCoins;
    if (coins > 0) {
      setState(() {
        _newCoins = "+$coins";
        _lottieAsset = earnedCoinAsset;
      });
      _textAnimationController.value = 0;
      _textAnimationController.forward();
    } else {
      setState(() {
        _newCoins = "$coins";
        _lottieAsset = spentCoinAsset;
      });
      _textAnimationController.value = 1;
      _textAnimationController.reverse();
    }
    await _controller.forward();
    setState(() {
      _coins = widget.coins;
    });
    await Future.delayed(widget.delayedAnimationCallBack);
    widget.onAnimationEnd?.call();
  }

  @override
  void initState() {
    super.initState();
    _handleInitialization();
  }

  @override
  void dispose() {
    _controller.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 39,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          RoundedContainer(
            backgroundColor: widget.backgroundColor,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 24,
                  height: 24,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  _coins.toString(),
                  maxLines: 1,
                  textDirection: TextDirection.rtl,
                  style: context.titleH2.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 1.4,
            child: Transform.translate(
                offset: const Offset(0, 1),
                child: Lottie.asset(_lottieAsset, controller: _controller)),
          ),
          Transform.translate(
            offset: const Offset(30, 30),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _textTranslationAnimation,
                child: AutoSizeText(
                  _newCoins,
                  style: context.titleH2
                      .copyWith(color: Colors.white, fontSize: 12),
                  maxLines: 1,
                  minFontSize: 1,
                  group: autoSizeGroup,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

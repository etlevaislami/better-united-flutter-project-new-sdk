import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/custom_app_decorations.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/figma/dimensions.dart';
import 'package:flutter_better_united/pages/ranking/team_of_week/ranking_app_bar_background_overlay_shape_path.dart';
import 'package:flutter_better_united/util/betterUnited_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../figma/colors.dart';
import 'fixed_button.dart';

class RegularAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RegularAppBar({
    Key? key,
    this.title,
    this.withBackgroundImage = false,
    this.imageOpacity = 1,
    this.textAlign = TextAlign.center,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor = const Color(0xff1D1D1D),
  }) : super(key: key);
  final String? title;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool withBackgroundImage;
  final double imageOpacity;
  final TextAlign? textAlign;
  final Color? backgroundColor;
  static const appBarHeight = 100.0;

  RegularAppBar.fromModal(
      {Key? key, required VoidCallback onCloseTap, required String title})
      : this(
            key: key,
            suffixIcon:
                FixedButton(iconData: BetterUnited.remove, onTap: onCloseTap),
            title: title,
            textAlign: TextAlign.center);

  RegularAppBar.withBackButton(
      {Key? key,
      required String title,
      required VoidCallback? onBackTap,
      VoidCallback? onCloseTap})
      : this(
          key: key,
          prefixIcon: onBackTap != null
              ? FixedButton(onTap: onBackTap, iconData: BetterUnited.triangle)
              : null,
          title: title,
          textAlign: TextAlign.center,
          suffixIcon: onCloseTap != null
              ? FixedButton(onTap: onCloseTap, iconData: BetterUnited.remove)
              : null,
        );

  RegularAppBar.withText({
    Key? key,
    required String title,
    VoidCallback? onBackTap,
  }) : this(
          key: key,
          title: title,
          textAlign: TextAlign.center,
          prefixIcon: onBackTap != null
              ? FixedButton(onTap: onBackTap, iconData: BetterUnited.triangle)
              : null,
        );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: preferredSize.height,
          child: Stack(
            children: [
              Positioned.fill(
                  child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  image: withBackgroundImage
                      ? DecorationImage(
                          opacity: imageOpacity,
                          // Specify the image asset or network URL
                          image:
                              const AssetImage('assets/images/img_stadium.png'),
                          // Optionally, you can set the fit property
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              )),
              SafeArea(
                child: SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: LayoutBuilder(
                      builder: (context, boxConstraint) => Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 24.0),
                                  child: prefixIcon ?? const SizedBox(),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 24.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      suffixIcon ?? const SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                              title == null
                                  ? const SizedBox()
                                  : Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                          width: boxConstraint.maxWidth * 0.6,
                                          child: Text(
                                            title?.toUpperCase() ?? '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: textAlign,
                                            style: const TextStyle(
                                                shadows: [
                                                  Shadow(
                                                    offset: Offset(0, 2),
                                                    blurRadius: 16,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.5),
                                                  ),
                                                ],
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w700),
                                          )),
                                    ),
                            ],
                          )),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}

class RegularAppBarV2 extends StatelessWidget implements PreferredSizeWidget {
  const RegularAppBarV2({
    Key? key,
    this.onCloseTap,
    this.onBackTap,
    this.onInfoTap,
    this.image,
    this.title,
  }) : super(key: key);
  final VoidCallback? onCloseTap;
  final VoidCallback? onBackTap;
  final VoidCallback? onInfoTap;
  final Widget? image;
  final String? title;

  static const appBarHeight = 165.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: Stack(
        children: [
          RegularAppBar(
            title: title,
            imageOpacity: onBackTap == null ? 0.5 : 1,
            withBackgroundImage: true,
            prefixIcon: onBackTap != null
                ? FixedButton(iconData: BetterUnited.triangle, onTap: onBackTap)
                : null,
            suffixIcon: onInfoTap != null
                ? FixedButton(iconData: BetterUnited.info, onTap: onInfoTap)
                : null,
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    //fix shadow
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.24),
                      blurRadius: 40,
                      spreadRadius: 0,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                height: 120,
                width: 120,
                child: image,
              ))
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}

class RegularAppBarV3 extends StatelessWidget implements PreferredSizeWidget {
  static const appBarHeight = 185.0;

  const RegularAppBarV3({
    Key? key,
    this.onCloseTap,
    this.onBackTap,
    this.onInfoTap,
    this.title,
    this.child,
  }) : super(key: key);
  final VoidCallback? onCloseTap;
  final VoidCallback? onBackTap;
  final VoidCallback? onInfoTap;
  final String? title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: Stack(
        children: [
          Container(
            height: 149,
            decoration: const BoxDecoration(
                image: DecorationImage(
              // Specify the image asset or network URL
              image: AssetImage('assets/images/img_stadium.png'),
              // Optionally, you can set the fit property
              fit: BoxFit.cover,
            )),
          ),
          RegularAppBar(
            backgroundColor: null,
            title: title,
            imageOpacity: onBackTap == null ? 0.5 : 1,
            withBackgroundImage: false,
            prefixIcon: onBackTap != null
                ? FixedButton(iconData: BetterUnited.triangle, onTap: onBackTap)
                : null,
            suffixIcon: onInfoTap != null
                ? FixedButton(iconData: BetterUnited.info, onTap: onInfoTap)
                : null,
          ),
          Align(alignment: Alignment.bottomCenter, child: child)
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}

class RegularAppBarV4 extends StatelessWidget implements PreferredSizeWidget {
  const RegularAppBarV4({
    Key? key,
    this.onCloseTap,
    this.onBackTap,
    this.onInfoTap,
    required this.title,
  }) : super(key: key);
  final VoidCallback? onCloseTap;
  final VoidCallback? onBackTap;
  final VoidCallback? onInfoTap;
  final String title;
  static const appBarHeight = 213.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                RegularAppBar(
                  imageOpacity: onBackTap == null ? 0.5 : 1,
                  withBackgroundImage: true,
                  prefixIcon: onBackTap != null
                      ? FixedButton(
                          iconData: BetterUnited.triangle, onTap: onBackTap)
                      : null,
                  suffixIcon: onInfoTap != null
                      ? FixedButton(
                          iconData: BetterUnited.info, onTap: onInfoTap)
                      : null,
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: Image.asset(
                        "assets/icons/ic-friendspoule.png",
                      ),
                    ))
              ],
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -14),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primary, width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    minFontSize: 1,
                    style: context.titleH3.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}

class RegularAppBarV5 extends StatelessWidget implements PreferredSizeWidget {
  const RegularAppBarV5({
    Key? key,
    required this.onCloseTap,
    required this.onBackTap,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final VoidCallback onCloseTap;
  final VoidCallback onBackTap;
  final String title;
  static const appBarHeight = 266.0;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: Column(
        children: [
          RegularAppBar.withBackButton(
            title: title,
            onBackTap: onBackTap,
            onCloseTap: onCloseTap,
          ),
          HalfCircleBar(centerChild: icon),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}

class CustomClippes extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width, size.height / 2);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class RegularAppBarV6 extends StatelessWidget implements PreferredSizeWidget {
  const RegularAppBarV6({
    Key? key,
    required this.onCloseTap,
    required this.onBackTap,
    required this.icon,
    this.backgroundColor = AppColors.background,
  }) : super(key: key);
  final VoidCallback onCloseTap;
  final VoidCallback onBackTap;
  final Color backgroundColor;
  static const appBarHeight = 166.0;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: HalfCircleBar(
        centerChild: icon,
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}

class HalfCircleBar extends StatelessWidget {
  final Color backgroundColor;
  final Widget centerChild;

  const HalfCircleBar({
    super.key,
    required this.centerChild,
    this.backgroundColor = AppColors.background,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 166,
      child: Stack(
        children: [
          ClipRect(
            clipper: CustomClippes(),
            child: Container(
              color: backgroundColor,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffBAD450),
                ),
              ),
            ),
          ),
          Center(
            child: Transform.scale(scale: 0.8, child: centerChild),
          )
        ],
      ),
    );
  }
}

class RegularAppBarV7 extends StatelessWidget implements PreferredSizeWidget {
  static const double appBarHeight = AppDimensions.teamOfWeekAppBarHeight;

  const RegularAppBarV7({
    Key? key,
    this.onCloseTap,
    this.onBackTap,
    this.onInfoTap,
    this.title,
    this.child,
  }) : super(key: key);
  final VoidCallback? onCloseTap;
  final VoidCallback? onBackTap;
  final VoidCallback? onInfoTap;
  final String? title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final overlayLogoWidth = context.width * 0.73;
    final overlayLogoHeight = preferredSize.height * 0.73;

    final backgroundOverlayWidget = SizedBox(
      height: overlayLogoHeight,
      width: overlayLogoWidth,
      child: Padding(
        // this top padding defines the offset of the overlay.
        padding: const EdgeInsets.only(top: 12),
        child: Stack(
          alignment: Alignment.topCenter,
          // mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "assets/other/team_of_week_bg_logo_pt3.svg",
              width: overlayLogoWidth,
              height: overlayLogoHeight,
            ),
            SvgPicture.asset(
              "assets/other/team_of_week_bg_logo_pt1.svg",
              width: overlayLogoWidth,
              height: overlayLogoHeight,
              // color: Colors.pink,
            ),
            Container(
              width: overlayLogoWidth,
              height: overlayLogoHeight,
              padding: const EdgeInsets.symmetric(vertical: 20),
              // color: Colors.pink,
              child: ClipPath(
                clipper: RankingAppBarBackgroundOverlayShapePath(),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                  child: SizedBox(
                    width: overlayLogoWidth,
                    height: overlayLogoHeight,
                    // color: Colors.white,
                  ),
                ),
              ),
            ),
            SvgPicture.asset(
              "assets/other/team_of_week_bg_logo_pt2.svg",
              width: overlayLogoWidth,
              height: overlayLogoHeight,
            ),
          ],
        ),
      ),
    );

    return SizedBox(
      height: preferredSize.height,
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (rect) {
              return  CustomAppDecorations.bottomTransparentGradient().createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: Image.asset(
              "assets/images/img_stadium.png",
              alignment: Alignment.bottomCenter,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
                child: backgroundOverlayWidget),
          ),
          RegularAppBar(
            backgroundColor: null,
            title: title,
            imageOpacity: onBackTap == null ? 0.5 : 1,
            withBackgroundImage: false,
            prefixIcon: onBackTap != null
                ? FixedButton(iconData: BetterUnited.triangle, onTap: onBackTap)
                : null,
            suffixIcon: onInfoTap != null
                ? FixedButton(iconData: BetterUnited.info, onTap: onInfoTap)
                : null,
          ),
          Align(alignment: Alignment.bottomCenter, child: child)
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}

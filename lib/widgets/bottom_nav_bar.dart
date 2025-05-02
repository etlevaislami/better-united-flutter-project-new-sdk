import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class BottomNavBar extends StatelessWidget {
  final NavBarEssentials navBarEssentials;

  const BottomNavBar({
    Key? key,
    this.navBarEssentials = const NavBarEssentials(items: null),
  }) : super(key: key);

  Widget _buildItem(
    PersistentBottomNavBarItem item,
    bool isSelected,
    double? height,
  ) {
    if (navBarEssentials.navBarHeight == 0) {
      return const SizedBox.shrink();
    }

    final itemAnimationProperties = navBarEssentials.itemAnimationProperties;
    final activeColor = isSelected
        ? item.activeColorSecondary ?? item.activeColorPrimary
        : item.inactiveColorPrimary ?? item.activeColorPrimary;

    return AnimatedContainer(
      width: 100.0,
      height: height! / 1.0,
      duration: itemAnimationProperties?.duration ??
          const Duration(milliseconds: 1000),
      curve: itemAnimationProperties?.curve ?? Curves.ease,
      alignment: Alignment.center,
      child: AnimatedContainer(
        duration: itemAnimationProperties?.duration ??
            const Duration(milliseconds: 1000),
        curve: itemAnimationProperties?.curve ?? Curves.ease,
        alignment: Alignment.center,
        height: height / 1.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: IconTheme(
                data: IconThemeData(
                  size: item.iconSize,
                  color: activeColor,
                ),
                child: isSelected ? item.icon : item.inactiveIcon ?? item.icon,
              ),
            ),
            if (item.title != null)
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Material(
                  type: MaterialType.transparency,
                  child: DefaultTextStyle.merge(
                    style: TextStyle(
                      color:
                          (item.textStyle?.apply(color: activeColor))?.color ??
                              activeColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                    ),
                    child: FittedBox(child: Text(item.title!)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedItem =
        navBarEssentials.items![navBarEssentials.selectedIndex!];
    final selectedItemActiveColor = selectedItem.activeColorPrimary;
    final itemWidth = ((MediaQuery.of(context).size.width -
            ((navBarEssentials.padding?.left ??
                    MediaQuery.of(context).size.width * 0.05) +
                (navBarEssentials.padding?.right ??
                    MediaQuery.of(context).size.width * 0.05))) /
        navBarEssentials.items!.length);

    return Container(
      width: double.infinity,
      height: navBarEssentials.navBarHeight,
      padding: EdgeInsets.only(
        top: navBarEssentials.padding?.top ?? 0.0,
        left: navBarEssentials.padding?.left ??
            MediaQuery.of(context).size.width * 0.05,
        right: navBarEssentials.padding?.right ??
            MediaQuery.of(context).size.width * 0.05,
        bottom: navBarEssentials.padding?.bottom ??
            navBarEssentials.navBarHeight! * 0.1,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              AnimatedContainer(
                duration: navBarEssentials.itemAnimationProperties?.duration ??
                    const Duration(milliseconds: 300),
                curve: navBarEssentials.itemAnimationProperties?.curve ??
                    Curves.ease,
                color: Colors.transparent,
                width: navBarEssentials.selectedIndex == 0
                    ? MediaQuery.of(context).size.width * 0.0
                    : itemWidth * navBarEssentials.selectedIndex!,
                height: 4.0,
              ),
              Flexible(
                child: Transform.translate(
                  offset: Offset(itemWidth / 4, 0),
                  child: AnimatedContainer(
                    margin: const EdgeInsets.only(top: 5),
                    duration:
                        navBarEssentials.itemAnimationProperties?.duration ??
                            const Duration(milliseconds: 300),
                    curve: navBarEssentials.itemAnimationProperties?.curve ??
                        Curves.ease,
                    width: itemWidth / 2,
                    height: 4.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selectedItemActiveColor,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: navBarEssentials.items!.map((item) {
                  int index = navBarEssentials.items!.indexOf(item);
                  return Flexible(
                    child: GestureDetector(
                      onTap: () {
                        if (item.onPressed != null) {
                          item.onPressed!(
                              navBarEssentials.selectedScreenBuildContext);
                        } else {
                          navBarEssentials.onItemSelected!(index);
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: _buildItem(
                            item,
                            navBarEssentials.selectedIndex == index,
                            navBarEssentials.navBarHeight),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

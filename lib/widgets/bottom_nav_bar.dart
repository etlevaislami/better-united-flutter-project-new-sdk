import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class BottomNavBar extends StatelessWidget {
  final NavBarConfig navBarConfig;
  final NavBarDecoration navBarDecoration;
  final ItemAnimation itemAnimation;
  final double navBarHeight;

  const BottomNavBar(
      {super.key,
      required this.navBarConfig,
      required this.navBarHeight,
      this.navBarDecoration = const NavBarDecoration(),
      this.itemAnimation = const ItemAnimation()});

  Widget _buildItem(
    ItemConfig item,
    bool isSelected,
    double? height,
  ) {
    if (height == 0) {
      return const SizedBox.shrink();
    }

    final activeColor =
        isSelected ? item.activeForegroundColor : item.inactiveForegroundColor;

    return AnimatedContainer(
      width: 100.0,
      height: height! / 1.0,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.ease,
      alignment: Alignment.center,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.ease,
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
                child: isSelected ? item.icon : item.inactiveIcon,
              ),
            ),
            if (item.title != null)
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Material(
                  type: MaterialType.transparency,
                  child: DefaultTextStyle.merge(
                    style: TextStyle(
                      color: (item.textStyle.apply(color: activeColor)).color ??
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
    final selectedItem = navBarConfig.items[navBarConfig.selectedIndex];

    final selectedItemActiveColor = selectedItem.activeForegroundColor;
    final itemWidth = ((MediaQuery.of(context).size.width -
            ((MediaQuery.of(context).size.width * 0.05) +
                (MediaQuery.of(context).size.width * 0.05))) /
        navBarConfig.items.length);

    return Container(
      width: double.infinity,
      height: navBarConfig.navBarHeight,
      padding: EdgeInsets.only(
        top: 0.0,
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
        bottom: navBarConfig.navBarHeight * 0.4,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
                color: Colors.transparent,
                width: navBarConfig.selectedIndex == 0
                    ? MediaQuery.of(context).size.width * 0.0
                    : itemWidth * navBarConfig.selectedIndex,
                height: 4.0,
              ),
              Flexible(
                child: Transform.translate(
                  offset: Offset(itemWidth / 4, 0),
                  child: AnimatedContainer(
                    margin: const EdgeInsets.only(top: 5),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
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
                children: navBarConfig.items.map((item) {
                  int index = navBarConfig.items.indexOf(item);
                  return Flexible(
                    child: GestureDetector(
                      onTap: () {
                        navBarConfig.onItemSelected(index);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: _buildItem(
                            item,
                            navBarConfig.selectedIndex == index,
                            navBarConfig.navBarHeight),
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

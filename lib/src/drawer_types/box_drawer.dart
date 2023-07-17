import 'package:flutter/material.dart';

import '../model/drawer_menu_item.dart';

class BoxDrawer extends StatefulWidget {
  const BoxDrawer({
    super.key,
    required this.selectedIndex,
    required this.menuItems,
    required this.drawerItemsHeight,
    required this.drawerItemsWidth,
    required this.selectedColor,
    required this.unSelectedColor,
    required this.selectedItemBackgroundColor,
    required this.animationDuration,
    required this.boxDrawerItemRadius,
    required this.menuTextStyle,
  });

  final int selectedIndex;
  final Color selectedColor;
  final Color unSelectedColor;
  final Color selectedItemBackgroundColor;
  final List<DrawerMenuItem> menuItems;
  final double drawerItemsWidth;
  final double drawerItemsHeight;
  final Duration animationDuration;
  final BorderRadius boxDrawerItemRadius;
  final TextStyle menuTextStyle;

  @override
  State<BoxDrawer> createState() => _BoxDrawerState();
}

class _BoxDrawerState extends State<BoxDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: widget.animationDuration,
                top: widget.drawerItemsHeight * widget.selectedIndex,
                child: Container(
                  height: widget.drawerItemsHeight,
                  width: widget.drawerItemsWidth,
                  decoration: BoxDecoration(
                      color: widget.selectedItemBackgroundColor,
                      borderRadius: widget.boxDrawerItemRadius),
                ),
              ),
              Column(
                  children: widget.menuItems
                      .asMap()
                      .map((int i, DrawerMenuItem page) => MapEntry(
                          i,
                          SizedBox(
                            height: widget.drawerItemsHeight,
                            width: widget.drawerItemsWidth,
                            child: InkWell(
                              borderRadius: widget.boxDrawerItemRadius,
                              onTap: page.onMenuTapped,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: widget.drawerItemsWidth * .2,
                                  ),
                                  Icon(
                                    page.icon,
                                    size: page.iconSize,
                                    color: widget.selectedIndex == i
                                        ? widget.selectedColor
                                        : widget.unSelectedColor,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Text(
                                      page.title,
                                      style: widget.menuTextStyle.copyWith(
                                        fontWeight: widget.selectedIndex == i
                                            ? FontWeight.bold
                                            : null,
                                        color: widget.selectedIndex == i
                                            ? widget.selectedColor
                                            : widget.unSelectedColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  page.prefixWidget ?? Container(),
                                ],
                              ),
                            ),
                          )))
                      .values
                      .toList()),
            ],
          ),
        ),
      ],
    );
  }
}

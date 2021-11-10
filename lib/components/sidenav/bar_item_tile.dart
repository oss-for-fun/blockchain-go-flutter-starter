import 'package:flutter/material.dart';

import 'side_navigation_bar_item.dart';
import 'side_navigation_bar.dart';

class SideNavigationBarItemTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final ValueChanged<int> onTap;
  final int index;

  final Color color;
  final bool expanded;
  const SideNavigationBarItemTile(
      {Key? key,
      required this.icon,
      required this.label,
      required this.onTap,
      required this.index,
      required this.color,
      required this.expanded})
      : super(key: key);

  @override
  _SideNavigationBarItemTileState createState() =>
      _SideNavigationBarItemTileState();
}

class _SideNavigationBarItemTileState extends State<SideNavigationBarItemTile> {
  @override
  Widget build(BuildContext context) {
    final List<SideNavigationBarItem> barItems =
        SideNavigationBar.of(context).widget.items;
    final int selectedIndex =
        SideNavigationBar.of(context).widget.selectedIndex;
    final bool isSelected = isTileSelected(barItems, selectedIndex);

    return widget.expanded
        ? ListTile(
            leading: Icon(
              widget.icon,
              color: getTileColor(isSelected),
            ),
            title: Text(
              widget.label,
              style: TextStyle(
                color: getTileColor(isSelected),
              ),
            ),
            onTap: () {
              widget.onTap(widget.index);
            },
          )
        : IconButton(
            icon: Icon(
              widget.icon,
              color: getTileColor(isSelected),
            ),
            onPressed: () {
              widget.onTap(widget.index);
            },
          );
  }

  bool isTileSelected(
      final List<SideNavigationBarItem> items, final int index) {
    for (final SideNavigationBarItem item in items) {
      if (item.label == widget.label && index == widget.index) {
        return true;
      }
    }
    return false;
  }

  Color getTileColor(final bool isSelected) {
    return isSelected
        ? widget.color
        : (Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.grey);
  }
}

import 'package:flutter/material.dart';

import 'bar_item_tile.dart';
import 'side_navigation_bar_item.dart';

class SideNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final List<SideNavigationBarItem> items;
  final ValueChanged<int> onTap;
  final Color? color;
  final Color? selectedItemColor;
  final bool expandable;
  final IconData expandIcon;
  final IconData shrinkIcon;
  const SideNavigationBar(
      {Key? key,
      required this.selectedIndex,
      required this.items,
      required this.onTap,
      this.color,
      this.selectedItemColor,
      this.expandable = true,
      this.expandIcon = Icons.arrow_right,
      this.shrinkIcon = Icons.arrow_left})
      : super(key: key);

  @override
  _SideNavigationBarState createState() => _SideNavigationBarState();

  static _SideNavigationBarState of(BuildContext context) =>
      context.findAncestorStateOfType<_SideNavigationBarState>()!;
}

class _SideNavigationBarState extends State<SideNavigationBar>
    with SingleTickerProviderStateMixin {
  final double minWidth = 400;
  final double maxWidth = 400;
  late double width;

  bool expanded = true;

  @override
  void initState() {
    super.initState();
    width = maxWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        border: Border(
          right: BorderSide(
            width: 1,
            color: MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.grey[700]!
                : Colors.white,
          ),
        ),
      ),
      child: AnimatedSize(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 350),
        vsync: this,
        child: SizedBox(
            width: width,
            height: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      children: _generateItems(expanded),
                    ),
                  ),
                ),
                widget.expandable
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: IconButton(
                          icon: Icon(
                              expanded ? widget.shrinkIcon : widget.expandIcon),
                          onPressed: () {
                            setState(() {
                              if (expanded) {
                                width = minWidth;
                              } else {
                                width = maxWidth;
                              }
                              expanded = !expanded;
                            });
                          },
                        ),
                      )
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(),
                      ),
              ],
            )),
      ),
    );
  }

  List<Widget> _generateItems(final bool _expanded) {
    List<Widget> _items = widget.items
        .asMap()
        .entries
        .map<SideNavigationBarItemTile>(
            (MapEntry<int, SideNavigationBarItem> entry) {
      return SideNavigationBarItemTile(
          icon: entry.value.icon,
          label: entry.value.label,
          onTap: widget.onTap,
          index: entry.key,
          expanded: expanded,
          color: _validateSelectedItemColor());
    }).toList();
    return _items;
  }

  Color _validateSelectedItemColor() {
    final Color? color;
    if (widget.selectedItemColor == null) {
      color = Colors.blue[200]!;
    } else {
      color = widget.selectedItemColor!;
    }
    return color;
  }
}

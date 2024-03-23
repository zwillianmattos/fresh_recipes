import 'package:flutter/material.dart';

import 'bottom_bar_item.dart';

class FreshBottomBar extends StatefulWidget {
  final List<FreshBottomBarItem> items;
  final void Function(int index) onIndexSelected;
  const FreshBottomBar({super.key, required this.items, required this.onIndexSelected});

  @override
  State<FreshBottomBar> createState() => _FreshBottomBarState();
}

class _FreshBottomBarState extends State<FreshBottomBar> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: List.from(widget.items.map(
        (item) => BottomNavigationBarItem(
          backgroundColor: const Color(0xffFDFFFD),
          icon: item.icon,
          label: item.label,
          activeIcon: item.activeIcon,
        ),
      )),
      iconSize: 20,
      selectedItemColor: Colors.black87,
      unselectedItemColor: Colors.black38,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: selected,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        widget.onIndexSelected(index);
        setState(() {
          selected = index;
        });
      },
    );
  }
}

class FreshIconBar extends StatelessWidget {
  final IconData icon;
  final int countBadge;

  const FreshIconBar({
    super.key,
    required this.icon,
    required this.countBadge,
  });

  @override
  Widget build(BuildContext context) {
    if (countBadge > 0) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon),
          Positioned(
            right: -5,
            top: -5,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 8,
              child: Text(
                '$countBadge',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          )
        ],
      );
    }

    return Icon(icon);
  }
}

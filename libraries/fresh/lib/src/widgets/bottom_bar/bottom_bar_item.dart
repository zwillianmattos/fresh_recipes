import 'package:flutter/material.dart';

class FreshBottomBarItem {
  final String label;
  final Widget icon;
  final Widget activeIcon;
  final int countBadge;

  FreshBottomBarItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    this.countBadge = 0,
  });
}

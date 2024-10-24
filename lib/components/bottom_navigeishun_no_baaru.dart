// bottom_navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pizza_app/screens/globals.dart';

class BottomNavigeishunNoBaaru extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigeishunNoBaaru({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: secondPrimary,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        _bottomIcon(icon: 'assets/svg/bottom_icons/quran.svg', label: 'Quran'),
        _bottomIcon(icon: 'assets/svg/bottom_icons/lomba.svg', label: 'lomba'),
        _bottomIcon(icon: 'assets/svg/bottom_icons/praying.svg', label: 'praying'),
        _bottomIcon(icon: 'assets/svg/bottom_icons/duaa.svg', label: 'duaa'),
        _bottomIcon(icon: 'assets/svg/bottom_icons/save.svg', label: 'praying'),
      ],
    );
  }

  BottomNavigationBarItem _bottomIcon({required String icon, required String label}) =>
      BottomNavigationBarItem(
          icon: SvgPicture.asset(icon, color: text),
          activeIcon: SvgPicture.asset(icon, color: primary),
          label: label);
}

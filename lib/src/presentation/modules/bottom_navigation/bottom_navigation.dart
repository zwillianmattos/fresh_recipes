import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fresh/fresh.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<BottomNavigation> {
  @override
  void initState() {
    changePage(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const RouterOutlet(),
      bottomNavigationBar: FreshBottomBar(
        items: [
          FreshBottomBarItem(
            label: 'Home',
            icon: const FaIcon(FontAwesomeIcons.house),
            activeIcon: const FaIcon(FontAwesomeIcons.house),
          ),
          FreshBottomBarItem(
            label: 'Search',
            icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
            activeIcon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
          ),
          FreshBottomBarItem(
            label: 'Favorite',
            icon: const FaIcon(FontAwesomeIcons.heart),
            activeIcon: const FaIcon(FontAwesomeIcons.solidHeart),
          ),
          FreshBottomBarItem(
            label: 'Profile',
            icon: const FaIcon(FontAwesomeIcons.user),
            activeIcon: const FaIcon(FontAwesomeIcons.solidUser),
          ),
        ],
        onIndexSelected: changePage,
      ),
    );
  }

  changePage(index) {
    if (index == 0) {
      Modular.to.navigate('/recipes/');
    } else if (index == 1) {
      Modular.to.navigate('/search');
    } else if (index == 2) {
      Modular.to.navigate('/recipes/favorites');
    } else if (index == 3) {
      Modular.to.navigate('/account/profile');
    }
  }
}

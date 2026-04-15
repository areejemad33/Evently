import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/features/home/tabs/favourite_tab/favourite_tab.dart';
import 'package:evently_app/features/home/tabs/home_tab/home_tab.dart';
import 'package:evently_app/features/home/tabs/profile/profile_tab.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [HomeTab(), FavouriteTab(), ProfileTab()];
  int currentIndex = 0;
  late AppLocalizations appLocalizations;
  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: _buildBottomNavBar,
    );
  }

  BottomNavigationBar get _buildBottomNavBar {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: _onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 0 ? Icons.home_filled : Icons.home_outlined,
          ),
          label: appLocalizations.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 1 ? Icons.favorite : Icons.favorite_border_outlined,
          ),
          label: appLocalizations.favourite,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 2 ? Icons.person : Icons.person_2_outlined,
          ),
          label: appLocalizations.profile,
        ),
      ],
    );
  }

  void _onTap(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }
}

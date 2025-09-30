import 'package:flutter/material.dart';
import 'package:toorunta_mobile/component/bottom_nav_bar.dart';
import 'package:toorunta_mobile/features/homepage/ui/home_page.dart';
import 'package:toorunta_mobile/features/map/ui/map.dart';
import 'package:toorunta_mobile/features/account/ui/account_page.dart';
import 'package:toorunta_mobile/features/listings/ui/listings_page.dart';
import 'package:toorunta_mobile/features/map/ui/mapbox.dart';

class MainScaffold extends StatefulWidget {
  final int currentIndex;
  final Widget child;

  const MainScaffold({
    Key? key,
    required this.currentIndex,
    required this.child,
  }) : super(key: key);

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  void _onNavigationTap(BuildContext context, int index) {
    if (index == widget.currentIndex) return;
    
    Widget page;
    switch (index) {
      case 0:
        page = const HomePage();
        break;
      case 1:
        page = const ListingsPage();
        break;
      case 2:
        page = const MapPage(isFromBottomNav: true);
        break;
      case 3:
        page = const AccountPage();
        break;
      default:
        page = const HomePage();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavBar(
        currentIndex: widget.currentIndex,
        onTap: (index) => _onNavigationTap(context, index),
      ),
    );
  }
} 
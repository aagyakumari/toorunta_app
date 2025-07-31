import 'package:flutter/material.dart';
import 'package:toorunta_mobile/component/main_scaffold.dart';
import 'package:toorunta_mobile/component/sidebar_menu.dart';
import 'package:toorunta_mobile/component/topnavbar.dart';
import 'package:toorunta_mobile/features/map/ui/map.dart';
import 'package:toorunta_mobile/features/product_search/ui/product_list_page.dart';
import 'dashboard_metrics.dart';
import 'dashboard_tabs.dart';
import 'recently_viewed.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isMenuOpen = false;
  String selectedMenu = 'overview';

  void _toggleMenu(bool open) {
    setState(() {
      _isMenuOpen = open;
    });
  }

  void _onMenuItemSelected(String menuKey) {
    setState(() {
      selectedMenu = menuKey;
      _isMenuOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: -1, // No item selected since this page is accessed via side menu
      child: Scaffold(
        backgroundColor: const Color(0xfff9f9f9),
        body: Stack(
          children: [
            AbsorbPointer(
              absorbing: _isMenuOpen,
              child: Column(
                children: [
                  TopNavBar(
                    onMenuTap: () => _toggleMenu(true),
                    onFilterTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProductListPage()),
                      );
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.add, color: Colors.white),
                            label: const Text(
                              "Create New Listing",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2D3363),
                              minimumSize: const Size(double.infinity, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const DashboardMetrics(),
                          const SizedBox(height: 16),
                          const DashboardTabs(),
                          const SizedBox(height: 16),
                          const RecentlyViewedSection(),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SideMenu(
              isOpen: _isMenuOpen,
              onClose: () => _toggleMenu(false),
              selectedMenu: selectedMenu,
              onSelectMenu: _onMenuItemSelected,
            ),
          ],
        ),
      ),
    );
  }
}

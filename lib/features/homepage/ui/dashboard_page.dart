import 'package:flutter/material.dart';
import 'package:toorunta_mobile/component/topnavbar.dart';
import 'package:toorunta_mobile/features/login/ui/login_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      body: Stack(
        children: [
          Column(
            children: [
              TopNavBar(
                onMenuTap: () {
                  setState(() {
                    _isMenuOpen = true;
                  });
                },
                onFilterTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductListPage()),
                  );
                },
                onAvatarTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapPage()),
                  );
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                          backgroundColor: const Color(0xff2e3c89),
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

          // Inline Menu Drawer
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: _isMenuOpen ? 0 : -250,
            top: 0,
            bottom: 0,
            child: Container(
              width: 250,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "toorunta",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.dashboard),
                    title: const Text("Overview"),
                    onTap: () {
                      setState(() {
                        _isMenuOpen = false;
                      });
                    },
                    selected: true,
                    selectedTileColor: const Color(0xff2e3c89),
                    selectedColor: Colors.white,
                  ),
                  ListTile(
                    leading: const Icon(Icons.home_work_outlined),
                    title: const Text("My Listings"),
                    onTap: () {
                      setState(() {
                        _isMenuOpen = false;
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.mail_outline),
                    title: const Text("Messages"),
                    onTap: () {
                      setState(() {
                        _isMenuOpen = false;
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: const Text("Profile"),
                    onTap: () {
                      setState(() {
                        _isMenuOpen = false;
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text("Logout"),
                    onTap: () {
                      setState(() {
                        _isMenuOpen = false;
                      });
                      Future.delayed(const Duration(milliseconds: 300), () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (route) => false,
                        );
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text("Settings"),
                    onTap: () {
                      setState(() {
                        _isMenuOpen = false;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          // Background Overlay
          if (_isMenuOpen)
            GestureDetector(
              onTap: () {
                setState(() {
                  _isMenuOpen = false;
                });
              },
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
        ],
      ),
    );
  }
}

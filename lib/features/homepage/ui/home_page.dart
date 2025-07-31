import 'package:flutter/material.dart';
import 'package:toorunta_mobile/component/main_scaffold.dart';
import 'package:toorunta_mobile/component/sidebar_menu.dart';
import 'package:toorunta_mobile/component/topnavbar.dart';
import 'package:toorunta_mobile/features/homepage/ui/category_list.dart';
import 'package:toorunta_mobile/features/homepage/ui/flash_deals_banner.dart';
import 'package:toorunta_mobile/features/homepage/ui/product_grid.dart';
import 'package:toorunta_mobile/features/homepage/ui/red_banner.dart';
import 'package:toorunta_mobile/features/homepage/ui/search_bar.dart';
import 'package:toorunta_mobile/features/map/ui/map.dart';
import 'package:toorunta_mobile/features/product_search/ui/product_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isMenuOpen = false;
  String selectedMenu = '';

  // Sample product data - replace with real data
  final List<Map<String, dynamic>> trendingProducts = [
    {'image': 'assets/images/product1.jpg', 'name': 'iPhone 14 Pro Max', 'price': '\$999'},
    {'image': 'assets/images/product2.jpg', 'name': 'MacBook Air M2', 'price': '\$1299'},
    {'image': 'assets/images/product3.jpg', 'name': 'iPad Pro 12.9"', 'price': '\$1099'},
  ];

  final List<Map<String, dynamic>> recommendedProducts = [
    {'image': 'assets/images/product4.jpg', 'name': 'AirPods Pro', 'price': '\$249'},
    {'image': 'assets/images/product5.jpg', 'name': 'Apple Watch Series 8', 'price': '\$399'},
    {'image': 'assets/images/product6.jpg', 'name': 'iMac 24"', 'price': '\$1299'},
    {'image': 'assets/images/product7.jpg', 'name': 'Mac mini M2', 'price': '\$599'},
    {'image': 'assets/images/product8.jpg', 'name': 'Magic Keyboard', 'price': '\$299'},
    {'image': 'assets/images/product9.jpg', 'name': 'Studio Display', 'price': '\$1599'},
  ];

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
      currentIndex: 0,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
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
                        MaterialPageRoute(builder: (context) => ProductListPage()),
                      );
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                SizedBox(height: 8),
                                CustomSearchBar(),
                                SizedBox(height: 8),
                                RedBanner(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          const CategoryList(),
                          const SizedBox(height: 24),
                          ProductGrid(
                            title: 'New and Trending',
                            products: trendingProducts,
                          ),
                          const SizedBox(height: 24),
                          const FlashDealsBanner(),
                          const SizedBox(height: 24),
                          ProductGrid(
                            title: 'You May Also Like',
                            products: recommendedProducts,
                          ),
                          const SizedBox(height: 24),
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

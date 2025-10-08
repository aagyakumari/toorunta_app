import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toorunta_mobile/component/main_scaffold.dart';
import 'package:toorunta_mobile/component/sidebar_menu.dart';
import 'package:toorunta_mobile/component/topnavbar.dart';
import 'package:toorunta_mobile/features/homepage/ui/category_list.dart';
import 'package:toorunta_mobile/features/homepage/ui/flash_deals_banner.dart';
import 'package:toorunta_mobile/features/homepage/ui/product_grid.dart';
import 'package:toorunta_mobile/features/homepage/ui/red_banner.dart';
import 'package:toorunta_mobile/features/homepage/ui/search_bar.dart';
import 'package:toorunta_mobile/features/product_search/ui/product_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isMenuOpen = false;
  String selectedMenu = '';

  final String baseUrl = 'https://staging.axioncode.co/api/v1';

  // 🔹 Fetch trending products
  Future<List<Map<String, dynamic>>> fetchTrendingProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products/trending'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final products = data['data']?['products'] ?? [];
      return List<Map<String, dynamic>>.from(products.map((product) => {
            'image': product['featured_image_url'] ?? product['thumbnail_url'],
            'name': product['name'],
            'price': product['price'],
          }));
    } else {
      throw Exception('Failed to load trending products');
    }
  }

  // 🔹 Fetch category products (for "You May Also Like" section)
  Future<List<Map<String, dynamic>>> fetchCategoryProducts(int categoryId) async {
    final response = await http.get(Uri.parse('$baseUrl/products/category/$categoryId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final products = data['data']?['products'] ?? [];
      return List<Map<String, dynamic>>.from(products.map((product) => {
            'image': product['featured_image_url'] ?? product['thumbnail_url'],
            'name': product['name'],
            'price': product['price'],
          }));
    } else {
      throw Exception('Failed to load products for category $categoryId');
    }
  }

  // 🔹 Fetch both categories (ID 12 and 18)
  Future<List<Map<String, dynamic>>> fetchRecommendedProducts() async {
    try {
      final category12 = await fetchCategoryProducts(12);
      final category84 = await fetchCategoryProducts(84);
      return [...category12, ...category84];
    } catch (e) {
      debugPrint('Error fetching recommended products: $e');
      return [];
    }
  }

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
                        MaterialPageRoute(
                          builder: (context) => const ProductListPage(categoryId: 0),
                        ),
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

                          // 🔹 Trending Products
                          FutureBuilder<List<Map<String, dynamic>>>(
                            future: fetchTrendingProducts(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return const Center(child: Text('Error loading trending products'));
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return const Center(child: Text('No trending products'));
                              }
                              return ProductGrid(
                                title: 'New and Trending',
                                products: snapshot.data!,
                              );
                            },
                          ),

                          const SizedBox(height: 24),
                          const FlashDealsBanner(),
                          const SizedBox(height: 24),

                          // 🔹 You May Also Like (dynamic categories)
                          FutureBuilder<List<Map<String, dynamic>>>(
                            future: fetchRecommendedProducts(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return const Center(child: Text('Error loading recommendations'));
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return const Center(child: Text('No recommended products'));
                              }
                              return ProductGrid(
                                title: 'You May Also Like',
                                products: snapshot.data!,
                              );
                            },
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Side Menu
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

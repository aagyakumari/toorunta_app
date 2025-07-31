import 'package:flutter/material.dart';
import 'package:toorunta_mobile/component/topnavbar.dart';
import 'package:toorunta_mobile/component/sidebar_menu.dart';
import 'package:toorunta_mobile/component/main_scaffold.dart';
import 'package:toorunta_mobile/features/map/ui/map.dart';
import 'package:toorunta_mobile/features/product_search/ui/product_card.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  bool _isMenuOpen = false;
  String selectedMenu = 'listings';

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
      currentIndex: -1,
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
                    onFilterTap: () {},
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "All Listings",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Showing 4 results", 
                                style: TextStyle(fontSize: 14)
                              ),
                              Row(
                                children: [
                                  Text("Sort by: Newest", 
                                    style: TextStyle(fontSize: 14)
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_drop_down),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 4,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: ProductCard(index: index),
                            ),
                          ),
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

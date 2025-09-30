import 'package:flutter/material.dart';
import 'package:toorunta_mobile/features/homepage/ui/flash_deals_banner.dart';
import 'package:toorunta_mobile/features/homepage/ui/product_grid.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  final List<Map<String, dynamic>> trendingProducts = const [
    {'image': 'assets/images/product1.jpg', 'name': 'iPhone 14 Pro Max', 'price': '\$999'},
    {'image': 'assets/images/product2.jpg', 'name': 'MacBook Air M2', 'price': '\$1299'},
    {'image': 'assets/images/product3.jpg', 'name': 'iPad Pro 12.9"', 'price': '\$1099'},
    {'image': 'assets/images/product4.jpg', 'name': 'AirPods Pro', 'price': '\$249'},
  ];

  final List<Map<String, dynamic>> recommendedProducts = const [
    {'image': 'assets/images/product5.jpg', 'name': 'Apple Watch Series 8', 'price': '\$399'},
    {'image': 'assets/images/product6.jpg', 'name': 'iMac 24"', 'price': '\$1299'},
    {'image': 'assets/images/product7.jpg', 'name': 'Mac mini M2', 'price': '\$599'},
    {'image': 'assets/images/product8.jpg', 'name': 'Magic Keyboard', 'price': '\$299'},
    {'image': 'assets/images/product9.jpg', 'name': 'Studio Display', 'price': '\$1599'},
    {'image': 'assets/images/product1.jpg', 'name': 'iPhone 14 Pro Max', 'price': '\$999'},
    {'image': 'assets/images/product2.jpg', 'name': 'MacBook Air M2', 'price': '\$1299'},
    {'image': 'assets/images/product3.jpg', 'name': 'iPad Pro 12.9"', 'price': '\$1099'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ProductGrid(
              title: 'New and Trending',
              products: trendingProducts,
            ),
          ),
          const SizedBox(height: 24),
          const FlashDealsBanner(),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ProductGrid(
              title: 'You May Also Like',
              products: recommendedProducts,
            ),
          ),
        ],
      ),
    );
  }
}

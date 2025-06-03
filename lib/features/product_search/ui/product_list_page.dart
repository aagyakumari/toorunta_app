import 'package:flutter/material.dart';
import 'package:toorunta_mobile/component/topnavbar.dart';
import 'package:toorunta_mobile/features/map/ui/map.dart';
import 'package:toorunta_mobile/features/product_search/ui/product_card.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar with actions
            TopNavBar(
              onMenuTap: () {
                // Handle menu tap
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Menu tapped")),
                );
              },
              onFilterTap: () {
                // Handle filter tap
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Filter tapped")),
                );
              },
              onAvatarTap: () {
                // Navigate to map page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapPage()),
                );
              },
            ),

            // Search and Filter Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.grey.shade200,
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.filter_list, color: Colors.black),
                    label: const Text("Filter", style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Filter button tapped")),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Results and Sort Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Showing 4 results", style: TextStyle(fontSize: 14)),
                  Row(
                    children: [
                      Text("Sort by: Newest", style: TextStyle(fontSize: 14)),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_drop_down),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Product List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 4,
                itemBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: ProductCard(),
                ),
              ),
            ),
          ],
        ),
      ),

      // Floating Map Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo.shade900,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          icon: const Icon(Icons.map),
          label: const Text("Map"),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MapPage()),
            );
          },
        ),
      ),
    );
  }
}

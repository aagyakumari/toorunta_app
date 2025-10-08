import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TrendingTabs extends StatefulWidget {
  const TrendingTabs({super.key});

  @override
  State<TrendingTabs> createState() => _TrendingTabsState();
}

class _TrendingTabsState extends State<TrendingTabs> {
  Future<List<dynamic>> fetchTrending() async {
    final response = await http.get(
      Uri.parse('https://staging.axioncode.co/api/v1/products/trending'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Extract products from data
      return data['data']?['products'] ?? [];
    } else {
      throw Exception('Failed to load trending products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchTrending(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading trending products'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No trending products'));
        }

        final products = snapshot.data!;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            products.length > 4 ? 4 : products.length,
            (index) {
              final product = products[index];
              final imageUrl = product['featured_image_url'] ?? product['thumbnail_url'];
              return Column(
                children: [
                  imageUrl != null
                      ? Image.network(
                          imageUrl,
                          width: 32,
                          height: 32,
                          errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported),
                        )
                      : Icon(Icons.fireplace_outlined, color: Colors.grey[600]),
                  const SizedBox(height: 4),
                  Text(
                    product['name'] ?? 'Label',
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

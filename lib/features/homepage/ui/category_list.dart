import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<dynamic> categories = [];
  bool isLoading = true;
  final String bearerToken = '12|oz0UBtmZSqTFwkEemhbaPUSviyvLexQbYYOasU6vd0f8f31d';
  final String apiUrl = 'http://localhost:8000/api/v1/product-categories/top-level';

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          categories = data['data'];
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  IconData getCategoryIcon(String name) {
    switch (name.toLowerCase()) {
      case 'electronics':
        return Icons.computer;
      case 'fashion':
        return Icons.checkroom;
      case 'health & beauty':
        return Icons.spa;
      case 'home & living':
        return Icons.home;
      case 'sports & outdoors':
        return Icons.sports_soccer;
      case 'automotive':
        return Icons.directions_car;
      case 'books & stationery':
        return Icons.book;
      case 'toys & games':
        return Icons.toys;
      case 'pet supplies':
        return Icons.pets;
      case 'groceries & essentials':
        return Icons.local_grocery_store;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            getCategoryIcon(category['name'] ?? ''),
                            color: const Color(0xFF2D3363),
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: Text(
                              category['name'] ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
    );
  }
}
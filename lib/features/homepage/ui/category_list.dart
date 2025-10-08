import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<dynamic> categories = [];
  bool isLoading = true;
  final String bearerToken = '12|oz0UBtmZSqTFwkEemhbaPUSviyvLexQbYYOasU6vd0f8f31d';
  final String apiUrl = 'https://staging.axioncode.co/api/v1/product-categories/top-level';

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

  // ✅ Updated to use SVG icons from assets
  Widget getCategoryIcon(String name, {double size = 30}) {
    String formattedName = name.trim().toLowerCase();
    String assetPath;

    switch (formattedName) {
      case 'electronics':
        assetPath = 'assets/category-icons/Electronics.svg';
        break;
      case 'fashion':
        assetPath = 'assets/category-icons/Fashion.svg';
        break;
      case 'health & beauty':
        assetPath = 'assets/category-icons/Health & Beauty.svg';
        break;
      case 'home & living':
        assetPath = 'assets/category-icons/Homeliving.svg';
        break;
      case 'sports & outdoors':
        assetPath = 'assets/category-icons/Sports & Outdoors.svg';
        break;
      case 'automotive':
        assetPath = 'assets/category-icons/Automotive.svg';
        break;
      case 'books & stationery':
        assetPath = 'assets/category-icons/Books & Stationery.svg';
        break;
      case 'toys & games':
        assetPath = 'assets/category-icons/Toys & Games.svg';
        break;
      case 'pet supplies':
        assetPath = 'assets/category-icons/Pet Supplies.svg';
        break;
      case 'groceries & essentials':
        assetPath = 'assets/category-icons/Groceries & Essentials.svg';
        break;
      default:
        assetPath = 'assets/category-icons/default.svg';
    }

    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
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
                          child: getCategoryIcon(category['name'] ?? ''),
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

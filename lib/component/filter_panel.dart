import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Category Models
class SubCategory {
  final int id;
  final String name;

  SubCategory({required this.id, required this.name});

  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      SubCategory(id: json['id'], name: json['name']);
}

class Category {
  final int id;
  final String name;
  final List<SubCategory> subcategories;

  Category({required this.id, required this.name, required this.subcategories});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
        subcategories: (json['subcategories'] as List)
            .map((e) => SubCategory.fromJson(e))
            .toList(),
      );
}

class FilterPanel extends StatefulWidget {
  const FilterPanel({super.key});

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  // State
  String selectedLocation = "Kathmandu";
  String selectedStatus = "New";
  String? selectedCategory;
  String? selectedSubCategory;
  String selectedDealType = "";
  double distance = 20;
  double price = 50000;

  // Category data
  List<Category> categories = [];
  List<SubCategory> subcategories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final url = Uri.parse('http://localhost:8000/api/v1/product-categories/top-level');
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final List<dynamic> data = jsonDecode(res.body)['data'];
        final fetchedCategories = data.map((e) => Category.fromJson(e)).toList();

        setState(() {
          categories = fetchedCategories;
          selectedCategory = categories.first.name;
          subcategories = categories.first.subcategories;
          selectedSubCategory = subcategories.isNotEmpty ? subcategories.first.name : null;
        });
      } else {
        debugPrint('Error fetching categories: ${res.statusCode}');
      }
    } catch (e) {
      debugPrint('Exception fetching categories: $e');
    }
  }

  void resetFilters() {
    setState(() {
      selectedLocation = "Kathmandu";
      selectedStatus = "New";
      selectedCategory = categories.isNotEmpty ? categories.first.name : null;
      subcategories = categories.isNotEmpty ? categories.first.subcategories : [];
      selectedSubCategory = subcategories.isNotEmpty ? subcategories.first.name : null;
      selectedDealType = "";
      distance = 20;
      price = 50000;
    });
  }

  Widget buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(label),
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfff9f9f9),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Filter", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                OutlinedButton(
                  onPressed: resetFilters,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    side: const BorderSide(color: Color(0xFFFFC107)),
                  ),
                  child: const Text("Reset all", style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Dropdowns
            buildDropdown(
              label: "Location",
              value: selectedLocation,
              items: ["Kathmandu", "Pokhara"],
              onChanged: (v) => setState(() => selectedLocation = v!),
            ),
            buildDropdown(
              label: "Status",
              value: selectedStatus,
              items: ["New", "Used"],
              onChanged: (v) => setState(() => selectedStatus = v!),
            ),
            if (categories.isNotEmpty)
              buildDropdown(
                label: "Categories",
                value: selectedCategory,
                items: categories.map((e) => e.name).toList(),
                onChanged: (v) {
                  final cat = categories.firstWhere((c) => c.name == v);
                  setState(() {
                    selectedCategory = v;
                    subcategories = cat.subcategories;
                    selectedSubCategory =
                        subcategories.isNotEmpty ? subcategories.first.name : null;
                  });
                },
              ),
            if (subcategories.isNotEmpty)
              buildDropdown(
                label: "Sub-Categories",
                value: selectedSubCategory,
                items: subcategories.map((e) => e.name).toList(),
                onChanged: (v) => setState(() => selectedSubCategory = v!),
              ),
            buildDropdown(
              label: "Select deal types",
              value: selectedDealType.isEmpty ? null : selectedDealType,
              items: ["Rent", "Sale"],
              onChanged: (v) => setState(() => selectedDealType = v!),
            ),
            const SizedBox(height: 16),

            // Distance slider
            const Text("Distance", style: TextStyle(fontWeight: FontWeight.w500)),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.orange,
                inactiveTrackColor: Colors.orange.withOpacity(0.3),
                thumbColor: Colors.orange,
                overlayColor: Colors.orange.withOpacity(0.2),
              ),
              child: Slider(
                value: distance,
                min: 0,
                max: 50,
                divisions: 50,
                label: "${distance.round()} km",
                onChanged: (v) => setState(() => distance = v),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text("0 km"), Text("50 km")],
            ),
            const SizedBox(height: 16),

            // Price slider
            const Text("Price Range", style: TextStyle(fontWeight: FontWeight.w500)),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.orange,
                inactiveTrackColor: Colors.orange.withOpacity(0.3),
                thumbColor: Colors.orange,
                overlayColor: Colors.orange.withOpacity(0.2),
              ),
              child: Slider(
                value: price,
                min: 0,
                max: 100000,
                divisions: 100,
                label: price.round().toString(),
                onChanged: (v) => setState(() => price = v),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text("0"), Text("100,000")],
            ),
          ],
        ),
      ),
    );
  }
}

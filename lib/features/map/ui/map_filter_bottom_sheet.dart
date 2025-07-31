import 'package:flutter/material.dart';

class MapFilterBottomSheet extends StatefulWidget {
  final Function(double distance, RangeValues priceRange) onApply;

  const MapFilterBottomSheet({super.key, required this.onApply});

  @override
  State<MapFilterBottomSheet> createState() => _MapFilterBottomSheetState();
}

class _MapFilterBottomSheetState extends State<MapFilterBottomSheet> {
  double distance = 20;
  RangeValues priceRange = const RangeValues(0, 50000);
  String category = "Real Estate";
  String dealType = "";
  String datePosted = "Any Time";
  String location = "Kathmandu";

  void _resetFilters() {
    setState(() {
      distance = 20;
      priceRange = const RangeValues(0, 50000);
      category = "Real Estate";
      dealType = "";
      datePosted = "Any Time";
      location = "Kathmandu";
    });
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Filter",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              OutlinedButton(
                onPressed: _resetFilters,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.amber[700],
                  side: BorderSide(color: Colors.amber[700]!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text("Reset all"),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Date Posted
          const Text("Date Posted", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: datePosted,
            decoration: _dropdownDecoration(),
            items: ["Any Time", "Last 24 Hours", "Last 15 Days", "Last 30 Days"]
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => setState(() => datePosted = val!),
          ),
          const SizedBox(height: 20),

          // Location
          const Text("Location", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: location,
            decoration: _dropdownDecoration().copyWith(
              fillColor: Colors.amber[700],
            ),
            dropdownColor: Colors.amber[700],
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            iconEnabledColor: Colors.white,
            items: ["Kathmandu", "Lalitpur", "Bhaktapur"]
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => setState(() => location = val!),
          ),
          const SizedBox(height: 20),

          // Categories
          const Text("Categories", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: category,
            decoration: _dropdownDecoration(),
            items: ["Real Estate", "Car", "Bike", "Others"]
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => setState(() => category = val!),
          ),
          const SizedBox(height: 20),

          // Deal Types
          const Text("Deal Types", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: dealType.isEmpty ? null : dealType,
            decoration: _dropdownDecoration(),
            hint: const Text("Select deal types"),
            items: ["Rent", "Buy", "Lease"]
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => setState(() => dealType = val!),
          ),
          const SizedBox(height: 20),

          // Distance
          const Text("Distance", style: TextStyle(fontWeight: FontWeight.bold)),
          Slider(
            value: distance,
            min: 0,
            max: 50,
            divisions: 50,
            activeColor: Colors.red,
            label: "${distance.round()} km",
            onChanged: (val) => setState(() => distance = val),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Text("0 km"), Text("20 km"), Text("50 km")],
          ),
          const SizedBox(height: 20),

          // Price Range
          const Text("Price Range", style: TextStyle(fontWeight: FontWeight.bold)),
          RangeSlider(
            values: priceRange,
            min: 0,
            max: 100000,
            divisions: 100,
            activeColor: Colors.red,
            labels: RangeLabels(
              "${priceRange.start.round()}",
              "${priceRange.end.round()}",
            ),
            onChanged: (val) => setState(() => priceRange = val),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Text("0"), Text("50,000"), Text("1,00,000")],
          ),

          const SizedBox(height: 24),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.onApply(distance, priceRange);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text("Apply"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

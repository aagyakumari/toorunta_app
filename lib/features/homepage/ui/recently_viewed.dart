import 'package:flutter/material.dart';

class RecentlyViewedSection extends StatelessWidget {
  const RecentlyViewedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Recently Viewed", style: TextStyle(fontWeight: FontWeight.bold)),
                Icon(Icons.expand_more),
              ],
            ),
            SizedBox(height: 16),
            RecentlyViewedItem(
              initials: "IP",
              title: "iPhone 14 Pro Max",
              price: "\$1,000 • Like New",
              seller: "TechOutlet",
              rating: "4.8",
            ),
            SizedBox(height: 12),
            RecentlyViewedItem(
              initials: "MB",
              title: "MacBook Air M2",
              price: "\$999 • Excellent",
              seller: "AppleStore",
              rating: "4.9",
            ),
          ],
        ),
      ),
    );
  }
}

class RecentlyViewedItem extends StatelessWidget {
  final String initials, title, price, seller, rating;

  const RecentlyViewedItem({
    super.key,
    required this.initials,
    required this.title,
    required this.price,
    required this.seller,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(child: Text(initials)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(price, style: const TextStyle(fontSize: 12)),
              Text("by $seller • $rating", style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("View Details"),
        )
      ],
    );
  }
}

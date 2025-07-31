
import 'package:flutter/material.dart';

class TrendingTabs extends StatelessWidget {
  const TrendingTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(4, (index) {
        return Column(
          children: [
            Icon(Icons.fireplace_outlined, color: Colors.grey[600]),
            const SizedBox(height: 4),
            const Text('Label', style: TextStyle(fontSize: 12)),
          ],
        );
      }),
    );
  }
}

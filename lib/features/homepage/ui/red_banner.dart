import 'package:flutter/material.dart';

class RedBanner extends StatelessWidget {
  const RedBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: AssetImage('assets/images/banner.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

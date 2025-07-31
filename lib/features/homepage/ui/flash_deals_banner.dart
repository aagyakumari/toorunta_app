import 'package:flutter/material.dart';

class FlashDealsBanner extends StatelessWidget {
  const FlashDealsBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.15, // 15% of screen height
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2D3363), Color(0xFF2D3363)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              bottom: -20,
              child: Image.asset(
                'assets/images/gift_boxes.png',
                height: screenHeight * 0.12, // Responsive image height
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: screenHeight * 0.02, // 2% of screen height
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flash Deals',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Save up to 50%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
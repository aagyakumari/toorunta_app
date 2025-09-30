import 'package:flutter/material.dart';
import 'package:toorunta_mobile/features/login/ui/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shapeAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<Offset> _moveAnimation;
  
  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // Rotation animation (0° to 45°) - happens from 0% to 20%
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 45,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.2, curve: Curves.easeInOut),
    ));

    // Scale animation during rotation - happens from 0% to 20%
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.2, curve: Curves.easeInOut),
    ));

    // Shape morph animation (square to circle) - happens from 20% to 40%
    _shapeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.4, curve: Curves.easeInOut),
    ));

    // Logo opacity animation - happens from 40% to 60%
    _logoOpacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 0.6, curve: Curves.easeIn),
    ));

    // Move circle to side animation - happens in last 40%
    _moveAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 1.0, curve: Curves.easeInOut),
    ));

    // Start animation
    _controller.forward().then((_) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final logoHeight = screenWidth * 0.3;
    final initialSize = logoHeight * 0.8;
    final navyBlue = const Color(0xFF2D3363);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Main logo (to-runta.png)
            FadeTransition(
              opacity: _logoOpacityAnimation,
              child: SizedBox(
                width: screenWidth * 0.8,
                child: Image.asset(
                  'assets/images/to-runta.png',
                  height: logoHeight,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Animated circle that becomes o.png
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final finalSize = logoHeight * 0.7;
                final shrinkFactor = _controller.value > 0.4 ? 
                    Tween<double>(begin: 1.0, end: finalSize / (initialSize * 2.0))
                        .transform((_controller.value - 0.4) * 2.5) : 1.0;

                // Only move after morphing is complete
                final moveX = _moveAnimation.value.dx * (screenWidth * 0.15);

                return Transform.translate(
                  offset: Offset(moveX, 0),
                  child: Transform.rotate(
                    angle: _rotationAnimation.value * 3.14159 / 180,
                    child: Transform.scale(
                      scale: _scaleAnimation.value * shrinkFactor,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Animated circle
                          Opacity(
                            opacity: _controller.value < 0.4 ? 1.0 : 
                                    (1.0 - ((_controller.value - 0.4) * 2.5)).clamp(0.0, 1.0),
                            child: Container(
                              width: initialSize,
                              height: initialSize,
                              decoration: BoxDecoration(
                                color: navyBlue,
                                borderRadius: BorderRadius.circular(
                                  initialSize * 0.2 +
                                  (initialSize * 0.8 * _shapeAnimation.value),
                                ),
                              ),
                            ),
                          ),
                          // o.png with fade in
                          Opacity(
                            opacity: _controller.value < 0.4 ? 0.0 :
                                    ((_controller.value - 0.4) * 2.5).clamp(0.0, 1.0),
                            child: Image.asset(
                              'assets/images/o.png',
                              width: initialSize,
                              height: initialSize,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
} 
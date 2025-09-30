import 'package:flutter/material.dart';
import 'package:toorunta_mobile/features/login/ui/login_screen.dart';

class InlineMenuDrawer extends StatefulWidget {
  final bool isOpen;
  final VoidCallback onClose;

  const InlineMenuDrawer({
    super.key,
    required this.isOpen,
    required this.onClose,
  });

  @override
  State<InlineMenuDrawer> createState() => _InlineMenuDrawerState();
}

class _InlineMenuDrawerState extends State<InlineMenuDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.isOpen) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant InlineMenuDrawer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double menuWidth = size.width * 0.75;

    return Stack(
      children: [
        // Dimmed background overlay
        if (widget.isOpen)
          GestureDetector(
            onTap: widget.onClose,
            child: Container(
              color: Colors.black.withOpacity(0.3),
              width: size.width,
              height: size.height,
            ),
          ),

        // Slide-in menu
        SlideTransition(
          position: _offsetAnimation,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: menuWidth,
              height: size.height,
              color: Colors.white,
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'toorunta',
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                        color: const Color(0xFFD84040),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildMenuItem(Icons.dashboard, "Overview"),
                            _buildMenuItem(Icons.home_work_outlined, "My Listings"),
                            _buildMenuItem(Icons.mail_outline, "Messages"),
                            _buildMenuItem(Icons.person_outline, "Profile"),
                            _buildMenuItem(Icons.settings_outlined, "Settings"),
                            _buildDivider(),
                            _buildMenuItem(Icons.logout, "Logout", isLogout: true),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String label, {bool isLogout = false}) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        if (isLogout) {
          _showLogoutDialog(context);
        } else {
          widget.onClose();
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: size.width * 0.06),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: size.width * 0.045,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              icon,
              color: const Color(0xFFD84040),
              size: size.width * 0.06,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: size.width * 0.6,
      height: 1,
      color: Colors.grey.shade300,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final size = MediaQuery.of(context).size;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Are you sure you want to log out?',
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                          (route) => false,
                        );
                      },
                      child: Text(
                        'Log out',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

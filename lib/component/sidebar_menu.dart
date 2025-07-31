import 'package:flutter/material.dart';
import 'package:toorunta_mobile/features/login/ui/login_screen.dart';
import 'package:toorunta_mobile/features/dashboard/ui/dashboard_page.dart';
import 'package:toorunta_mobile/features/listings/ui/listings_page.dart';

class SideMenu extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onClose;
  final String selectedMenu;
  final Function(String)? onSelectMenu;

  const SideMenu({
    super.key,
    required this.isOpen,
    required this.onClose,
    required this.selectedMenu,
    this.onSelectMenu,
  });

  @override
  Widget build(BuildContext context) {
    final currentMenu = selectedMenu.isEmpty ? '' : selectedMenu;

    return Stack(
      children: [
        // Semi-transparent overlay
        if (isOpen)
          GestureDetector(
            onTap: onClose,
            child: Container(
              color: Colors.black.withOpacity(0.4),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        
        // Side menu
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          left: isOpen ? 0 : -MediaQuery.of(context).size.width * 0.7,
          top: 0,
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "toorunta",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD84040),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildMenuItem(
                  context: context,
                  icon: Icons.dashboard,
                  label: 'Overview',
                  menuKey: 'overview',
                  currentMenu: currentMenu,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const DashboardPage()),
                    );
                    onClose();
                    onSelectMenu?.call('overview');
                  },
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.home_work_outlined,
                  label: 'My Listings',
                  menuKey: 'listings',
                  currentMenu: currentMenu,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const ListingsPage()),
                    );
                    onClose();
                    onSelectMenu?.call('listings');
                  },
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.mail_outline,
                  label: 'Messages',
                  menuKey: 'messages',
                  currentMenu: currentMenu,
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.person_outline,
                  label: 'Profile',
                  menuKey: 'profile',
                  currentMenu: currentMenu,
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  menuKey: 'settings',
                  currentMenu: currentMenu,
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.logout,
                  label: 'Logout',
                  menuKey: 'logout',
                  currentMenu: currentMenu,
                  onTap: () async {
                    final shouldLogout = await showLogoutDialog(context);
                    if (shouldLogout == true) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                      onClose();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String menuKey,
    required String currentMenu,
    VoidCallback? onTap,
  }) {
    final isSelected = currentMenu == menuKey;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFD84040).withOpacity(0.1) : null,
            border: Border(
              left: BorderSide(
                color: isSelected ? const Color(0xFFD84040) : Colors.transparent,
                width: 4,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? const Color(0xFFD84040) : Colors.grey[700],
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? const Color(0xFFD84040) : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool?> showLogoutDialog(BuildContext context) {
  final size = MediaQuery.of(context).size;

  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
                      Navigator.pop(context, false); // return false
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
                      Navigator.pop(context, true); // return true
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

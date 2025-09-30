import 'package:flutter/material.dart';
import 'package:toorunta_mobile/component/main_scaffold.dart';
import 'package:toorunta_mobile/component/sidebar_menu.dart';
import 'package:toorunta_mobile/component/topnavbar.dart';
import 'package:toorunta_mobile/features/map/ui/map.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _isMenuOpen = false;
  String selectedMenu = 'profile';

  void _toggleMenu(bool open) {
    setState(() {
      _isMenuOpen = open;
    });
  }

  void _onMenuItemSelected(String menuKey) {
    setState(() {
      selectedMenu = menuKey;
      _isMenuOpen = false;
    });
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Color(0xFF2D3363),
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 16),
          const Text(
            'John Doe',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'john.doe@example.com',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF2D3363),
              side: const BorderSide(color: Color(0xFF2D3363)),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF2D3363)),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        body: Stack(
          children: [
            AbsorbPointer(
              absorbing: _isMenuOpen,
              child: Column(
                children: [
                  TopNavBar(
                    onMenuTap: () => _toggleMenu(true),
                    onFilterTap: () {},
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildProfileSection(),
                          const SizedBox(height: 24),
                          _buildMenuItem(
                            icon: Icons.home_work_outlined,
                            title: 'My Listings',
                            subtitle: '4 active listings',
                            onTap: () {},
                          ),
                          _buildMenuItem(
                            icon: Icons.favorite_outline,
                            title: 'Favorites',
                            subtitle: '12 saved items',
                            onTap: () {},
                          ),
                          _buildMenuItem(
                            icon: Icons.notifications_outlined,
                            title: 'Notifications',
                            subtitle: 'Set your notification preferences',
                            onTap: () {},
                          ),
                          _buildMenuItem(
                            icon: Icons.security_outlined,
                            title: 'Privacy & Security',
                            subtitle: 'Manage your account security',
                            onTap: () {},
                          ),
                          _buildMenuItem(
                            icon: Icons.help_outline,
                            title: 'Help & Support',
                            subtitle: 'Get help or contact us',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SideMenu(
              isOpen: _isMenuOpen,
              onClose: () => _toggleMenu(false),
              selectedMenu: selectedMenu,
              onSelectMenu: _onMenuItemSelected,
            ),
          ],
        ),
      ),
    );
  }
} 
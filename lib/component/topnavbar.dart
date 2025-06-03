import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuTap;
  final VoidCallback onFilterTap;
  final VoidCallback onAvatarTap;

  const TopNavBar({
    super.key,
    required this.onMenuTap,
    required this.onFilterTap,
    required this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 360;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 8 : 16),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: kToolbarHeight,
          child: Row(
            children: [
              // Menu Icon
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.black, size: 24),
                onPressed: onMenuTap,
              ),

              // Text Logo (Centered)
              Expanded(
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'too',
                          style: TextStyle(
                            color: Colors.indigo,
                            fontSize: isSmall ? 18 : 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'runta',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: isSmall ? 18 : 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Right Actions
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_none,
                        color: Colors.black, size: 22),
                    onPressed: () {},
                    tooltip: 'Notifications',
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list,
                        color: Colors.black, size: 22),
                    onPressed: onFilterTap,
                    tooltip: 'Filter',
                  ),
                  GestureDetector(
                    onTap: onAvatarTap,
                    child: const CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.indigo,
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

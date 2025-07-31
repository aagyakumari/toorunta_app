import 'package:flutter/material.dart';
import 'package:toorunta_mobile/features/messages/ui/messages_page.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuTap;
  final VoidCallback onFilterTap;
  final String? title;
  final bool showMessageIcon;

  const TopNavBar({
    Key? key,
    required this.onMenuTap,
    required this.onFilterTap,
    this.title,
    this.showMessageIcon = true,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.04; // 4% of screen width
    final iconSize = (screenWidth * 0.06).clamp(24.0, 32.0); // 6% of width, clamped between 24-32
    final logoHeight = (screenWidth * 0.02).clamp(32.0, 40.0); // 8% of width, clamped between 32-40
    final titleSize = (screenWidth * 0.05).clamp(18.0, 24.0); // 5% of width, clamped between 18-24

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: onMenuTap,
              icon: const Icon(Icons.menu),
              iconSize: iconSize,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(
                minWidth: iconSize,
                minHeight: iconSize,
              ),
              color: const Color(0xFF2D3363),
            ),
            if (title != null)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Text(
                    title!,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2D3363),
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            else
              Image.asset(
                'assets/images/toorunta_logo.png',
                height: logoHeight,
              ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: onFilterTap,
                  icon: const Icon(Icons.filter_list),
                  iconSize: iconSize,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(
                    minWidth: iconSize,
                    minHeight: iconSize,
                  ),
                  color: const Color(0xFF2D3363),
                ),
                if (showMessageIcon)
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MessagesPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.message_outlined),
                    iconSize: iconSize,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                      minWidth: iconSize,
                      minHeight: iconSize,
                    ),
                    color: const Color(0xFF2D3363),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

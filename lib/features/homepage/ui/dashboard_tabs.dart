import 'package:flutter/material.dart';

class DashboardTabs extends StatefulWidget {
  const DashboardTabs({super.key});

  @override
  State<DashboardTabs> createState() => _DashboardTabsState();
}

class _DashboardTabsState extends State<DashboardTabs> {
  int _tabIndex = 0;

  final tabs = ["Recent Activity", "My Listings", "Messages"];

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Row(
            children: List.generate(tabs.length, (index) {
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _tabIndex = index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _tabIndex == index ? const Color(0xff2e3c89) : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                          color: _tabIndex == index ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(12),
            child: _tabIndex == 0
                ? const ActivityFeed()
                : Center(child: Text("No content for '${tabs[_tabIndex]}'")),
          ),
        ],
      ),
    );
  }
}

class ActivityFeed extends StatelessWidget {
  const ActivityFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ActivityItem(
          icon: Icons.check_circle,
          title: "Listing Approved",
          message: "Your iPhone 13 Pro listing has been approved and is now live",
          time: "2 hours ago",
        ),
        SizedBox(height: 8),
        ActivityItem(
          icon: Icons.mark_email_unread,
          iconColor: Colors.red,
          title: "New Message",
          message: "Sarah M. is interested in your MacBook Pro",
          time: "4 hours ago",
        ),
        SizedBox(height: 8),
        ActivityItem(
          icon: Icons.sell,
          title: "Sale Completed",
          message: "Your iPad Air has been sold to Mike R.",
          time: "1 day ago",
        ),
      ],
    );
  }
}

class ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title, message, time;
  final Color iconColor;

  const ActivityItem({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.time,
    this.iconColor = const Color(0xff2e3c89),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(message),
                const SizedBox(height: 4),
                Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

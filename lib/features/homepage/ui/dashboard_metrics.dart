import 'package:flutter/material.dart';

class DashboardMetrics extends StatelessWidget {
  const DashboardMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        MetricCard(
          icon: Icons.list_alt,
          title: 'ACTIVE LISTINGS',
          value: '12',
          subtitle: '+2 from last week',
        ),
        SizedBox(height: 12),
        MetricCard(
          icon: Icons.mail_outline,
          title: 'UNREAD MESSAGES',
          value: '5',
          subtitle: '3 new today',
          iconColor: Colors.red,
        ),
        SizedBox(height: 12),
        MetricCard(
          icon: Icons.star_border,
          title: 'SELLER RATING',
          value: '4.8',
          subtitle: 'Based on 47 reviews',
          iconColor: Colors.amber,
        ),
      ],
    );
  }
}

class MetricCard extends StatelessWidget {
  final IconData icon;
  final String title, value, subtitle;
  final Color iconColor;

  const MetricCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    this.iconColor = const Color(0xff2e3c89),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 28, color: iconColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

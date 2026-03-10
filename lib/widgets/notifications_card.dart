import 'package:flutter/material.dart';
import '../models/notification_setting.dart';
import 'notification_tile.dart';

class NotificationsCard extends StatelessWidget {
  final List<NotificationSetting> settings;
  final Function(int, bool) onToggle;

  const NotificationsCard({
    super.key,
    required this.settings,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: List.generate(settings.length, (index) {
          final item = settings[index];
          return NotificationTile(
            title: item.title,
            subtitle: item.subtitle,
            value: item.isEnabled,
            onChanged: (val) => onToggle(index, val),
            showDivider: index < settings.length - 1,
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'data/notification_data.dart';
import '../models/notification_setting.dart';
import '../widgets/notifications_app_bar.dart';
import '../widgets/notifications_card.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<NotificationSetting> _settings;

  @override
  void initState() {
    super.initState();
    // Deep copy so defaults are not mutated
    _settings = defaultNotificationSettings
        .map((e) => NotificationSetting(
              title: e.title,
              subtitle: e.subtitle,
              isEnabled: e.isEnabled,
            ))
        .toList();
  }

  void _handleToggle(int index, bool value) {
    setState(() {
      _settings[index].isEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7F4),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const NotificationsAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: NotificationsCard(
                  settings: _settings,
                  onToggle: _handleToggle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

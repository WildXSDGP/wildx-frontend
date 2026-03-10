import '../models/notification_setting.dart';

List<NotificationSetting> defaultNotificationSettings = [
  NotificationSetting(
    title: 'New Sightings',
    subtitle: 'Get notified about wildlife sightings\nin saved parks',
    isEnabled: true,
  ),
  NotificationSetting(
    title: 'Park Alerts',
    subtitle: 'Updates about park closures and\nconditions',
    isEnabled: true,
  ),
  NotificationSetting(
    title: 'Badges & Achievements',
    subtitle: 'Celebrate your milestones',
    isEnabled: true,
  ),
  NotificationSetting(
    title: 'Community Updates',
    subtitle: 'News from other wildlife explorers',
    isEnabled: false,
  ),
  NotificationSetting(
    title: 'Emergency Alerts',
    subtitle: 'Critical safety notifications',
    isEnabled: true,
  ),
];

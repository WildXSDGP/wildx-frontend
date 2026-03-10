import 'package:flutter/material.dart';
import '../models/about_key_feature_item.dart';
import '../models/notification_setting.dart';

const String appVersion = 'Version 1.0.0';
const String appTagline = 'Wildlife Explorer';

const String missionText =
    'WildX is dedicated to promoting wildlife conservation and sustainable '
    'tourism in Sri Lanka. We empower visitors and locals to explore, discover, '
    'and protect our precious wildlife heritage.';

const String conservationPartnerTitle = 'Conservation Partner';
const String conservationPartnerSubtitle =
    'In partnership with the Department of Wildlife Conservation, Sri Lanka';
const String conservationPartnerBody =
    'A portion of app proceeds goes directly to wildlife conservation efforts '
    'and anti-poaching initiatives across Sri Lankan national parks.';

const String contactEmail = 'support@wildx.com';
const String contactWebsite = 'www.wildx.com';
const String contactEmergency = '119 (Wildlife Hotline)';

const String madeWithLoveText =
    "Dedicated to preserving Sri Lanka's magnificent wildlife for future "
    'generations. Together, we can make a difference.';

const List<KeyFeatureItem> keyFeatures = [
  KeyFeatureItem(
    title: 'Real-time Wildlife Tracking',
    subtitle: 'Report and view animal sightings across all parks',
    icon: Icons.location_on,
    iconColor: Color(0xFF2196F3),
    iconBgColor: Color(0xFFE3F2FD),
  ),
  KeyFeatureItem(
    title: 'Emergency SOS System',
    subtitle: 'Quick access to wildlife officers and emergency services',
    icon: Icons.warning_amber_rounded,
    iconColor: Color(0xFFFF9800),
    iconBgColor: Color(0xFFFFF3E0),
  ),
  KeyFeatureItem(
    title: 'Community Driven',
    subtitle: 'Connect with fellow wildlife enthusiasts and rangers',
    icon: Icons.people,
    iconColor: Color(0xFF9C27B0),
    iconBgColor: Color(0xFFF3E5F5),
  ),
  KeyFeatureItem(
    title: 'Offline Functionality',
    subtitle: 'Access maps and guides even without internet',
    icon: Icons.wifi_off,
    iconColor: Color(0xFF4CAF50),
    iconBgColor: Color(0xFFE8F5E9),
  ),
];

// notification settings are kept here so they are available with other
// shared constants.  The list is also exported by notification_data.dart
// for easier import elsewhere.

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

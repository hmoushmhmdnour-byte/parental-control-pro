class AppConstants {
  // App Info
  static const String appName = 'Parental Control Pro';
  static const String appVersion = '1.0.0';
  static const String packageName = 'com.kidguard.parent';

  // Firebase
  static const String projectId = 'parental-control-pro';

  // Database Paths
  static const String pathParents = 'parents';
  static const String pathChildren = 'children';
  static const String pathCommands = 'commands';
  static const String pathNotifications = 'notifications';
  static const String pathLocation = 'location';
  static const String pathApps = 'apps';
  static const String pathScreenTime = 'screenTime';

  // Time Constants
  static const int locationUpdateInterval = 30000; // 30 seconds
  static const int appUsageCheckInterval = 60000; // 1 minute
  static const int notificationCheckInterval = 5000; // 5 seconds

  // Limits
  static const int maxScreenTimeHours = 8;
  static const int minScreenTimeMinutes = 5;
  static const int maxNotificationHistory = 100;
  static const int maxAppHistoryCount = 50;

  // Cache Duration
  static const int cacheDurationMinutes = 30;

  // Default Values
  static const String defaultLocale = 'en_US';
  static const double defaultMapZoom = 15.0;
  static const double defaultLocationAccuracy = 20.0; // meters
}

class AppUsageModel {
  final String packageName;
  final String appName;
  final String? appIcon;
  final int usageMinutes;
  final DateTime lastUsed;
  final bool isBlocked;
  final int launchCount;

  AppUsageModel({
    required this.packageName,
    required this.appName,
    this.appIcon,
    required this.usageMinutes,
    required this.lastUsed,
    this.isBlocked = false,
    this.launchCount = 0,
  });

  factory AppUsageModel.fromJson(Map<String, dynamic> json) {
    return AppUsageModel(
      packageName: json['packageName'] ?? '',
      appName: json['appName'] ?? '',
      appIcon: json['appIcon'],
      usageMinutes: json['usageMinutes'] ?? 0,
      lastUsed: DateTime.parse(json['lastUsed'] ?? DateTime.now().toString()),
      isBlocked: json['isBlocked'] ?? false,
      launchCount: json['launchCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'packageName': packageName,
      'appName': appName,
      'appIcon': appIcon,
      'usageMinutes': usageMinutes,
      'lastUsed': lastUsed.toIso8601String(),
      'isBlocked': isBlocked,
      'launchCount': launchCount,
    };
  }
}

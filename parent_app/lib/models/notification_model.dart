class NotificationModel {
  final String id;
  final String packageName;
  final String appName;
  final String? appIcon;
  final String title;
  final String? message;
  final DateTime timestamp;
  final bool isRead;
  final String? groupKey;

  NotificationModel({
    required this.id,
    required this.packageName,
    required this.appName,
    this.appIcon,
    required this.title,
    this.message,
    required this.timestamp,
    this.isRead = false,
    this.groupKey,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      packageName: json['packageName'] ?? '',
      appName: json['appName'] ?? '',
      appIcon: json['appIcon'],
      title: json['title'] ?? '',
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toString()),
      isRead: json['isRead'] ?? false,
      groupKey: json['groupKey'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'packageName': packageName,
      'appName': appName,
      'appIcon': appIcon,
      'title': title,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'groupKey': groupKey,
    };
  }
}

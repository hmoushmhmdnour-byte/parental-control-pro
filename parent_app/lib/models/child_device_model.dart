class ChildDeviceModel {
  final String deviceId;
  final String parentId;
  final String childName;
  final String? childAge;
  final String deviceName;
  final String osVersion;
  final String appVersion;
  final DateTime linkedAt;
  final DateTime lastSeen;
  final bool isActive;
  final bool isLocked;
  final Map<String, dynamic> settings;

  ChildDeviceModel({
    required this.deviceId,
    required this.parentId,
    required this.childName,
    this.childAge,
    required this.deviceName,
    required this.osVersion,
    required this.appVersion,
    required this.linkedAt,
    required this.lastSeen,
    this.isActive = true,
    this.isLocked = false,
    Map<String, dynamic>? settings,
  }) : settings = settings ?? {};

  factory ChildDeviceModel.fromJson(Map<String, dynamic> json) {
    return ChildDeviceModel(
      deviceId: json['deviceId'] ?? '',
      parentId: json['parentId'] ?? '',
      childName: json['childName'] ?? '',
      childAge: json['childAge'],
      deviceName: json['deviceName'] ?? '',
      osVersion: json['osVersion'] ?? '',
      appVersion: json['appVersion'] ?? '',
      linkedAt: DateTime.parse(json['linkedAt'] ?? DateTime.now().toString()),
      lastSeen: DateTime.parse(json['lastSeen'] ?? DateTime.now().toString()),
      isActive: json['isActive'] ?? true,
      isLocked: json['isLocked'] ?? false,
      settings: json['settings'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'parentId': parentId,
      'childName': childName,
      'childAge': childAge,
      'deviceName': deviceName,
      'osVersion': osVersion,
      'appVersion': appVersion,
      'linkedAt': linkedAt.toIso8601String(),
      'lastSeen': lastSeen.toIso8601String(),
      'isActive': isActive,
      'isLocked': isLocked,
      'settings': settings,
    };
  }
}

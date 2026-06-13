import 'package:firebase_database/firebase_database.dart';
import '../models/notification_model.dart';
import '../utils/logger.dart';

class NotificationService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Stream<List<NotificationModel>> getChildNotificationsStream(String childDeviceId) {
    try {
      AppLogger.info('Getting notifications stream for: $childDeviceId');
      return _database.ref('children/$childDeviceId/notifications')
          .limitToLast(100)
          .onValue
          .map((event) {
        if (event.snapshot.value == null) {
          return [];
        }
        final Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
        return data.values.map((e) => NotificationModel.fromJson(e as Map<String, dynamic>)).toList().reversed.toList();
      });
    } catch (e) {
      AppLogger.error('Error getting notifications stream', e);
      rethrow;
    }
  }

  Future<List<NotificationModel>> getChildNotifications(String childDeviceId, {int limit = 100}) async {
    try {
      AppLogger.info('Fetching notifications for: $childDeviceId');
      final snapshot = await _database.ref('children/$childDeviceId/notifications')
          .limitToLast(limit)
          .get();
      
      if (snapshot.value == null) {
        return [];
      }
      
      final Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
      final notifications = data.values
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList()
          .reversed
          .toList();
      
      return notifications;
    } catch (e) {
      AppLogger.error('Error fetching notifications', e);
      rethrow;
    }
  }

  Future<void> markNotificationAsRead(String childDeviceId, String notificationId) async {
    try {
      AppLogger.info('Marking notification as read: $notificationId');
      await _database.ref('children/$childDeviceId/notifications/$notificationId/isRead').set(true);
    } catch (e) {
      AppLogger.error('Error marking notification as read', e);
      rethrow;
    }
  }

  Future<void> clearNotifications(String childDeviceId) async {
    try {
      AppLogger.info('Clearing notifications for: $childDeviceId');
      await _database.ref('children/$childDeviceId/notifications').remove();
    } catch (e) {
      AppLogger.error('Error clearing notifications', e);
      rethrow;
    }
  }
}

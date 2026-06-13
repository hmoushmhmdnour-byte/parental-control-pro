import 'package:firebase_database/firebase_database.dart';
import '../utils/logger.dart';

class DeviceControlService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<void> lockDevice(String childDeviceId) async {
    try {
      AppLogger.info('Sending lock command to: $childDeviceId');
      
      await _database.ref('children/$childDeviceId/commands/lock').set({
        'action': 'LOCK_DEVICE',
        'timestamp': DateTime.now().toIso8601String(),
        'executed': false,
      });
      
      AppLogger.info('Lock command sent successfully');
    } catch (e) {
      AppLogger.error('Error sending lock command', e);
      rethrow;
    }
  }

  Future<void> unlockDevice(String childDeviceId) async {
    try {
      AppLogger.info('Sending unlock command to: $childDeviceId');
      
      await _database.ref('children/$childDeviceId/commands/unlock').set({
        'action': 'UNLOCK_DEVICE',
        'timestamp': DateTime.now().toIso8601String(),
        'executed': false,
      });
      
      AppLogger.info('Unlock command sent successfully');
    } catch (e) {
      AppLogger.error('Error sending unlock command', e);
      rethrow;
    }
  }

  Future<void> setScreenTime(String childDeviceId, int maxMinutes) async {
    try {
      AppLogger.info('Setting screen time to $maxMinutes minutes for: $childDeviceId');
      
      await _database.ref('children/$childDeviceId/settings/maxScreenTime').set(maxMinutes);
      
      await _database.ref('children/$childDeviceId/commands/updateScreenTime').set({
        'action': 'UPDATE_SCREEN_TIME',
        'maxMinutes': maxMinutes,
        'timestamp': DateTime.now().toIso8601String(),
        'executed': false,
      });
      
      AppLogger.info('Screen time set successfully');
    } catch (e) {
      AppLogger.error('Error setting screen time', e);
      rethrow;
    }
  }

  Future<void> sendMessage(String childDeviceId, String message) async {
    try {
      AppLogger.info('Sending message to: $childDeviceId');
      
      await _database.ref('children/$childDeviceId/commands/message').set({
        'action': 'SHOW_MESSAGE',
        'message': message,
        'timestamp': DateTime.now().toIso8601String(),
        'executed': false,
      });
      
      AppLogger.info('Message sent successfully');
    } catch (e) {
      AppLogger.error('Error sending message', e);
      rethrow;
    }
  }

  Future<void> rebootDevice(String childDeviceId) async {
    try {
      AppLogger.info('Sending reboot command to: $childDeviceId');
      
      await _database.ref('children/$childDeviceId/commands/reboot').set({
        'action': 'REBOOT_DEVICE',
        'timestamp': DateTime.now().toIso8601String(),
        'executed': false,
      });
      
      AppLogger.info('Reboot command sent successfully');
    } catch (e) {
      AppLogger.error('Error sending reboot command', e);
      rethrow;
    }
  }
}

import 'package:firebase_database/firebase_database.dart';
import '../models/app_usage_model.dart';
import '../utils/logger.dart';

class AppManagementService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Stream<List<AppUsageModel>> getChildAppsStream(String childDeviceId) {
    try {
      AppLogger.info('Getting apps stream for: $childDeviceId');
      return _database.ref('children/$childDeviceId/apps').onValue.map((event) {
        if (event.snapshot.value == null) {
          return [];
        }
        final Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
        return data.values.map((e) => AppUsageModel.fromJson(e as Map<String, dynamic>)).toList();
      });
    } catch (e) {
      AppLogger.error('Error getting apps stream', e);
      rethrow;
    }
  }

  Future<List<AppUsageModel>> getChildApps(String childDeviceId) async {
    try {
      AppLogger.info('Fetching apps for: $childDeviceId');
      final snapshot = await _database.ref('children/$childDeviceId/apps').get();
      
      if (snapshot.value == null) {
        return [];
      }
      
      final Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
      return data.values.map((e) => AppUsageModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      AppLogger.error('Error fetching apps', e);
      rethrow;
    }
  }

  Future<void> blockApp(String childDeviceId, String packageName) async {
    try {
      AppLogger.info('Blocking app: $packageName for: $childDeviceId');
      
      await _database.ref('children/$childDeviceId/apps/$packageName/isBlocked').set(true);
      
      // Send command to child device
      await _database.ref('children/$childDeviceId/commands/blockApp').set({
        'packageName': packageName,
        'timestamp': DateTime.now().toIso8601String(),
        'executed': false,
      });
      
      AppLogger.info('App blocked successfully');
    } catch (e) {
      AppLogger.error('Error blocking app', e);
      rethrow;
    }
  }

  Future<void> unblockApp(String childDeviceId, String packageName) async {
    try {
      AppLogger.info('Unblocking app: $packageName for: $childDeviceId');
      
      await _database.ref('children/$childDeviceId/apps/$packageName/isBlocked').set(false);
      
      // Send command to child device
      await _database.ref('children/$childDeviceId/commands/unblockApp').set({
        'packageName': packageName,
        'timestamp': DateTime.now().toIso8601String(),
        'executed': false,
      });
      
      AppLogger.info('App unblocked successfully');
    } catch (e) {
      AppLogger.error('Error unblocking app', e);
      rethrow;
    }
  }

  Future<void> setAllowedApps(String childDeviceId, List<String> packageNames) async {
    try {
      AppLogger.info('Setting allowed apps for: $childDeviceId');
      
      await _database.ref('children/$childDeviceId/settings/allowedApps').set(packageNames);
      
      AppLogger.info('Allowed apps set successfully');
    } catch (e) {
      AppLogger.error('Error setting allowed apps', e);
      rethrow;
    }
  }
}

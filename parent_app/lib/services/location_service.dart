import 'package:firebase_database/firebase_database.dart';
import '../models/location_model.dart';
import '../utils/logger.dart';

class LocationService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Stream<LocationModel?> getChildLocationStream(String childDeviceId) {
    try {
      AppLogger.info('Getting location stream for: $childDeviceId');
      return _database.ref('children/$childDeviceId/location').onValue.map((event) {
        if (event.snapshot.value == null) {
          return null;
        }
        return LocationModel.fromJson(event.snapshot.value as Map<dynamic, dynamic> as Map<String, dynamic>);
      });
    } catch (e) {
      AppLogger.error('Error getting location stream', e);
      rethrow;
    }
  }

  Future<LocationModel?> getLastKnownLocation(String childDeviceId) async {
    try {
      AppLogger.info('Fetching last known location for: $childDeviceId');
      final snapshot = await _database.ref('children/$childDeviceId/location').get();
      
      if (snapshot.value == null) {
        return null;
      }
      
      return LocationModel.fromJson(snapshot.value as Map<dynamic, dynamic> as Map<String, dynamic>);
    } catch (e) {
      AppLogger.error('Error fetching last known location', e);
      rethrow;
    }
  }

  Future<List<LocationModel>> getLocationHistory(String childDeviceId, {int limit = 50}) async {
    try {
      AppLogger.info('Fetching location history for: $childDeviceId (limit: $limit)');
      
      final snapshot = await _database.ref('children/$childDeviceId/locationHistory')
          .limitToLast(limit)
          .get();
      
      if (snapshot.value == null) {
        return [];
      }
      
      final Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
      return data.values.map((e) => LocationModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      AppLogger.error('Error fetching location history', e);
      rethrow;
    }
  }

  Future<void> setLocationGeofence(String childDeviceId, double latitude, double longitude, double radiusMeters) async {
    try {
      AppLogger.info('Setting geofence for: $childDeviceId');
      
      await _database.ref('children/$childDeviceId/settings/geofence').set({
        'latitude': latitude,
        'longitude': longitude,
        'radiusMeters': radiusMeters,
        'createdAt': DateTime.now().toIso8601String(),
      });
      
      AppLogger.info('Geofence set successfully');
    } catch (e) {
      AppLogger.error('Error setting geofence', e);
      rethrow;
    }
  }
}

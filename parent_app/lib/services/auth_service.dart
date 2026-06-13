import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/user_model.dart';
import '../utils/logger.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<bool> registerParent({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
  }) async {
    try {
      AppLogger.info('Starting parent registration: $email');
      
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        AppLogger.error('Failed to create user');
        return false;
      }

      // Save parent data to database
      await _database.ref('parents/${user.uid}').set({
        'uid': user.uid,
        'email': email,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'createdAt': DateTime.now().toIso8601String(),
        'lastLogin': DateTime.now().toIso8601String(),
        'isActive': true,
      });

      AppLogger.info('Parent registration successful: ${user.uid}');
      return true;
    } on FirebaseAuthException catch (e) {
      AppLogger.error('Registration error: ${e.message}');
      rethrow;
    } catch (e) {
      AppLogger.error('Unexpected error during registration', e);
      rethrow;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      AppLogger.info('Starting login: $email');
      
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        AppLogger.error('Failed to login user');
        return false;
      }

      // Update last login
      await _database.ref('parents/${user.uid}/lastLogin').set(
        DateTime.now().toIso8601String(),
      );

      AppLogger.info('Login successful: ${user.uid}');
      return true;
    } on FirebaseAuthException catch (e) {
      AppLogger.error('Login error: ${e.message}');
      rethrow;
    } catch (e) {
      AppLogger.error('Unexpected error during login', e);
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      AppLogger.info('Logging out user');
      await _auth.signOut();
      AppLogger.info('Logout successful');
    } catch (e) {
      AppLogger.error('Error during logout', e);
      rethrow;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      AppLogger.info('Sending password reset email: $email');
      await _auth.sendPasswordResetEmail(email: email);
      AppLogger.info('Password reset email sent');
      return true;
    } on FirebaseAuthException catch (e) {
      AppLogger.error('Password reset error: ${e.message}');
      rethrow;
    } catch (e) {
      AppLogger.error('Unexpected error during password reset', e);
      rethrow;
    }
  }

  Future<bool> updatePassword(String newPassword) async {
    try {
      if (currentUser == null) {
        AppLogger.error('No user logged in');
        return false;
      }

      AppLogger.info('Updating password for: ${currentUser!.email}');
      await currentUser!.updatePassword(newPassword);
      AppLogger.info('Password updated successfully');
      return true;
    } on FirebaseAuthException catch (e) {
      AppLogger.error('Update password error: ${e.message}');
      rethrow;
    } catch (e) {
      AppLogger.error('Unexpected error during password update', e);
      rethrow;
    }
  }

  Future<bool> linkChildDevice({
    required String childDeviceId,
    required String childName,
    String? childAge,
  }) async {
    try {
      if (currentUser == null) {
        AppLogger.error('No user logged in');
        return false;
      }

      final parentUid = currentUser!.uid;
      AppLogger.info('Linking child device: $childDeviceId');

      // Add to parent's children list
      await _database.ref('parents/$parentUid/children/$childDeviceId').set({
        'deviceId': childDeviceId,
        'childName': childName,
        'childAge': childAge,
        'linkedAt': DateTime.now().toIso8601String(),
        'isActive': true,
      });

      // Add reverse reference in children collection
      await _database.ref('children/$childDeviceId/parentId').set(parentUid);

      AppLogger.info('Child device linked successfully');
      return true;
    } catch (e) {
      AppLogger.error('Error linking child device', e);
      rethrow;
    }
  }

  Future<bool> unlinkChildDevice(String childDeviceId) async {
    try {
      if (currentUser == null) {
        AppLogger.error('No user logged in');
        return false;
      }

      final parentUid = currentUser!.uid;
      AppLogger.info('Unlinking child device: $childDeviceId');

      await _database.ref('parents/$parentUid/children/$childDeviceId').remove();
      await _database.ref('children/$childDeviceId/parentId').remove();

      AppLogger.info('Child device unlinked successfully');
      return true;
    } catch (e) {
      AppLogger.error('Error unlinking child device', e);
      rethrow;
    }
  }
}

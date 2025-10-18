// lib/database/UsersDao.dart - AGGRESSIVE FIX
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/database/model/AppUser.dart';

class UsersDao {

  // Gets a raw collection of Maps, bypassing the failing converter logic
  static CollectionReference<Map<String, dynamic>> _getUsersCollection() {
    return FirebaseFirestore.instance
        .collection('users')
        .withConverter<Map<String, dynamic>>(
      // This simply passes the raw data map for reading
      fromFirestore: (snapshot, _) => snapshot.data() ?? {},
      // This simply passes the raw data map for writing
      toFirestore: (data, _) => data,
    );
  }

  // Save: Manually converts AppUser to a Map
  static Future<void> addUser(AppUser user) {
    if (user.id == null) {
      throw Exception("Cannot save user with a null ID (UID)");
    }

    // 🚨 Critical: We manually call toMap() and use the raw Map collection 🚨
    return _getUsersCollection().doc(user.id!).set(user.toMap());
  }

  // Retrieve: Manually converts the Map back to AppUser
  static Future<AppUser?> getUserById(String? uid) async {
    if (uid == null) return null;
    try {
      var snapshot = await _getUsersCollection().doc(uid).get();
      final data = snapshot.data();

      if (data != null && data.isNotEmpty) {
        // 🚨 Critical: We manually call fromMap() here 🚨
        return AppUser.fromMap(data);
      }
      return null;
    } catch (e) {
      print("Error fetching user from Firestore: $e");
      return null;
    }
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/database/model/AppUser.dart';


class UsersDao {
  // ✅ Lazy getter instead of static variable
  static FirebaseFirestore get _db => FirebaseFirestore.instance;

  static CollectionReference<AppUser> _getUsersCollection() {
    return _db.collection("users").withConverter<AppUser>(
      fromFirestore: (snapshot, options) {
        return AppUser.fromMap(snapshot.data());
      },
      toFirestore: (user, options) {
        return user.toMap();
      },
    );
  }

  static Future<void> addUser(AppUser user) async {
    var docReference = _getUsersCollection().doc(user.id);
    await docReference.set(user);
  }

  static Future<AppUser?> getUserById(String? uid) async {
    var doc = await _getUsersCollection().doc(uid).get();
    return doc.data();
  }
}

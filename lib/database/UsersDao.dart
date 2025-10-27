import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/database/model/AppUser.dart';
import 'package:events/database/model/events.dart';

class UsersDao{
  static var _db = FirebaseFirestore.instance;

  static CollectionReference<AppUser> _getUsersCollection(){
    return _db.collection("users")
        .withConverter<AppUser>(
      // convert from map to AppUser object
      fromFirestore: (snapshot, options) {
        return AppUser.fromMap(snapshot.data());
      },
      // convert from AppUser object to Map<String,dynamic>
      toFirestore: (user, options) {
        return user.toMap();
      },
    );
  }


  static Future<void> addUser(AppUser user)async{
    // insert into database
    // var docReference = getUsersCollection()
    //     .doc();// auto generate id

    var docReference = _getUsersCollection()
        .doc(user.id);// new doc with 1234 id
    await docReference.set(user);
  }

  static Future<AppUser?> getUserById(String? uid)async{
    var doc = await _getUsersCollection()
        .doc(uid).get();
    return doc.data();
  }

  static Future<AppUser> removeEventFromFavorites(AppUser user,
      String? eventId)async {
    user.favorites.remove(eventId);
    await _getUsersCollection()
        .doc(user.id)
        .set(user);
    return user;

  }
  static Future<AppUser> addEventToFavorites(AppUser user,
      String? eventId)async {
    if(eventId==null)return user;
    user.favorites.add(eventId);
    await _getUsersCollection()
        .doc(user.id)
        .set(user);
    return user;

  }

}
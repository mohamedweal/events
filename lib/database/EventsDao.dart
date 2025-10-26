import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/database/model/events.dart';

class EventsDao{
  static var _db = FirebaseFirestore.instance;

  static CollectionReference<Event> _getEventsCollection(){
    return _db.collection("events")
        .withConverter<Event>(
      // convert from map to AppUser object
      fromFirestore: (snapshot, options) {
        return Event.fromMap(snapshot.data());
      },
      // convert from AppUser object to Map<String,dynamic>
      toFirestore: (event, options) {
        return event.toMap();
      },
    );
  }


  static Future<void> addEvent(Event event)async{
    // insert into database
    var doc =  _getEventsCollection()
        .doc();// auto generate id
    event.id = doc.id;
    await doc.set(event);
  }

  static Future<List<Event>> getEvents()async{
    var collectionRef = await _getEventsCollection()
        .get();
    return collectionRef.docs.map((snapshot) => snapshot.data()).toList();
  }

}
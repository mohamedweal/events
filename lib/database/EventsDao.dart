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

  static Future<List<Event>> getEvents(
      int? categoryId
      )async{
    var collectionReference = await _getEventsCollection();

    var query = collectionReference.orderBy("date",descending: false)
        .orderBy("time",descending: false);

    if(categoryId!=null && categoryId!=0){
      query = query.where("categoryId",isEqualTo: categoryId);
    }

    var collectionRef = await query.get();

    return collectionRef.docs.map((snapshot) => snapshot.data()).toList();
  }

  static Future<List<Event>> getFavoriteEvents(
      int? categoryId,
      List<String> eventIds
      )async{
    var collectionReference = await _getEventsCollection();

    var query = collectionReference
        .orderBy("date",descending: false)
        .orderBy("time",descending: false);


    print("eventIds ${eventIds}");
    print("categoryId ${categoryId}");
    query= query.where(FieldPath.documentId,whereIn:eventIds);

    if(categoryId!=null && categoryId!=0){
      query = query.where("categoryId",isEqualTo: categoryId);
    }

    var collectionRef = await query.get();

    return collectionRef.docs.map((snapshot) => snapshot.data()).toList();
  }

  static Stream<List<Event>> getRealTimeUpdatesForEvents(
      int? categoryId
      )async*{

    var collectionReference = _getEventsCollection();
    var query = collectionReference.orderBy("date",descending: false)
        .orderBy("time",descending: false);

    if(categoryId!=null && categoryId!=0){
      query = query.where("categoryId",isEqualTo: categoryId);
    }
    yield* query.snapshots()
        .map((event) => event.docs.map((docSnapshot) => docSnapshot.data(),).toList(),);
  }

}
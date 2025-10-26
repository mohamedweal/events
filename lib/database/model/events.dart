class Event {
  String? id;
  String? creatorUserId;
  String? title;
  String? desc;
  DateTime? date;
  DateTime? time;
  int? categoryId;
  bool isFavorite = false;

  Event({
    this.id,
    this.creatorUserId,
    this.title,
    this.categoryId,
    this.date,
    this.time,
    this.desc,
  });

  factory Event.fromMap(Map<String, dynamic>? map) {
    return Event(
        id: map?['id'],
        creatorUserId: map?['creatorUserId'],
        title: map?['title'],
        desc: map?['desc'],
        categoryId: map?['categoryId'],
        time: DateTime.fromMillisecondsSinceEpoch(map?['time']),
        date: DateTime.fromMillisecondsSinceEpoch(map?['date'])
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id' : id,
      'creatorUserId' : creatorUserId,
      'title' : title,
      'desc' : desc,
      'date' : date?.millisecondsSinceEpoch ,// convert Date time to milliseconds
      'time' : time?.millisecondsSinceEpoch ,// convert Date time to milliseconds
      'categoryId' : categoryId,
    };
  }

  String getCategoryImage() {
    switch (categoryId) {
      case 1:
        return 'assets/images/Sport.png';
      case 2:
        return 'assets/images/Gaming.png';
      case 3:
        return 'assets/images/Workshop.png';
      case 4:
        return 'assets/images/Birthday.png';
    }
    return '';
  }
}

extension DateMonth on DateTime {
  String getShortMonthName() {
    const List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[this.month - 1];
  }
}
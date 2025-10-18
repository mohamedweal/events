class Event {
  String? title;
  String? desc;
  DateTime? date;
  String? category;
  bool isFav;

  Event({
    required this.title,
    required this.category,
    required this.date,
    required this.desc,
    required this.isFav,
  });

  static String getCategoryImage(String category) {
    switch (category.toLowerCase()) {
      case 'birthday':
        return 'assets/images/Birthday.png';
      case 'gaming':
        return 'assets/images/Gamming.png';
      case 'sport':
        return 'assets/images/Sport.png';
      case 'workshop':
        return 'assets/images/Workshop.png';
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
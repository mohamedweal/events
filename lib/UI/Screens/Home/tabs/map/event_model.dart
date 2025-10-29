class Event {
  final String id;
  final String title;
  final String location;
  final String category;
  // New direct properties for latitude and longitude (now doubles)
  final double lat;
  final double lng;

  const Event({
    required this.id,
    required this.title,
    required this.location,
    required this.category,
    required this.lat, // Required lat
    required this.lng, // Required lng
  });

  // Static method to provide mock event data.
  static List<Event> getEgyptianEvents() {
    return [
      // --- Original 5 Events (Cairo/Giza) ---
      Event(
        id: 'e1',
        title: 'Tech Summit 2024',
        location: 'Cairo Convention Center',
        category: 'Tech',
        lat: 30.0626,
        lng: 31.2497,
      ),
      Event(
        id: 'e2',
        title: 'Impressionist Art',
        location: 'Downtown Gallery',
        category: 'Art',
        lat: 30.0470,
        lng: 31.2330,
      ),
      Event(
        id: 'e3',
        title: 'Desert Music Fest',
        location: 'Giza Pyramids Area',
        category: 'Music',
        lat: 29.9764,
        lng: 31.1313,
      ),
      Event(
        id: 'e4',
        title: 'Startup Workshop',
        location: 'New Cairo Hub',
        category: 'Business',
        lat: 30.0210,
        lng: 31.4720,
      ),
      Event(
        id: 'e5',
        title: 'Ancient Egypt Tour',
        location: 'Egyptian Museum',
        category: 'Culture',
        lat: 30.0473,
        lng: 31.2367,
      ),

      // --- 5 New Events (Expanding Coverage) ---
      Event(
        id: 'e6',
        title: 'Red Sea Dive Expo',
        location: 'Hurghada Marina',
        category: 'Sport',
        lat: 27.2424,
        lng: 33.8214,
      ),
      Event(
        id: 'e7',
        title: 'Aswan Folk Festival',
        location: 'Aswan Corniche',
        category: 'Music',
        lat: 24.0889,
        lng: 32.8998,
      ),
      Event(
        id: 'e8',
        title: 'Alexandria Film Screening',
        location: 'Bibliotheca Alexandrina',
        category: 'Culture',
        lat: 31.2087,
        lng: 29.9079,
      ),
      Event(
        id: 'e9',
        title: 'Modern Architecture Talk',
        location: 'Zamalek, Cairo',
        category: 'Tech',
        lat: 30.0635,
        lng: 31.2215,
      ),
      Event(
        id: 'e10',
        title: 'Siwa Oasis Retreat',
        location: 'Siwa City Center',
        category: 'Wellness',
        lat: 29.2065,
        lng: 25.5181,
      ),
    ];
  }
}

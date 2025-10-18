// In lib/database/model/AppUser.dart
class AppUser {
  final String? id;
  final String name;
  final String phone;
  final String email;

  AppUser({this.id, required this.name, required this.phone, required this.email});

  // 1. Convert to a Firestore-safe Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
    };
  }

  // 2. Create object from a Firestore Map
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      // Ensure all types are explicitly cast as String
      id: map['id'] as String?,
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
    );
  }
}
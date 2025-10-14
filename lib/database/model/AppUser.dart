class AppUser{
  String? name;
  String? phone;
  String? email;
  String? id;
  AppUser({
    this.id,
    this.name,
    this.email,
    this.phone
});

  AppUser.fromMap(Map<String, dynamic>? map){
    this.id = map?['id'];
    this.name = map?['name'];
    this.phone = map?['phone'];
    this.email = map?['email'];
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'id': id,
    };
  }
}
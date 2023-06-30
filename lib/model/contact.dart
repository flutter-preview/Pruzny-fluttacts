class Contact {
  String name;
  String email;
  String phone;
  String? birthday;

  Contact({required this.name, required this.email, required this.phone, this.birthday});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "name": name,
      "email": email,
      "phone": phone,
      "birthday": birthday,
    };
  }

  factory Contact.fromMap(Map<dynamic, dynamic> map) {
    return Contact(
      name: map["name"] as String,
      email: map["email"] as String,
      phone: map["phone"] as String,
      birthday: map["birthday"] as String?,
    );
  }
}
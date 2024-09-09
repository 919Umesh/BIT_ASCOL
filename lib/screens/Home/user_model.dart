class UserModel {
  String id;
  String contact;
  String name;
  String email;
  int age;
  String address;

  UserModel({
    required this.id,
    required this.contact,
    required this.name,
    required this.email,
    required this.age,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      contact: json['contact'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      age: json['age'] ?? 0,
      address: json['address'] ?? '',
    );
  }
}

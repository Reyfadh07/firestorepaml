import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ContactModel {
  String? id;
  final String name;
  final String email;
  final String address;
  final String phone;
  ContactModel({
    this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

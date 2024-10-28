import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id; // Firestore document ID
  String name;
  String email;
  String pass;
  String phone;
  String image;
  String address;
  String orderCount;
  String role;
  List<dynamic> employees;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.pass,
    required this.address,
    required this.image,
    required this.orderCount,
    required this.role,
    required this.employees,
  });

  // Convert Firestore Document to Shop object
  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return UserModel(
      id: doc.id,
      name: data['name'] ?? "",
      email: data['email'] ?? "",
      phone: data['phone'] ?? "",
      pass: data['pass'] ?? "",
      address: data['address'] ?? "",
      image: data['image'] ?? "",
      orderCount: data['order_count'] ?? "",
      role: data['role'] ?? "",
      employees: data['employees'] ?? [],
    );
  }

  // Convert Shop object to Firestore Document data
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'image': image,
      'pass': pass,
      'order_count': orderCount,
      'role': role,
      'employees': employees,
    };
  }
}

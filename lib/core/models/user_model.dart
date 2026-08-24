import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({required this.id, required this.name, required this.email});

  final String id;
  final String name;
  final String email;

  factory UserModel.fromDocument(Map<String, dynamic> json) {
    return UserModel(
      id: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  @override
  List<Object?> get props => [id, name, email];

  UserModel copyWith({String? id, String? name, String? email}) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
  Map<String, dynamic> toDocument() {
    return {
      'uid': id,
      'name': name,
      'email': email,
    };
  }
}

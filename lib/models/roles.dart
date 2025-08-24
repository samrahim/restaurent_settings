import 'package:equatable/equatable.dart';

class Role extends Equatable {
  final String id;
  final String name;
  final String description;

  const Role({required this.id, required this.name, required this.description});

  @override
  List<Object?> get props => [id, name, description];
  factory Role.fromJSon(Map<String, dynamic> map) {
    return Role(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }
}

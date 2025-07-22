import 'package:equatable/equatable.dart';

class SalleModel extends Equatable {
  final int id;
  final String name;

  const SalleModel({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];

  SalleModel copyWith({int? id, String? name}) {
    return SalleModel(id: id ?? this.id, name: name ?? this.name);
  }

  factory SalleModel.fromJson(Map<String, dynamic> json) {
    return SalleModel(id: json['id'] as int, name: json['name'] as String);
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

import 'package:equatable/equatable.dart';

class SalleModel extends Equatable {
  final int id;
  final String nom;

  const SalleModel({required this.id, required this.nom});

  @override
  List<Object?> get props => [id, nom];

  SalleModel copyWith({int? id, String? nom}) {
    return SalleModel(id: id ?? this.id, nom: nom ?? this.nom);
  }
}

List<SalleModel> salles = [
  SalleModel(id: 1, nom: 'Toutes'),
  SalleModel(id: 2, nom: 'Salle principale'),
  SalleModel(id: 3, nom: 'Terrasse'),
  SalleModel(id: 4, nom: 'Bar'),
];

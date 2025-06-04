import 'package:equatable/equatable.dart';

class ProduitsModel extends Equatable {
  final String id;
  final String nom;

  final String prix;
  final String? image;

  const ProduitsModel({
    required this.id,
    required this.nom,
    required this.prix,
    required this.image,
  });
  ProduitsModel copyWith({
    String? id,
    String? nom,
    String? prix,
    String? image,
  }) {
    return ProduitsModel(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prix: prix ?? this.prix,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [id, nom, prix, image];
}

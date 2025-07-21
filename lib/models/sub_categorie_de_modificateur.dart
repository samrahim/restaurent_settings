import 'package:equatable/equatable.dart';

class SubCategorieDeModificateur extends Equatable {
  final String id;
  final String nom;
  final double prix;
  final double tvaValue;
  final bool actif;
  const SubCategorieDeModificateur({
    required this.id,
    required this.nom,
    required this.prix,
    required this.tvaValue,
    required this.actif,
  });
  factory SubCategorieDeModificateur.fromJson(Map<String, dynamic> json) {
    return SubCategorieDeModificateur(
      id: json['id'] ?? "",
      nom: json['nom'] ?? '',
      prix: (json['prix'] ?? 0).toDouble(),
      tvaValue: (json['tauxTva'] ?? 0).toDouble(),
      actif: json['actif'] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {'nom': nom, 'prix': prix, 'tauxTva': tvaValue, 'actif': actif};
  }

  @override
  List<Object?> get props => [id, nom, prix, tvaValue];
  SubCategorieDeModificateur copyWith({
    String? id,
    String? nom,
    double? prix,
    double? tvaValue,
    bool? actif,
  }) {
    return SubCategorieDeModificateur(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prix: prix ?? this.prix,
      tvaValue: tvaValue ?? this.tvaValue,
      actif: actif ?? this.actif,
    );
  }
}

import 'package:equatable/equatable.dart';

class SubCategorieDeModificateur extends Equatable {
  final String? id;
  final String nom;
  final double prix;
  final double? tvaValue;
  final bool actif;
  const SubCategorieDeModificateur({
    required this.nom,
    required this.prix,
    this.tvaValue,
    required this.actif,
    this.id,
  });
  factory SubCategorieDeModificateur.fromJson(Map<String, dynamic> json) {
    return SubCategorieDeModificateur(
      nom: json['nom'] ?? '',
      prix: (json['prix']).toDouble(),
      tvaValue: (json['tauxTva'])?.toDouble(),
      actif: json['actif'] ?? false,
      id: json['id'] ?? json['id'],
    );
  }
  Map<String, dynamic> toJson() {
    if (id == null) {
      return {'nom': nom, 'prix': prix, 'tauxTva': tvaValue, 'actif': actif};
    } else {
      return {
        'nom': nom,
        'prix': prix,
        'tauxTva': tvaValue,
        'actif': actif,
        'id': id,
      };
    }
  }

  @override
  List<Object?> get props => [nom, prix, tvaValue, id, actif];
  SubCategorieDeModificateur copyWith({
    String? id,
    String? nom,
    double? prix,
    double? tvaValue,
    bool? actif,
  }) {
    return SubCategorieDeModificateur(
      nom: nom ?? this.nom,
      prix: prix ?? this.prix,
      tvaValue: tvaValue ?? this.tvaValue,
      actif: actif ?? this.actif,
      id: id ?? this.id,
    );
  }
}

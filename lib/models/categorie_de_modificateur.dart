import 'package:equatable/equatable.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/sub_categorie_de_modificateur.dart';

class CategorieDeModificateur extends Equatable {
  final String? id;
  final String? nom;
  final String? icone;
  final List<int>? sallesIDS;
  final TypeDeSelection? typeSelection;
  final bool? obligatoire;
  final String? couleur;
  final List<String>? produitsIds;
  final List<SubCategorieDeModificateur> modificateurs;
  final AffectationMode? salleMode;
  final AffectationMode? produitMode;

  const CategorieDeModificateur({
    this.id,
    required this.nom,
    required this.icone,
    required this.sallesIDS,
    required this.typeSelection,
    required this.obligatoire,
    required this.couleur,
    required this.modificateurs,
    required this.produitsIds,
    required this.salleMode,
    required this.produitMode,
  });

  CategorieDeModificateur copyWith({
    String? id,
    String? nom,
    String? couleur,
    String? icone,
    bool? obligatoire,
    TypeDeSelection? typeSelection,
    List<int>? sallesIDS,
    List<SubCategorieDeModificateur>? modificateurs,
    List<String>? produitsIds,
    AffectationMode? salleMode,
    AffectationMode? produitMode,
  }) {
    return CategorieDeModificateur(
      id: id ?? this.id,
      modificateurs: modificateurs ?? this.modificateurs,
      nom: nom ?? this.nom,
      icone: icone ?? this.icone,
      sallesIDS: sallesIDS ?? this.sallesIDS,
      typeSelection: typeSelection ?? this.typeSelection,
      obligatoire: obligatoire ?? this.obligatoire,
      couleur: couleur ?? this.couleur,
      produitsIds: produitsIds ?? this.produitsIds,
      salleMode: salleMode ?? this.salleMode,
      produitMode: produitMode ?? this.produitMode,
    );
  }

  factory CategorieDeModificateur.fromJson(Map<String, dynamic> json) {
    return CategorieDeModificateur(
      id: json['id'],
      nom: json['nom'],
      icone: json['icone'],
      sallesIDS: List<int>.from(json['salleIds'] ?? []),
      typeSelection: TypeDeSelection.values.firstWhere(
        (e) => e.name == json['typeSelection'],
        orElse: () => TypeDeSelection.SINGLE,
      ),
      obligatoire: json['obligatoire'],
      couleur: json['couleur'],
      modificateurs:
          (json['modificateurs'] as List)
              .map((e) => SubCategorieDeModificateur.fromJson(e))
              .toList(),
      produitsIds: List<String>.from(json['produitIds'] ?? []),
      produitMode: AffectationMode.values.firstWhere(
        (e) => e.name == json['produitMode'],
        orElse: () => AffectationMode.POUR_SEULEMENT,
      ),
      salleMode: AffectationMode.values.firstWhere(
        (e) => e.name == json['salleMode'],
        orElse: () => AffectationMode.POUR_SEULEMENT,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      "id": id,
      "nom": nom,
      "icone": icone,
      "salleIds": sallesIDS,
      "typeSelection": typeSelection?.name,
      "obligatoire": obligatoire,
      "couleur": couleur,
      "modificateurs": modificateurs.map((e) => e.toJson()).toList(),
      "produitIds": produitsIds,
      "salleMode": salleMode?.name,
      "produitMode": produitMode?.name,
    };

    map.removeWhere(
      (key, value) => value == null || (value is String && value.isEmpty),
    );

    return map;
  }

  @override
  List<Object?> get props => [
    id,
    nom,
    icone,
    sallesIDS,
    typeSelection,
    obligatoire,
    couleur,
    modificateurs,
    salleMode,
    produitsIds,
  ];
}

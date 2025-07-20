import 'package:equatable/equatable.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/sub_categorie_de_modificateur.dart';

enum AffectationMode {
  Pour_tout,
  Pour_seulement,
  Pour_tout_sauf,
  Ajouter_a_liste_existante,
}

class CategorieDeModificateur extends Equatable {
  final String? id;
  final String? nom;
  final String? icone;
  final List<int>? sallesIDS;
  final String? typeSelection;
  final bool? obligatoire;
  final String? color;
  final List<String>? produitsIds;
  final List<SubCategorieDeModificateur> modificateurs;
  final AffectationMode? affectationMode;

  const CategorieDeModificateur({
    required this.id,
    required this.nom,
    required this.icone,
    required this.sallesIDS,
    required this.typeSelection,
    required this.obligatoire,
    required this.color,
    required this.modificateurs,
    required this.produitsIds,
    required this.affectationMode,
  });

  CategorieDeModificateur copyWith({
    String? id,
    String? nom,
    String? color,
    String? icone,
    bool? obligatoire,
    String? typeSelection,
    List<int>? sallesIDS,
    List<SubCategorieDeModificateur>? modificateurs,
    List<String>? produitsIds,
    AffectationMode? affectationMode,
  }) {
    return CategorieDeModificateur(
      id: id ?? this.id,
      modificateurs: modificateurs ?? this.modificateurs,
      nom: nom ?? this.nom,
      icone: icone ?? this.icone,
      sallesIDS: sallesIDS ?? this.sallesIDS,
      typeSelection: typeSelection ?? this.typeSelection,
      obligatoire: obligatoire ?? this.obligatoire,
      color: color ?? this.color,
      produitsIds: produitsIds ?? this.produitsIds,
      affectationMode: affectationMode ?? this.affectationMode,
    );
  }

  factory CategorieDeModificateur.fromJson(Map<String, dynamic> json) {
    return CategorieDeModificateur(
      id: json['id'],
      nom: json['nom'],
      icone: json['icone'],
      sallesIDS: List<int>.from(json['sallesIDS'] ?? []),
      typeSelection: json['typeSelection'],
      obligatoire: json['obligatoire'],
      color: json['couleur'],
      modificateurs:
          (json['modificateurs'] as List)
              .map((e) => SubCategorieDeModificateur.fromJson(e))
              .toList(),
      produitsIds: List<String>.from(json['produitIds'] ?? []),
      affectationMode: AffectationMode.values.firstWhere(
        (e) => e.toString() == 'AffectationMode.${json['affectationMode']}',
        orElse: () => AffectationMode.Pour_tout,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'icone': icone,
      'sallesIDS': sallesIDS,
      'typeSelection': typeSelection,
      'obligatoire': obligatoire,
      'couleur': color,
      'modificateurs': modificateurs.map((e) => e.toJson()).toList(),
      'produitsIds': produitsIds,
      'affectationMode': affectationMode?.toString().split('.').last,
    };
  }

  @override
  List<Object?> get props => [
    id,
    nom,
    icone,
    sallesIDS,
    typeSelection,
    obligatoire,
    color,
    modificateurs,
    affectationMode,
    produitsIds,
  ];
}

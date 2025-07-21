import 'package:equatable/equatable.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/sub_categorie_de_modificateur.dart';

enum SalleMode {
  POUR_TOUT,
  POUR_SEULEMENT,
  POUR_TOUT_SAUF,
  AJOUTER_A_LIST_EXSISTANTE,
}

class CategorieDeModificateur extends Equatable {
  final String? id;
  final String? nom;
  final String? icone;
  final List<int>? sallesIDS;
  final String? typeSelection;
  final bool? obligatoire;
  final String? couleur;
  final List<String>? produitsIds;
  final List<SubCategorieDeModificateur> modificateurs;
  final SalleMode? salleMode;
  final SalleMode? produitMode;

  const CategorieDeModificateur({
    required this.id,
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
    String? typeSelection,
    List<int>? sallesIDS,
    List<SubCategorieDeModificateur>? modificateurs,
    List<String>? produitsIds,
    SalleMode? salleMode,
    SalleMode? produitMode,
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
      sallesIDS: List<int>.from(json['sallesIDS'] ?? []),
      typeSelection: json['typeSelection'],
      obligatoire: json['obligatoire'],
      couleur: json['couleur'],
      modificateurs:
          (json['modificateurs'] as List)
              .map((e) => SubCategorieDeModificateur.fromJson(e))
              .toList(),
      produitsIds: List<String>.from(json['produitIds'] ?? []),
      produitMode:
          json['produitMode'] != null
              ? SalleMode.values.firstWhere(
                (e) => e.toString() == 'produitMode.${json['produitMode']}',
                orElse: () => SalleMode.POUR_TOUT,
              )
              : null,
      salleMode: SalleMode.values.firstWhere(
        (e) => e.toString() == 'salleMode.${json['salleMode']}',
        orElse: () => SalleMode.POUR_TOUT,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'icone': icone,
      'salleIds': sallesIDS,
      'typeSelection':
          typeSelection == 'SINGLE'
              ? "SINGLE"
              : typeSelection == "MULTIPLE QUANTITE"
              ? 'MULTIPLE_QUANTITE'
              : null,
      'obligatoire': obligatoire,
      'couleur': couleur,
      'modificateurs': modificateurs.map((e) => e.toJson()).toList(),
      'produitIds': produitsIds,
      'salleMode': salleMode?.toString().split('.').last,
      'produitMode': produitMode?.toString().split('.').last,
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
    couleur,
    modificateurs,
    salleMode,
    produitsIds,
  ];
}

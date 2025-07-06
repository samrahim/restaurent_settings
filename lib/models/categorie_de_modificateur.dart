import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  final List<int> salleIds;

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
    required this.salleIds,
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
    List<int>? salleIds,
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
      salleIds: salleIds ?? this.salleIds,
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
      salleIds: List<int>.from(json['salleIds'] ?? []),
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
      'salleIds': salleIds,
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
    salleIds,
  ];
}

List<CategorieDeModificateur> categoriesdemodificateursList = [
  CategorieDeModificateur(
    modificateurs: [],
    id: '1',
    nom: 'Cuisson',
    icone: null,
    sallesIDS: [2],
    typeSelection: optiontypeDeSelection[0],
    obligatoire: true,
    color: '',
    produitsIds: [],
    affectationMode: AffectationMode.Ajouter_a_liste_existante,
    salleIds: [],
  ),
  CategorieDeModificateur(
    modificateurs: [],
    id: '2',
    nom: 'Sauces',
    icone: null,
    sallesIDS: [1],
    typeSelection: optiontypeDeSelection[1],
    obligatoire: false,
    color: '',
    produitsIds: [],
    affectationMode: AffectationMode.Ajouter_a_liste_existante,
    salleIds: [],
  ),
  CategorieDeModificateur(
    modificateurs: [],
    id: '3',
    nom: 'Supplements payants',
    icone: null,
    sallesIDS: [2],
    typeSelection: optiontypeDeSelection[1],
    obligatoire: false,
    color: '',
    produitsIds: [],
    affectationMode: AffectationMode.Pour_tout_sauf,
    salleIds: [],
  ),
  CategorieDeModificateur(
    modificateurs: [],
    id: '4',
    nom: 'Accompagnement',
    icone: null,
    sallesIDS: [1, 2],
    typeSelection: optiontypeDeSelection[1],
    obligatoire: true,
    color: '',
    affectationMode: AffectationMode.Pour_seulement,
    salleIds: [],
    produitsIds: [],
  ),
  CategorieDeModificateur(
    modificateurs: [],
    id: '5',
    nom: 'Glaces',
    icone: null,
    sallesIDS: [2],
    typeSelection: optiontypeDeSelection[1],
    obligatoire: false,
    color: '',
    produitsIds: [],
    salleIds: [],
    affectationMode: AffectationMode.Ajouter_a_liste_existante,
  ),
];

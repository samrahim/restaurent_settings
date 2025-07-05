import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/produits_model.dart';
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
  final String? icon;
  final List<int>? sallesIDS;
  final String? typeDeSelection;
  final bool? obligatoire;
  final Color? color;
  final List<ProduitsModel> produits;
  final List<SubCategorieDeModificateur> subCategories;
  AffectationMode? affectationMode;
  CategorieDeModificateur({
    required this.id,
    required this.nom,
    required this.icon,
    required this.sallesIDS,
    required this.typeDeSelection,
    required this.obligatoire,
    required this.color,
    required this.subCategories,
    required this.produits,
    required this.affectationMode,
  });

  CategorieDeModificateur copyWith({
    String? id,
    String? nom,
    Color? color,
    String? icon,
    bool? obligatoire,
    String? typeDeSelection,
    List<int>? sallesIDS,
    List<SubCategorieDeModificateur>? subCategories,
    List<ProduitsModel>? produits,
    AffectationMode? affectationMode,
  }) {
    return CategorieDeModificateur(
      id: id ?? this.id,
      subCategories: subCategories ?? this.subCategories,
      nom: nom ?? this.nom,
      icon: icon ?? this.icon,
      sallesIDS: sallesIDS ?? this.sallesIDS,
      typeDeSelection: typeDeSelection ?? this.typeDeSelection,
      obligatoire: obligatoire ?? this.obligatoire,
      color: color ?? this.color,
      produits: produits ?? this.produits,
      affectationMode: affectationMode ?? this.affectationMode,
    );
  }

  @override
  List<Object?> get props => [
    id,
    nom,
    icon,
    sallesIDS,
    typeDeSelection,
    obligatoire,
    color,
    subCategories,
    affectationMode,
    produits,
  ];
}

List<CategorieDeModificateur> categoriesdemodificateursList = [
  CategorieDeModificateur(
    subCategories: [],
    id: '1',
    nom: 'Cuisson',
    icon: null,
    sallesIDS: [2],
    typeDeSelection: optiontypeDeSelection[0],
    obligatoire: true,
    color: Colors.pink,
    produits: [],
    affectationMode: AffectationMode.Ajouter_a_liste_existante,
  ),
  CategorieDeModificateur(
    subCategories: [],
    id: '2',
    nom: 'Sauces',
    icon: null,
    sallesIDS: [1],
    typeDeSelection: optiontypeDeSelection[1],
    obligatoire: false,
    color: Colors.purpleAccent,
    produits: [],
    affectationMode: AffectationMode.Ajouter_a_liste_existante,
  ),
  CategorieDeModificateur(
    subCategories: [],
    id: '3',
    nom: 'Supplements payants',
    icon: null,
    sallesIDS: [2],
    typeDeSelection: optiontypeDeSelection[1],
    obligatoire: false,
    color: Colors.deepOrangeAccent,
    produits: [],
    affectationMode: AffectationMode.Pour_tout_sauf,
  ),
  CategorieDeModificateur(
    subCategories: [],
    id: '4',
    nom: 'Accompagnement',
    icon: null,
    sallesIDS: [1, 2],
    typeDeSelection: optiontypeDeSelection[1],
    obligatoire: true,
    color: Colors.amber,
    affectationMode: AffectationMode.Pour_seulement,
    produits: [],
  ),
  CategorieDeModificateur(
    subCategories: [],
    id: '5',
    nom: 'Glaces',
    icon: null,
    sallesIDS: [2],
    typeDeSelection: optiontypeDeSelection[1],
    obligatoire: false,
    color: Colors.cyan,
    produits: [],
    affectationMode: AffectationMode.Ajouter_a_liste_existante,
  ),
];

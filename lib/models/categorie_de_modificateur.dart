import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/produits_model.dart';
import 'package:restaurent/models/sub_categorie_de_modificateur.dart';

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
  const CategorieDeModificateur({
    required this.id,
    required this.nom,
    required this.icon,
    required this.sallesIDS,
    required this.typeDeSelection,
    required this.obligatoire,
    required this.color,
    required this.subCategories,
    required this.produits,
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
  ),
];

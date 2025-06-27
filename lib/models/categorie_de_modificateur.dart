import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:restaurent/consts.dart';

class CategorieDeModificateur extends Equatable {
  final String? id;
  final String? nom;
  final String? icon;
  final List<int>? sallesIDS;
  final String? typeDeSelection;
  final bool? obligatoire;
  final Color? color;

  const CategorieDeModificateur({
    required this.id,
    required this.nom,
    required this.icon,
    required this.sallesIDS,
    required this.typeDeSelection,
    required this.obligatoire,
    required this.color,
  });

  CategorieDeModificateur copyWith({
    String? id,
    String? nom,
    Color? color,
    String? icon,
    bool? obligatoire,
    String? typeDeSelection,
    List<int>? sallesIDS,
  }) {
    return CategorieDeModificateur(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      icon: icon ?? this.icon,
      sallesIDS: sallesIDS ?? this.sallesIDS,
      typeDeSelection: typeDeSelection ?? this.typeDeSelection,
      obligatoire: obligatoire ?? this.obligatoire,
      color: color ?? this.color,
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
  ];
}

List<CategorieDeModificateur> categoriesdemodificateursList = [
  CategorieDeModificateur(
    id: '1',
    nom: 'Cuisson',
    icon: null,
    sallesIDS: [2],
    typeDeSelection: optiontypeDeSelection[0],
    obligatoire: true,
    color: Colors.pink,
  ),
  CategorieDeModificateur(
    id: '2',
    nom: 'Sauces',
    icon: null,
    sallesIDS: [1],
    typeDeSelection: optiontypeDeSelection[1],
    obligatoire: false,
    color: Colors.purpleAccent,
  ),
  CategorieDeModificateur(
    id: '3',
    nom: 'Supplements payants',
    icon: null,
    sallesIDS: [2],
    typeDeSelection: optiontypeDeSelection[1],
    obligatoire: false,
    color: Colors.deepOrangeAccent,
  ),
  CategorieDeModificateur(
    id: '4',
    nom: 'Accompagnement',
    icon: null,
    sallesIDS: [1, 2],
    typeDeSelection: optiontypeDeSelection[1],
    obligatoire: true,
    color: Colors.amber,
  ),
  CategorieDeModificateur(
    id: '5',
    nom: 'Glaces',
    icon: null,
    sallesIDS: [2],
    typeDeSelection: optiontypeDeSelection[1],
    obligatoire: false,
    color: Colors.cyan,
  ),
];

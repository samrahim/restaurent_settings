import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:restaurent/consts.dart';

class CategorieDeModificateur extends Equatable {
  final String? id;
  final String? nom;
  final String? icon;
  final String? typeDeSalleDisponible;
  final String? typeDeSelection;
  final bool? obligatoire;
  final Color? color;

  const CategorieDeModificateur({
    required this.id,
    required this.nom,
    required this.icon,
    required this.typeDeSalleDisponible,
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
    String? typeDeSalleDisponible,
  }) {
    return CategorieDeModificateur(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      icon: icon ?? this.icon,
      typeDeSalleDisponible:
          typeDeSalleDisponible ?? this.typeDeSalleDisponible,
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
    typeDeSalleDisponible,
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
    typeDeSalleDisponible: salles[0],
    typeDeSelection: optiontypeDeSelection[0],
    obligatoire: true,
    color: Colors.pink,
  ),
  CategorieDeModificateur(
    id: '2',
    nom: 'Sauces',
    icon: null,
    typeDeSalleDisponible: salles[1],
    typeDeSelection: optiontypeDeSelection[1],
    obligatoire: false,
    color: Colors.purpleAccent,
  ),
  CategorieDeModificateur(
    id: '3',
    nom: 'Supplements payants',
    icon: null,
    typeDeSalleDisponible: salles[2],
    typeDeSelection: optiontypeDeSelection[1],
    obligatoire: false,
    color: Colors.deepOrangeAccent,
  ),
  CategorieDeModificateur(
    id: '4',
    nom: 'Accompagnement',
    icon: null,
    typeDeSalleDisponible: salles[1],
    typeDeSelection: optiontypeDeSelection[1],
    obligatoire: true,
    color: Colors.amber,
  ),
  CategorieDeModificateur(
    id: '5',
    nom: 'Glaces',
    icon: null,
    typeDeSalleDisponible: salles[2],
    typeDeSelection: optiontypeDeSelection[1],
    obligatoire: false,
    color: Colors.cyan,
  ),
];

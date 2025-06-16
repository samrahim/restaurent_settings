import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/produits_model.dart';

class CategorieDePrixModel extends Equatable {
  String? id;
  String? nom;
  String? nomCourt;
  bool? status;
  bool? afficherNomCourtEnCommande;
  bool? afficherNomCourtEnEncaissement;
  bool? afficherNomCourtEnFabrication;
  bool? actifDansTouteLaJournee;
  bool? categorieDePrixActive;
  List<String>? joursDactivite;
  String? salle;
  TimeOfDay? heureDebut;
  TimeOfDay? heureFin;
  List<ProduitsModel>? produits;

  CategorieDePrixModel({
    required this.produits,
    required this.id,
    required this.nom,
    required this.nomCourt,
    required this.status,
    required this.afficherNomCourtEnCommande,
    required this.afficherNomCourtEnEncaissement,
    required this.afficherNomCourtEnFabrication,
    required this.actifDansTouteLaJournee,
    required this.categorieDePrixActive,
    required this.joursDactivite,
    required this.salle,
    required this.heureDebut,
    required this.heureFin,
  });
  CategorieDePrixModel copyWith({
    String? id,
    String? nom,
    String? nomCourt,
    bool? status,
    bool? afficherNomCourtEnCommande,
    bool? afficherNomCourtEnEncaissement,
    bool? actifDansTouteLaJournee,
    bool? actifDansTouteLaNuit,
    List<String>? joursDactivite,
    String? salle,
    TimeOfDay? heureDebut,
    TimeOfDay? heureFin,
    bool? categorieDePrixActive,
    List<ProduitsModel>? produits,
    bool? afficherNomCourtEnFabrication,
  }) {
    return CategorieDePrixModel(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      nomCourt: nomCourt ?? this.nomCourt,
      status: status ?? this.status,
      afficherNomCourtEnCommande:
          afficherNomCourtEnCommande ?? this.afficherNomCourtEnCommande,
      afficherNomCourtEnEncaissement:
          afficherNomCourtEnEncaissement ?? this.afficherNomCourtEnEncaissement,
      afficherNomCourtEnFabrication:
          afficherNomCourtEnFabrication ?? this.afficherNomCourtEnFabrication,
      actifDansTouteLaJournee:
          actifDansTouteLaJournee ?? this.actifDansTouteLaJournee,
      categorieDePrixActive:
          categorieDePrixActive ?? this.categorieDePrixActive,
      joursDactivite: joursDactivite ?? this.joursDactivite,
      salle: salle ?? this.salle,
      heureDebut: heureDebut ?? this.heureDebut,
      heureFin: heureFin ?? this.heureFin,
      produits: produits ?? this.produits,
    );
  }

  @override
  List<Object?> get props => [
    id,
    nom,
    nomCourt,
    status,
    afficherNomCourtEnCommande,
    afficherNomCourtEnEncaissement,
    afficherNomCourtEnFabrication,
    actifDansTouteLaJournee,
    categorieDePrixActive,
    joursDactivite,
    salle,
    heureDebut,
    heureFin,
    produits,
  ];
}

List<CategorieDePrixModel> categoriesPrixList = [
  CategorieDePrixModel(
    id: '1',
    nom: 'Happy Hour',
    nomCourt: 'HH',
    status: true,
    afficherNomCourtEnCommande: true,
    afficherNomCourtEnEncaissement: false,
    afficherNomCourtEnFabrication: true,
    actifDansTouteLaJournee: true,
    categorieDePrixActive: true,
    salle: salles[0],
    heureDebut: null,
    heureFin: null,
    produits: [],
    joursDactivite: ['Lundi', 'Mardi'],
  ),
  CategorieDePrixModel(
    id: '2',
    nom: 'Terrasse',
    nomCourt: 'TR',
    status: true,
    afficherNomCourtEnCommande: true,
    afficherNomCourtEnEncaissement: false,
    afficherNomCourtEnFabrication: true,
    actifDansTouteLaJournee: false,
    categorieDePrixActive: true,
    salle: salles[2],
    heureDebut: TimeOfDay(hour: 17, minute: 0),
    heureFin: TimeOfDay(hour: 19, minute: 0),
    produits: [],
    joursDactivite: ['Lundi', 'Jeudi'],
  ),

  CategorieDePrixModel(
    id: '3',
    nom: 'Emporter',
    nomCourt: 'EM',
    status: true,
    afficherNomCourtEnCommande: true,
    afficherNomCourtEnEncaissement: false,
    afficherNomCourtEnFabrication: true,
    actifDansTouteLaJournee: false,
    categorieDePrixActive: true,
    salle: salles[1],
    heureDebut: TimeOfDay(hour: 17, minute: 0),
    heureFin: TimeOfDay(hour: 19, minute: 0),
    produits: [],
    joursDactivite: ['Lundi', 'Jeudi'],
  ),
];

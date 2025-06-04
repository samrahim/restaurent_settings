import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:restaurent/models/produits_model.dart';

class CategorieDePrixModel extends Equatable {
  final String id;
  final String nom;
  final String nomCourt;

  final bool status;
  final String afficherNomCourtEnCommande;
  final String afficherNomCourtEnEncaissement;
  final String afficherNomCourtEnFabrication;
  final bool actifDansTouteLaJournee;
  final bool actifDansTouteLaNuit;
  final List<String> joursDactivite;
  final String salle;
  final TimeOfDay heureDebut;
  final TimeOfDay heureFin;
  final List<ProduitsModel>? produits;

  const CategorieDePrixModel({
    required this.produits,
    required this.id,
    required this.nom,
    required this.nomCourt,
    required this.status,
    required this.afficherNomCourtEnCommande,
    required this.afficherNomCourtEnEncaissement,
    required this.afficherNomCourtEnFabrication,
    required this.actifDansTouteLaJournee,
    required this.actifDansTouteLaNuit,
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
    String? afficherNomCourtEnCommande,
    String? afficherNomCourtEnEncaissement,
    bool? actifDansTouteLaJournee,
    bool? actifDansTouteLaNuit,
    List<String>? joursDactivite,
    String? salle,
    TimeOfDay? heureDebut,
    TimeOfDay? heureFin,
    List<ProduitsModel>? produits,
    String? afficherNomCourtEnFabrication,
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
      actifDansTouteLaNuit: actifDansTouteLaNuit ?? this.actifDansTouteLaNuit,
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
    actifDansTouteLaNuit,
    joursDactivite,
    salle,
    heureDebut,
    heureFin,
    produits,
  ];
}

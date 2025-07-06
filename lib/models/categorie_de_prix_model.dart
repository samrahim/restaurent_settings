import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:restaurent/models/produits_model.dart';

class CategorieDePrixModel extends Equatable {
  final String? id;
  final String? nom;
  final String? nomCourt;
  final bool? actif;
  final bool? afficherNomCourtEnCommande;
  final bool? afficherNomCourtEnEncaissement;
  final bool? afficherNomCourtEnFabrication;
  final bool? actifDansTouteLaJournee;
  final bool? categorieDePrixActive;
  final List<String>? joursDactivite;
  final List<int>? salleIDS;
  final TimeOfDay? heureDebut;
  final TimeOfDay? heureFin;
  final int priorite;
  final List<int> produitsIds;
  final bool jourFerie;
  final bool? status;
  const CategorieDePrixModel({
    required this.id,
    required this.nom,
    required this.nomCourt,
    required this.actif,
    required this.afficherNomCourtEnCommande,
    required this.afficherNomCourtEnEncaissement,
    required this.afficherNomCourtEnFabrication,
    required this.actifDansTouteLaJournee,
    required this.categorieDePrixActive,
    required this.joursDactivite,
    required this.salleIDS,
    required this.heureDebut,
    required this.heureFin,
    required this.priorite,
    required this.produitsIds,
    required this.jourFerie,
    required this.status,
  });
  CategorieDePrixModel copyWith({
    String? id,
    String? nom,
    String? nomCourt,
    bool? actif,
    bool? afficherNomCourtEnCommande,
    bool? afficherNomCourtEnEncaissement,
    bool? actifDansTouteLaJournee,
    bool? actifDansTouteLaNuit,
    List<String>? joursDactivite,
    List<int>? salleIDS,
    TimeOfDay? heureDebut,
    TimeOfDay? heureFin,
    bool? categorieDePrixActive,
    bool? afficherNomCourtEnFabrication,
    int? priorite,
    List<int>? produitsIds,
    bool? jourFerie,
    bool? status,
  }) {
    return CategorieDePrixModel(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      nomCourt: nomCourt ?? this.nomCourt,
      actif: actif ?? this.actif,
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
      salleIDS: salleIDS ?? this.salleIDS,
      heureDebut: heureDebut ?? this.heureDebut,
      heureFin: heureFin ?? this.heureFin,
      priorite: priorite ?? this.priorite,
      produitsIds: produitsIds ?? this.produitsIds,
      jourFerie: jourFerie ?? this.jourFerie,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    id,
    nom,
    nomCourt,
    actif,
    afficherNomCourtEnCommande,
    afficherNomCourtEnEncaissement,
    afficherNomCourtEnFabrication,
    actifDansTouteLaJournee,
    categorieDePrixActive,
    joursDactivite,
    salleIDS,
    heureDebut,
    heureFin,
    produitsIds,
    priorite,
    jourFerie,
    status,
  ];
  CategorieDePrixModel fromJson(Map<String, dynamic> json) {
    return CategorieDePrixModel(
      id: json['id'] as String?,
      nom: json['nom'] as String?,
      nomCourt: json['nom_court'] as String?,
      actif: json['actif'] as bool?,
      afficherNomCourtEnCommande:
          json['afficher_nom_court_en_commande'] as bool?,
      afficherNomCourtEnEncaissement:
          json['afficher_nom_court_en_encaissement'] as bool?,
      afficherNomCourtEnFabrication:
          json['afficher_nom_court_en_fabrication'] as bool?,
      actifDansTouteLaJournee: json['actif_dans_toute_la_journee'] as bool?,
      categorieDePrixActive: json['categorie_de_prix_active'] as bool?,
      joursDactivite:
          (json['jours_dactivite'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList(),
      salleIDS:
          (json['salle_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      heureDebut:
          json['heureDebut'] != null
              ? TimeOfDay.fromDateTime(DateTime.parse(json['heure_debut']))
              : null,
      heureFin:
          json['heureFin'] != null
              ? TimeOfDay.fromDateTime(DateTime.parse(json['heure_fin']))
              : null,
      priorite: json['priorite'] as int? ?? 0,
      produitsIds:
          (json['produitsIds'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
      jourFerie: json['jourFerie'] as bool? ?? false,
      status: json['status'] as bool? ?? false,
    );
  }
}

List<CategorieDePrixModel> categoriesPrixList = [
  CategorieDePrixModel(
    id: '1',
    nom: 'Happy Hour',
    nomCourt: 'HH',
    actif: true,
    afficherNomCourtEnCommande: true,
    afficherNomCourtEnEncaissement: false,
    afficherNomCourtEnFabrication: true,
    actifDansTouteLaJournee: true,
    categorieDePrixActive: true,
    salleIDS: [1],
    heureDebut: null,
    heureFin: null,
    produitsIds: [],
    joursDactivite: ['Lundi', 'Mardi'],
    priorite: 12,
    jourFerie: false,
    status: true,
  ),
  CategorieDePrixModel(
    id: '2',
    nom: 'Terrasse',
    nomCourt: 'TR',
    actif: true,
    afficherNomCourtEnCommande: true,
    afficherNomCourtEnEncaissement: false,
    afficherNomCourtEnFabrication: true,
    actifDansTouteLaJournee: false,
    categorieDePrixActive: true,
    salleIDS: [2, 1],
    heureDebut: TimeOfDay(hour: 17, minute: 0),
    heureFin: TimeOfDay(hour: 19, minute: 0),
    produitsIds: [],
    joursDactivite: ['Lundi', 'Jeudi'],
    priorite: 10,
    status: true,
    jourFerie: false,
  ),

  CategorieDePrixModel(
    id: '3',
    nom: 'Emporter',
    nomCourt: 'EM',
    actif: true,
    afficherNomCourtEnCommande: true,
    afficherNomCourtEnEncaissement: false,
    afficherNomCourtEnFabrication: true,
    actifDansTouteLaJournee: false,
    categorieDePrixActive: true,
    salleIDS: [1],
    heureDebut: TimeOfDay(hour: 17, minute: 0),
    heureFin: TimeOfDay(hour: 19, minute: 0),
    produitsIds: [],
    joursDactivite: ['Lundi', 'Jeudi'],
    priorite: 20,
    jourFerie: false,
    status: true,
  ),
];

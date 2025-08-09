import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CategorieDePrixModel extends Equatable {
  final String? id;
  final String? nom;
  final String? nomCourt;
  final bool? status;
  final bool? afficherNomCourtEnCommande;
  final bool? afficherNomCourtEnEncaissement;
  final bool? afficherNomCourtEnFabrication;
  final bool? actifDansTouteLaJournee;

  final List<String>? joursDactivite;
  final List<int>? salleIDS;
  final TimeOfDay? heureDebut;
  final TimeOfDay? heureFin;
  final int priorite;
  final List<String>? produitsIds;
  final bool jourFerie;

  const CategorieDePrixModel({
    this.id,
    required this.nom,
    required this.nomCourt,
    required this.status,
    required this.afficherNomCourtEnCommande,
    required this.afficherNomCourtEnEncaissement,
    required this.afficherNomCourtEnFabrication,
    required this.actifDansTouteLaJournee,

    required this.joursDactivite,
    required this.salleIDS,
    required this.heureDebut,
    required this.heureFin,
    required this.priorite,
    required this.produitsIds,
    required this.jourFerie,
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
    List<int>? salleIDS,
    TimeOfDay? heureDebut,
    TimeOfDay? heureFin,

    bool? afficherNomCourtEnFabrication,
    int? priorite,
    List<String>? produitsIds,
    bool? jourFerie,
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

      joursDactivite: joursDactivite ?? this.joursDactivite,
      salleIDS: salleIDS ?? this.salleIDS,
      heureDebut: heureDebut ?? this.heureDebut,
      heureFin: heureFin ?? this.heureFin,
      priorite: priorite ?? this.priorite,
      produitsIds: produitsIds ?? this.produitsIds,
      jourFerie: jourFerie ?? this.jourFerie,
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

    joursDactivite,
    salleIDS,
    heureDebut,
    heureFin,
    produitsIds,
    priorite,
    jourFerie,
  ];
  factory CategorieDePrixModel.fromJson(Map<String, dynamic> json) {
    return CategorieDePrixModel(
      id: json['id'] as String?,
      nom: json['nom'] as String?,
      nomCourt: json['nomCourt'] as String?,
      status: json['status'] as bool?,
      afficherNomCourtEnCommande: json['afficherNomCourtCommande'] as bool?,
      afficherNomCourtEnEncaissement:
          json['afficherNomCourtEncaissement'] as bool?,
      afficherNomCourtEnFabrication:
          json['afficherNomCourtFabrication'] as bool?,
      actifDansTouteLaJournee: json['actifTouteJournee'] as bool?,

      joursDactivite:
          (json['joursActivite'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList(),
      salleIDS:
          (json['salleIds'] as List<dynamic>?)?.map((e) => e as int).toList(),
      heureDebut:
          json['heureDebut'] != null
              ? TimeOfDay(
                hour: int.parse(json['heureDebut'].split(':')[0]),
                minute: int.parse(json['heureDebut'].split(':')[1]),
              )
              : null,

      heureFin:
          json['heureFin'] != null
              ? TimeOfDay(
                hour: int.parse(json['heureFin'].split(':')[0]),
                minute: int.parse(json['heureFin'].split(':')[1]),
              )
              : null,
      priorite: json['priorite'] as int? ?? 0,
      produitsIds:
          (json['produits'] as List<dynamic>?)
              ?.map((e) => e['id'] as String)
              .toList() ??
          [],
      jourFerie: json['jourFerie'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson(CategorieDePrixModel model) {
    return {
      'nom': model.nom,
      'nomCourt': model.nomCourt,

      'afficherNomCourtCommande': model.afficherNomCourtEnCommande,
      'afficherNomCourtEncaissement': model.afficherNomCourtEnEncaissement,
      'afficherNomCourtFabrication': model.afficherNomCourtEnFabrication,
      'actifTouteJournee': model.actifDansTouteLaJournee,
      'joursActivite':
          model.joursDactivite?.map((e) => e.toUpperCase()).toList(),
      'heureDebut': model.heureDebut.toString(),
      'heureFin': model.heureFin.toString(),

      'salleIds': model.salleIDS,
      'produitIds': model.produitsIds,
      'status': model.status,
      'jourFerie': model.jourFerie,
    };
  }
}

// List<CategorieDePrixModel> categoriesPrixList = [
//   CategorieDePrixModel(
//     id: '1',
//     nom: 'Happy Hour',
//     nomCourt: 'HH',
//     status: true,
//     afficherNomCourtEnCommande: true,
//     afficherNomCourtEnEncaissement: false,
//     afficherNomCourtEnFabrication: true,
//     actifDansTouteLaJournee: true,

//     salleIDS: [1],
//     heureDebut: null,
//     heureFin: null,
//     produitsIds: [],
//     joursDactivite: ['Lundi', 'Mardi'],
//     priorite: 12,
//     jourFerie: false,
//   ),
//   CategorieDePrixModel(
//     id: '2',
//     nom: 'Terrasse',
//     nomCourt: 'TR',
//     status: true,
//     afficherNomCourtEnCommande: true,
//     afficherNomCourtEnEncaissement: false,
//     afficherNomCourtEnFabrication: true,
//     actifDansTouteLaJournee: false,

//     salleIDS: [2, 1],
//     heureDebut: TimeOfDay(hour: 17, minute: 0),
//     heureFin: TimeOfDay(hour: 19, minute: 0),
//     produitsIds: [],
//     joursDactivite: ['Lundi', 'Jeudi'],
//     priorite: 10,

//     jourFerie: false,
//   ),

//   CategorieDePrixModel(
//     id: '3',
//     nom: 'Emporter',
//     nomCourt: 'EM',
//     status: true,
//     afficherNomCourtEnCommande: true,
//     afficherNomCourtEnEncaissement: false,
//     afficherNomCourtEnFabrication: true,
//     actifDansTouteLaJournee: false,

//     salleIDS: [1],
//     heureDebut: TimeOfDay(hour: 17, minute: 0),
//     heureFin: TimeOfDay(hour: 19, minute: 0),
//     produitsIds: [],
//     joursDactivite: ['Lundi', 'Jeudi'],
//     priorite: 20,
//     jourFerie: false,
//   ),
// ];

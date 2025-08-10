import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:restaurent/consts.dart";

class CategorieDePrixModel extends Equatable {
  final String? id;
  final String? nom;
  final String? nomCourt;
  final bool? status;
  final bool? afficherNomCourtEnCommande;
  final bool? afficherNomCourtEnEncaissement;
  final bool? afficherNomCourtEnFabrication;
  final bool? actifDansTouteLaJournee;
  final bool? actif;
  final bool? categorieActive;
  final List<String>? joursDactivite;
  final List<int>? salleIDS;
  final TimeOfDay? heureDebut;
  final TimeOfDay? heureFin;
  final int priorite;
  final List<String>? produitsIds;
  final bool jourFerie;
  final AffectationMode? salleMode;
  final AffectationMode? produitMode;

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
    required this.salleMode,
    required this.produitMode,
    required this.actif,
    required this.categorieActive,
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
    AffectationMode? salleMode,
    AffectationMode? produitMode,
    bool? actif,
    bool? categorieActive,
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
      salleMode: salleMode ?? this.salleMode,
      produitMode: produitMode ?? this.produitMode,
      actif: actif ?? this.actif,
      categorieActive: categorieActive ?? this.categorieActive,
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
    salleMode,
    produitMode,
    actif,
    categorieActive,
  ];
  factory CategorieDePrixModel.fromJson(Map<String, dynamic> json) {
    return CategorieDePrixModel(
      id: json["id"] as String?,
      nom: json["nom"] as String?,
      nomCourt: json["nomCourt"] as String?,
      status: json["status"] as bool?,
      afficherNomCourtEnCommande: json["afficherNomCourtCommande"] as bool?,
      afficherNomCourtEnEncaissement:
          json["afficherNomCourtEncaissement"] as bool?,
      afficherNomCourtEnFabrication:
          json["afficherNomCourtFabrication"] as bool?,
      actifDansTouteLaJournee: json["actifTouteJournee"] as bool?,
      actif: json["actif"] as bool?,
      joursDactivite:
          (json["joursActivite"] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList(),
      salleIDS:
          (json["salles"] as List<dynamic>?)
              ?.map((e) => e["id"] as int)
              .toList() ??
          [],
      heureDebut:
          json["heureDebut"] != null
              ? TimeOfDay(
                hour: int.parse(json["heureDebut"].split(":")[0]),
                minute: int.parse(json["heureDebut"].split(":")[1]),
              )
              : null,
      heureFin:
          json["heureFin"] != null
              ? TimeOfDay(
                hour: int.parse(json["heureFin"].split(":")[0]),
                minute: int.parse(json["heureFin"].split(":")[1]),
              )
              : null,
      priorite: json["priorite"] as int? ?? 0,
      categorieActive: json["categorieActive"] as bool?,
      produitsIds:
          (json["produits"] as List<dynamic>?)
              ?.map((e) => e["id"] as String)
              .toList() ??
          [],
      jourFerie: json["jourFerie"] as bool? ?? false,
      produitMode: AffectationMode.values.firstWhere(
        (e) => e.name == json["produitMode"],
        orElse: () => AffectationMode.POUR_SEULEMENT,
      ),
      salleMode: AffectationMode.values.firstWhere(
        (e) => e.name == json["salleMode"],
        orElse: () => AffectationMode.POUR_SEULEMENT,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      "nom": nom,
      "nomCourt": nomCourt,
      "afficherNomCourtCommande": afficherNomCourtEnCommande,
      "afficherNomCourtEncaissement": afficherNomCourtEnEncaissement,
      "afficherNomCourtFabrication": afficherNomCourtEnFabrication,
      "actifTouteJournee": actifDansTouteLaJournee,
      "joursActivite":
          joursDactivite
              ?.where((e) => e != "" && e.trim().isNotEmpty)
              .map((e) => e.trim().toUpperCase())
              .toList(),
      "heureDebut":
          "${heureDebut?.hour == 0 ? "00" : heureDebut?.hour}:${heureDebut?.minute == 0 ? "00" : heureDebut?.minute}:00",
      "heureFin":
          "${heureFin?.hour == 0 ? "00" : heureFin?.hour}:${heureFin?.minute == 0 ? "00" : heureFin?.minute}:00",
      "salleIds": salleIDS,
      "produitIds": produitsIds,
      "status": status,
      "jourFerie": jourFerie,
      "priorite": priorite,
      "actif": actif,
      "categorieActive": categorieActive,
      "dateDebut": "2025-07-14",
      "dateFin": "2025-07-14",
      "salleMode": salleMode?.name ?? AffectationMode.POUR_SEULEMENT,
      "produitMode": produitMode?.name ?? AffectationMode.POUR_SEULEMENT,
    };

    map.removeWhere(
      (key, value) => value == null || (value is String && value.isEmpty),
    );
    return map;
  }
}

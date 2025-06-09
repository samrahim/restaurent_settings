part of 'categorie_de_prix_bloc.dart';

sealed class CategorieDePrixEvent extends Equatable {}

class CreateCategorieDePrix extends CategorieDePrixEvent {
  final CategorieDePrixModel categorieDePrixModel;
  CreateCategorieDePrix({required this.categorieDePrixModel});

  @override
  List<Object?> get props => [categorieDePrixModel];
}

class GetAllCategoriesDePrix extends CategorieDePrixEvent {
  final List<CategorieDePrixModel> categories;

  GetAllCategoriesDePrix({required this.categories});
  @override
  List<Object?> get props => [categories];
}

class ClearData extends CategorieDePrixEvent {
  @override
  List<Object?> get props => [];
}

class SelectCategoriDePrix extends CategorieDePrixEvent {
  final CategorieDePrixModel model;

  SelectCategoriDePrix({required this.model});

  @override
  List<Object?> get props => [];
}

class UpdateCategorieDePrix extends CategorieDePrixEvent {
  final String? nom;
  final String nomCourt;
  final bool? status;

  final bool? afficherNomCourtEnCommande;
  final bool? afficherNomCourtEnEncaissement;
  final bool? afficherNomCourtEnFabrication;
  final bool? actifDansTouteLaJournee;
  final bool? categorieDePrixActive;
  final List<String>? joursDactivite;
  final String? salle;
  final TimeOfDay? heureDebut;
  final TimeOfDay? heureFin;
  final List<ProduitsModel>? produits;

  UpdateCategorieDePrix({
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
    required this.produits,
  });
  @override
  List<Object?> get props => [
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

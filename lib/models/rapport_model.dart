import 'package:equatable/equatable.dart';

class RapportModel extends Equatable {
  final bool impresstionDesAnnulations;
  final bool impressionDuTop10Produits;
  final bool impressionDuTop10ProduitsEnValeur;
  final bool impressionDeTousLesProduits;
  final bool impressionDeTousLesProduitsEnValeur;
  final bool impressionDeTousLesProduitsParCategorie;
  final bool impressionDeTousLesProduitsParCategorieAvecDetails;
  final bool impressionDuCAParSalle;
  final bool impressionDuCAParServeur;
  final bool impressionDuMenuMoyen;
  final bool impressionDuFondDeCaisse;
  final bool informationDuTicketPanierMoyenGlobal;
  final bool informationDuTicketPanierMoyenParSalle;
  final bool informationDuTicketMoyenComptoirSurPlace;
  final bool informationDuTicketMoyenComptoirAEmporter;

  const RapportModel({
    required this.impresstionDesAnnulations,
    required this.impressionDuTop10Produits,
    required this.impressionDuTop10ProduitsEnValeur,
    required this.impressionDeTousLesProduits,
    required this.impressionDeTousLesProduitsEnValeur,
    required this.impressionDeTousLesProduitsParCategorie,
    required this.impressionDeTousLesProduitsParCategorieAvecDetails,
    required this.impressionDuCAParSalle,
    required this.impressionDuCAParServeur,
    required this.impressionDuMenuMoyen,
    required this.impressionDuFondDeCaisse,
    required this.informationDuTicketPanierMoyenGlobal,
    required this.informationDuTicketPanierMoyenParSalle,
    required this.informationDuTicketMoyenComptoirSurPlace,
    required this.informationDuTicketMoyenComptoirAEmporter,
  });

  RapportModel copyWith({
    bool? impresstionDesAnnulations,
    bool? impressionDuTop10Produits,
    bool? impressionDuTop10ProduitsEnValeur,
    bool? impressionDeTousLesProduits,
    bool? impressionDeTousLesProduitsEnValeur,
    bool? impressionDeTousLesProduitsParCategorie,
    bool? impressionDeTousLesProduitsParCategorieAvecDetails,
    bool? impressionDuCAParSalle,
    bool? impressionDuCAParServeur,
    bool? impressionDuMenuMoyen,
    bool? impressionDuFondDeCaisse,
    bool? informationDuTicketPanierMoyenGlobal,
    bool? informationDuTicketPanierMoyenParSalle,
    bool? informationDuTicketMoyenComptoirSurPlace,
    bool? informationDuTicketMoyenComptoirAEmporter,
  }) {
    return RapportModel(
      impresstionDesAnnulations:
          impresstionDesAnnulations ?? this.impresstionDesAnnulations,
      impressionDuTop10Produits:
          impressionDuTop10Produits ?? this.impressionDuTop10Produits,
      impressionDuTop10ProduitsEnValeur:
          impressionDuTop10ProduitsEnValeur ??
          this.impressionDuTop10ProduitsEnValeur,
      impressionDeTousLesProduits:
          impressionDeTousLesProduits ?? this.impressionDeTousLesProduits,
      impressionDeTousLesProduitsEnValeur:
          impressionDeTousLesProduitsEnValeur ??
          this.impressionDeTousLesProduitsEnValeur,
      impressionDeTousLesProduitsParCategorie:
          impressionDeTousLesProduitsParCategorie ??
          this.impressionDeTousLesProduitsParCategorie,
      impressionDeTousLesProduitsParCategorieAvecDetails:
          impressionDeTousLesProduitsParCategorieAvecDetails ??
          this.impressionDeTousLesProduitsParCategorieAvecDetails,
      impressionDuCAParSalle:
          impressionDuCAParSalle ?? this.impressionDuCAParSalle,
      impressionDuCAParServeur:
          impressionDuCAParServeur ?? this.impressionDuCAParServeur,
      impressionDuMenuMoyen:
          impressionDuMenuMoyen ?? this.impressionDuMenuMoyen,
      impressionDuFondDeCaisse:
          impressionDuFondDeCaisse ?? this.impressionDuFondDeCaisse,
      informationDuTicketPanierMoyenGlobal:
          informationDuTicketPanierMoyenGlobal ??
          this.informationDuTicketPanierMoyenGlobal,
      informationDuTicketPanierMoyenParSalle:
          informationDuTicketPanierMoyenParSalle ??
          this.informationDuTicketPanierMoyenParSalle,
      informationDuTicketMoyenComptoirSurPlace:
          informationDuTicketMoyenComptoirSurPlace ??
          this.informationDuTicketMoyenComptoirSurPlace,
      informationDuTicketMoyenComptoirAEmporter:
          informationDuTicketMoyenComptoirAEmporter ??
          this.informationDuTicketMoyenComptoirAEmporter,
    );
  }

  @override
  List<Object?> get props => [
    impressionDuCAParSalle,
    impressionDuCAParServeur,
    impressionDuMenuMoyen,
    impressionDuFondDeCaisse,
    informationDuTicketPanierMoyenGlobal,
    informationDuTicketPanierMoyenParSalle,
    informationDuTicketMoyenComptoirSurPlace,
    informationDuTicketMoyenComptoirAEmporter,
    impresstionDesAnnulations,
    impressionDuTop10Produits,
    impressionDuTop10ProduitsEnValeur,
    impressionDeTousLesProduits,
    impressionDeTousLesProduitsEnValeur,
    impressionDeTousLesProduitsParCategorie,
    impressionDeTousLesProduitsParCategorieAvecDetails,
  ];
}

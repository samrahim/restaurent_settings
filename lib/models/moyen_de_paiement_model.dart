import 'package:equatable/equatable.dart';

class MoyenDePaiementModel extends Equatable {
  final String? id;
  final String? nom;
  final String? icon;
  final String? modeEncaissement;
  final String? getsionDuTropPercu;
  final bool? ouvertureDeTiroirCaisse;
  final bool? disponibleEnModeExpress;
  final String? variationDuMoyenDePaiement;
  final bool? compterAlaFinDuService;
  final bool? rensignerleFondDeCaisee;
  final String? typeDeSalleDisponible;
  final bool? actif;

  const MoyenDePaiementModel({
    required this.id,
    required this.nom,
    required this.icon,
    required this.modeEncaissement,
    required this.getsionDuTropPercu,
    required this.ouvertureDeTiroirCaisse,
    required this.disponibleEnModeExpress,
    required this.variationDuMoyenDePaiement,
    required this.compterAlaFinDuService,
    required this.rensignerleFondDeCaisee,
    required this.typeDeSalleDisponible,
    required this.actif,
  });

  @override
  List<Object?> get props => [
    id,
    nom,
    icon,
    modeEncaissement,
    getsionDuTropPercu,
    ouvertureDeTiroirCaisse,
    disponibleEnModeExpress,
    variationDuMoyenDePaiement,
    compterAlaFinDuService,
    rensignerleFondDeCaisee,
    typeDeSalleDisponible,
    actif,
  ];
  MoyenDePaiementModel copyWith({
    String? nom,
    String? icon,
    String? id,
    String? modeEncaissement,
    String? getsionDuTropPercu,
    bool? ouvertureDeTiroirCaisse,
    bool? disponibleEnModeExpress,
    String? variationDuMoyenDePaiement,
    bool? compterAlaFinDuService,
    bool? rensignerleFondDeCaisee,
    String? typeDeSalleDisponible,
    bool? actif,
  }) {
    return MoyenDePaiementModel(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      icon: icon ?? this.icon,
      modeEncaissement: modeEncaissement ?? this.modeEncaissement,
      getsionDuTropPercu: getsionDuTropPercu ?? this.getsionDuTropPercu,
      ouvertureDeTiroirCaisse:
          ouvertureDeTiroirCaisse ?? this.ouvertureDeTiroirCaisse,
      disponibleEnModeExpress:
          disponibleEnModeExpress ?? this.disponibleEnModeExpress,
      variationDuMoyenDePaiement:
          variationDuMoyenDePaiement ?? this.variationDuMoyenDePaiement,
      compterAlaFinDuService:
          compterAlaFinDuService ?? this.compterAlaFinDuService,
      rensignerleFondDeCaisee:
          rensignerleFondDeCaisee ?? this.rensignerleFondDeCaisee,
      typeDeSalleDisponible:
          typeDeSalleDisponible ?? this.typeDeSalleDisponible,
      actif: actif ?? this.actif,
    );
  }
}

List<MoyenDePaiementModel> moyenPaiementList = [
  MoyenDePaiementModel(
    id: '1',
    nom: 'Carte de crédit',
    icon: null,
    modeEncaissement: 'Encaissement',
    getsionDuTropPercu: 'Gestion du trop perçu',
    ouvertureDeTiroirCaisse: true,
    disponibleEnModeExpress: true,
    variationDuMoyenDePaiement: 'Carte bancaire',
    compterAlaFinDuService: true,
    rensignerleFondDeCaisee: true,
    typeDeSalleDisponible: 'Toutes',
    actif: true,
  ),
  MoyenDePaiementModel(
    id: '2',
    nom: 'Espèces',
    icon: null,
    modeEncaissement: 'Encaissement',
    getsionDuTropPercu: 'Gestion du trop perçu',
    ouvertureDeTiroirCaisse: true,
    disponibleEnModeExpress: true,
    variationDuMoyenDePaiement: 'Espèces',
    compterAlaFinDuService: true,
    rensignerleFondDeCaisee: true,
    typeDeSalleDisponible: 'Toutes',
    actif: true,
  ),
  MoyenDePaiementModel(
    id: '3',
    nom: 'Ticket Restaurant',
    icon: null,
    modeEncaissement: 'Encaissement',
    getsionDuTropPercu: 'Gestion du trop perçu',
    ouvertureDeTiroirCaisse: true,
    disponibleEnModeExpress: true,
    variationDuMoyenDePaiement: 'Ticket restaurant',
    compterAlaFinDuService: true,
    rensignerleFondDeCaisee: true,
    typeDeSalleDisponible: 'Terrasse',
    actif: true,
  ),
];

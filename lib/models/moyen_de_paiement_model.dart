import 'package:equatable/equatable.dart';

class MoyenDePaiementModel extends Equatable {
  final int? id;
  final String? nom;
  final String? icon;
  final String? modeEncaissement;
  final String? getsionDuTropPercu;
  final bool? ouvertureDeTiroirCaisse;
  final bool? disponibleEnModeExpress;
  final String? variationDuMoyenDePaiement;
  final bool? compterAlaFinDuService;
  final bool? rensignerleFondDeCaisee;
  final List<int>? sallesIDS;
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
    required this.sallesIDS,
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
    sallesIDS,
    actif,
  ];
  MoyenDePaiementModel copyWith({
    String? nom,
    String? icon,
    int? id,
    String? modeEncaissement,
    String? getsionDuTropPercu,
    bool? ouvertureDeTiroirCaisse,
    bool? disponibleEnModeExpress,
    String? variationDuMoyenDePaiement,
    bool? compterAlaFinDuService,
    bool? rensignerleFondDeCaisee,
    List<int>? sallesIDS,
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
      sallesIDS: sallesIDS ?? this.sallesIDS,
      actif: actif ?? this.actif,
    );
  }

  factory MoyenDePaiementModel.fromJson(Map<String, dynamic> json) {
    return MoyenDePaiementModel(
      id: json['id'],
      nom: json['nom'],
      icon: json['icon'],
      modeEncaissement: json['modeEncaissement'],
      getsionDuTropPercu: json['getsionDuTropPercu'],
      ouvertureDeTiroirCaisse: json['ouvertureDeTiroirCaisse'],
      disponibleEnModeExpress: json['disponibleEnModeExpress'],
      variationDuMoyenDePaiement: json['variationDuMoyenDePaiement'],
      compterAlaFinDuService: json['compterAlaFinDuService'],
      rensignerleFondDeCaisee: json['rensignerleFondDeCaisee'],
      sallesIDS:
          (json['sallesIDS'] as List<dynamic>).map((e) => e as int).toList(),
      actif: json['actif'],
    );
  }
  Map<String, dynamic> toJson() {
    if (id == null) {
      return {
        "nom": nom,
        "icon": "icon",
        "modeEncaissement": modeEncaissement,
        "getsionDuTropPercu": getsionDuTropPercu,
        "ouvertureDeTiroirCaisse": ouvertureDeTiroirCaisse,
        "disponibleEnModeExpress": disponibleEnModeExpress,
        "variationDuMoyenDePaiement": variationDuMoyenDePaiement,
        "compterAlaFinDuService": compterAlaFinDuService,
        "rensignerleFondDeCaisee": rensignerleFondDeCaisee,
        "sallesIDS": sallesIDS,
        "actif": actif,
      };
    } else {
      return {
        "id": id,
        "nom": nom,
        "icon": icon,
        "modeEncaissement": modeEncaissement,
        "getsionDuTropPercu": getsionDuTropPercu,
        "ouvertureDeTiroirCaisse": ouvertureDeTiroirCaisse,
        "disponibleEnModeExpress": disponibleEnModeExpress,
        "variationDuMoyenDePaiement": variationDuMoyenDePaiement,
        "compterAlaFinDuService": compterAlaFinDuService,
        "rensignerleFondDeCaisee": rensignerleFondDeCaisee,
        "sallesIDS": sallesIDS,
        "actif": actif,
      };
    }
  }
}

List<MoyenDePaiementModel> moyenPaiementList = [
  MoyenDePaiementModel(
    id: 1,
    nom: 'Carte de crédit',
    icon: null,
    modeEncaissement: 'Calculatrice classique',
    getsionDuTropPercu: 'Gestion du trop perçu',
    ouvertureDeTiroirCaisse: true,
    disponibleEnModeExpress: true,
    variationDuMoyenDePaiement: 'Aucune',
    compterAlaFinDuService: true,
    rensignerleFondDeCaisee: true,
    sallesIDS: [2],
    actif: true,
  ),
  MoyenDePaiementModel(
    id: 2,
    nom: 'Espèces',
    icon: null,
    modeEncaissement: 'Calculatrice classique',
    getsionDuTropPercu: 'Gestion du trop perçu',
    ouvertureDeTiroirCaisse: true,
    disponibleEnModeExpress: true,
    variationDuMoyenDePaiement: 'Aucune',
    compterAlaFinDuService: true,
    rensignerleFondDeCaisee: true,
    sallesIDS: [1],
    actif: true,
  ),
  MoyenDePaiementModel(
    id: 3,
    nom: 'Ticket Restaurant',
    icon: null,
    modeEncaissement: 'Calculatrice classique',
    getsionDuTropPercu: 'Gestion du trop perçu',
    ouvertureDeTiroirCaisse: true,
    disponibleEnModeExpress: true,
    variationDuMoyenDePaiement: 'Aucune',
    compterAlaFinDuService: true,
    rensignerleFondDeCaisee: true,
    sallesIDS: [1],
    actif: true,
  ),
];

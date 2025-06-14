import 'package:equatable/equatable.dart';
import 'package:restaurent/consts.dart';

class UtilisateurModel extends Equatable {
  final String id;
  final String nom;
  final String prenom;
  final String groupe;
  final String motPasseSchema;
  final String motPasseChiffre;
  final String qrCode;
  final String role;
  const UtilisateurModel({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.groupe,
    required this.motPasseSchema,
    required this.motPasseChiffre,
    required this.qrCode,
    required this.role,
  });

  UtilisateurModel copyWith({
    String? id,
    String? nom,
    String? prenom,
    String? groupe,
    String? motPasseSchema,
    String? motPasseChiffre,
    String? qrCode,
    String? role,
  }) {
    return UtilisateurModel(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      groupe: groupe ?? this.groupe,
      motPasseSchema: motPasseSchema ?? this.motPasseSchema,
      motPasseChiffre: motPasseChiffre ?? this.motPasseChiffre,
      qrCode: qrCode ?? this.qrCode,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [
    id,
    nom,
    prenom,
    groupe,
    motPasseSchema,
    motPasseChiffre,
    qrCode,
    role,
  ];
}

List<String> groupeList = ['Groupe 1', 'Groupe 2', 'Groupe 3'];
List<UtilisateurModel> utilisateurList = [
  UtilisateurModel(
    id: '1',
    nom: 'John',
    prenom: 'Doe',
    groupe: 'Groupe 1',
    motPasseSchema: '123456',
    motPasseChiffre: '123456',
    qrCode: '123456',
    role: roleList[0],
  ),
  UtilisateurModel(
    id: '2',
    nom: 'Moussa',
    prenom: 'Moussa',
    groupe: 'Groupe 2',
    motPasseSchema: '123456',
    motPasseChiffre: '123456',
    qrCode: '123456',
    role: roleList[1],
  ),
  UtilisateurModel(
    id: '3',
    nom: 'karim',
    prenom: 'karim',
    groupe: 'Groupe 3',
    motPasseSchema: '123456',
    motPasseChiffre: '123456',
    qrCode: '123456',
    role: roleList[2],
  ),
];

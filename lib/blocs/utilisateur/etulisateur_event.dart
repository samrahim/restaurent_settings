part of 'etulisateur_bloc.dart';

sealed class UtilisateurEvent extends Equatable {}

class CreateUtilisateur extends UtilisateurEvent {
  final String nom;
  final String prenom;
  final String groupe;
  final String? motPasseSchema;
  final String? motPasseChiffre;
  final String? qrCode;
  final String role;
  CreateUtilisateur({
    required this.nom,
    required this.prenom,
    required this.groupe,
    required this.motPasseSchema,
    required this.motPasseChiffre,
    required this.qrCode,
    required this.role,
  });

  @override
  List<Object?> get props => [
    nom,
    prenom,
    groupe,
    motPasseSchema,
    motPasseChiffre,
    qrCode,
    role,
  ];
}

class UpdateUtilisateur extends UtilisateurEvent {
  final UtilisateurModel utilisateurModel;
  UpdateUtilisateur({required this.utilisateurModel});

  @override
  List<Object?> get props => [utilisateurModel];
}

class SelectUtilisateur extends UtilisateurEvent {
  final UtilisateurModel utilisateurModel;

  SelectUtilisateur({required this.utilisateurModel});

  @override
  List<Object> get props => [utilisateurModel];
}

class GetUtilisateurs extends UtilisateurEvent {
  final List<UtilisateurModel> utilisateurs;

  GetUtilisateurs({required this.utilisateurs});

  @override
  List<Object?> get props => [utilisateurs];
}

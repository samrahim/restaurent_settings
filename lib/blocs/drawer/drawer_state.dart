part of 'drawer_bloc.dart';

sealed class DrawerState extends Equatable {}

class DrawerInitial extends DrawerState {
  @override
  List<Object?> get props => [];
}

class DrawerCreateUtilisateur extends DrawerState {
  final bool isOpen;
  DrawerCreateUtilisateur({required this.isOpen});

  @override
  List<Object?> get props => [isOpen];
}

class DrawerCreatePaiementMethode extends DrawerState {
  final bool isOpen;
  DrawerCreatePaiementMethode({required this.isOpen});

  @override
  List<Object?> get props => [isOpen];
}

class DrawerUpdateUtilisateurState extends DrawerState {
  final UtilisateurModel utilisateur;
  DrawerUpdateUtilisateurState({required this.utilisateur});

  @override
  List<Object?> get props => [utilisateur];
}

class DrawerUpdatePaiementMethodeState extends DrawerState {
  final MoyenDePaiementModel paiementMethode;
  DrawerUpdatePaiementMethodeState({required this.paiementMethode});

  @override
  List<Object?> get props => [paiementMethode];
}

class DrawerCreateCategoriePrix extends DrawerState {
  @override
  List<Object?> get props => [];
}

class DrawerCreateTauxTva extends DrawerState {
  final bool isOpen;
  DrawerCreateTauxTva({required this.isOpen});

  @override
  List<Object?> get props => [isOpen];
}

class DrawerUpdateUtilisateurAttributeState extends DrawerState {
  final UtilisateurModel utilisateur;
  final String attributeName;
  final dynamic currentValue;

  DrawerUpdateUtilisateurAttributeState({
    required this.utilisateur,
    required this.attributeName,
    required this.currentValue,
  });

  @override
  List<Object?> get props => [utilisateur, attributeName, currentValue];
}

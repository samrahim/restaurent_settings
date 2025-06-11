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
  final MoyenDePaiementModel model;
  DrawerCreatePaiementMethode({required this.model});

  @override
  List<Object?> get props => [model];
}

class DrawerUpdateUtilisateurState extends DrawerState {
  final UtilisateurModel utilisateur;
  DrawerUpdateUtilisateurState({required this.utilisateur});

  @override
  List<Object?> get props => [utilisateur];
}

class DrawerCreateCategoriePrix extends DrawerState {
  final CategorieDePrixModel model;

  DrawerCreateCategoriePrix({required this.model});
  @override
  List<Object?> get props => [model];
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

class DrawerDeAttacheProduitsToCategorie extends DrawerState {
  final List<ProduitsModel> produits;

  DrawerDeAttacheProduitsToCategorie({required this.produits});
  @override
  List<Object?> get props => [produits];
}

class DrawerUpdateMoyenDePaiement extends DrawerState {
  final MoyenDePaiementModel model;
  final String attributeName;
  final dynamic currentValue;

  DrawerUpdateMoyenDePaiement({
    required this.model,
    required this.attributeName,
    required this.currentValue,
  });

  @override
  List<Object?> get props => [model, attributeName, currentValue];
}

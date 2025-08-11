import 'package:equatable/equatable.dart';
import 'package:restaurent/models/models.dart';

class DrawerCreateImprimant extends DrawerState {
  @override
  List<Object?> get props => [];
}

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

class DrawerCreateCategorieDeModificateur extends DrawerState {
  final CategorieDeModificateur modificateur;

  DrawerCreateCategorieDeModificateur({required this.modificateur});
  @override
  List<Object?> get props => [modificateur];
}

class DrawerUpdateCategorieDeModificateur extends DrawerState {
  final CategorieDeModificateur modificateur;
  final String attributeName;
  final dynamic currentValue;

  DrawerUpdateCategorieDeModificateur({
    required this.modificateur,
    required this.attributeName,
    required this.currentValue,
  });
  @override
  List<Object?> get props => [modificateur, attributeName, currentValue];
}

class DrawerUpdateCategoriDePrix extends DrawerState {
  final CategorieDePrixModel model;
  final String attributeName;
  final dynamic currentValue;

  DrawerUpdateCategoriDePrix({
    required this.model,
    required this.attributeName,
    required this.currentValue,
  });
  @override
  List<Object?> get props => [model, attributeName, currentValue];
}

class DrawerCreateSubCategorieDeModificateur extends DrawerState {
  final CategorieDeModificateur modificateur;

  DrawerCreateSubCategorieDeModificateur({required this.modificateur});

  @override
  List<Object?> get props => [modificateur];
}

class UpdateProdsScreenModificateur extends DrawerState {
  final CategorieDeModificateur modificateur;

  UpdateProdsScreenModificateur({required this.modificateur});
  @override
  List<Object?> get props => [];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:restaurent/models/models.dart';

class DrawerProvider with ChangeNotifier {
  DrawerState _state = DrawerInitial();

  DrawerState get state => _state;

  void openCreateUtilisateurDrawer() {
    _state = DrawerCreateUtilisateur(isOpen: true);
    notifyListeners();
  }

  void openCreatePaiementMethodeDrawer(MoyenDePaiementModel model) {
    _state = DrawerCreatePaiementMethode(model: model);
    notifyListeners();
  }

  void openUpdateUtilisateurAttributeDrawer(
    UtilisateurModel utilisateur,
    String attributeName,
    dynamic currentValue,
  ) {
    _state = DrawerUpdateUtilisateurAttributeState(
      utilisateur: utilisateur,
      attributeName: attributeName,
      currentValue: currentValue,
    );
    notifyListeners();
  }

  void openUpdatePaiementMethodeDrawer(
    MoyenDePaiementModel model,
    String attributeName,
    dynamic currentValue,
  ) {
    _state = DrawerUpdateMoyenDePaiement(
      model: model,
      attributeName: attributeName,
      currentValue: currentValue,
    );
    notifyListeners();
  }

  void openCreateCategoriePrixDrawer(CategorieDePrixModel model) {
    _state = DrawerCreateCategoriePrix(model: model);
    notifyListeners();
  }

  void updateCreateCategoriePrixModel(CategorieDePrixModel model) {
    _state = DrawerCreateCategoriePrix(model: model);
    notifyListeners();
  }

  void openCreateTauxTvaDrawer() {
    _state = DrawerCreateTauxTva(isOpen: true);
    notifyListeners();
  }

  void openProduitsAttachementDrawer(String categorieId) {
    _state = DrawerDeAttacheProduitsToCategorie(produits: []);
    notifyListeners();
  }

  void openCreateCategorieDeModificateur(CategorieDeModificateur modificateur) {
    _state = DrawerCreateCategorieDeModificateur(modificateur: modificateur);
    notifyListeners();
  }

  void openUpdateCategorieDeModificateur(
    CategorieDeModificateur modificateur,
    String attributeName,
    dynamic currentValue,
  ) {
    _state = DrawerUpdateCategorieDeModificateur(
      modificateur: modificateur,
      attributeName: attributeName,
      currentValue: currentValue,
    );
    notifyListeners();
  }

  void openUpdateCategorieDePrixAttributs(
    CategorieDePrixModel model,
    String attributeName,
    dynamic currentValue,
  ) {
    _state = DrawerUpdateCategoriDePrix(
      model: model,
      attributeName: attributeName,
      currentValue: currentValue,
    );
    notifyListeners();
  }

  void openCreateSubCategorieDeModificateur(
    CategorieDeModificateur modificateur,
  ) {
    _state = DrawerCreateSubCategorieDeModificateur(modificateur: modificateur);
    notifyListeners();
  }

  void resetDrawer() {
    _state = DrawerInitial();
    notifyListeners();
  }

  void openCreateImprimantDrawer() {
    _state = DrawerCreateImprimant();
    notifyListeners();
  }
}

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

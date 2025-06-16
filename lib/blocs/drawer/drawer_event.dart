part of 'drawer_bloc.dart';

sealed class DrawerEvent extends Equatable {}

class OpenCreateUtilisateurDrawer extends DrawerEvent {
  @override
  List<Object?> get props => [];
}

class OpenCreatePaiementMethodeDrawer extends DrawerEvent {
  final MoyenDePaiementModel model;
  OpenCreatePaiementMethodeDrawer({required this.model});
  @override
  List<Object?> get props => [model];
}

class OpenUpdateUtilisateurDrawer extends DrawerEvent {
  final UtilisateurModel utilisateur;
  OpenUpdateUtilisateurDrawer({required this.utilisateur});

  @override
  List<Object?> get props => [utilisateur];
}

class OpenUpdatePaiementMethodeDrawer extends DrawerEvent {
  final MoyenDePaiementModel model;
  final String attributeName;
  final dynamic currentValue;

  OpenUpdatePaiementMethodeDrawer({
    required this.model,
    required this.attributeName,
    required this.currentValue,
  });

  @override
  List<Object?> get props => [model, attributeName, currentValue];
}

class OpenCreateCategoriePrixDrawer extends DrawerEvent {
  final CategorieDePrixModel model;

  OpenCreateCategoriePrixDrawer({required this.model});
  @override
  List<Object?> get props => [model];
}

class UpdateCreateCategoriePrixModel extends DrawerEvent {
  final CategorieDePrixModel model;
  UpdateCreateCategoriePrixModel(this.model);

  @override
  List<Object?> get props => [model];
}

class OpenCreateTauxTvaDrawer extends DrawerEvent {
  @override
  List<Object?> get props => [];
}

class OpenUpdateUtilisateurAttributeDrawer extends DrawerEvent {
  final UtilisateurModel utilisateur;
  final String attributeName;
  final dynamic currentValue;

  OpenUpdateUtilisateurAttributeDrawer({
    required this.utilisateur,
    required this.attributeName,
    required this.currentValue,
  });

  @override
  List<Object?> get props => [utilisateur, attributeName, currentValue];
}

class OpenProduitsAttachementDrawer extends DrawerEvent {
  final String categorieId;

  OpenProduitsAttachementDrawer({required this.categorieId});

  @override
  List<Object?> get props => [categorieId];
}

class OpenCreateCategorieDeModificateur extends DrawerEvent {
  final CategorieDeModificateur modificateur;

  OpenCreateCategorieDeModificateur({required this.modificateur});
  @override
  List<Object?> get props => [modificateur];
}

class OpenUpdateCategorieDeModificateur extends DrawerEvent {
  final CategorieDeModificateur modificateur;
  final String attributeName;
  final dynamic currentValue;

  OpenUpdateCategorieDeModificateur({
    required this.modificateur,
    required this.attributeName,
    required this.currentValue,
  });
  @override
  List<Object?> get props => [modificateur, attributeName, currentValue];
}

class OpenUpdateCategrieDePrixAttributs extends DrawerEvent {
  final CategorieDePrixModel model;
  final String attributeName;
  final dynamic currentValue;

  OpenUpdateCategrieDePrixAttributs({
    required this.model,
    required this.attributeName,
    required this.currentValue,
  });

  @override
  List<Object?> get props => [model, attributeName, currentValue];
}

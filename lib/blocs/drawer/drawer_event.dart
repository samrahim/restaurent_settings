part of 'drawer_bloc.dart';

sealed class DrawerEvent extends Equatable {}

class OpenCreateUtilisateurDrawer extends DrawerEvent {
  @override
  List<Object?> get props => [];
}

class CloseCreateUtilisateurDrawer extends DrawerEvent {
  @override
  List<Object?> get props => [];
}

class OpenCreatePaiementMethodeDrawer extends DrawerEvent {
  @override
  List<Object?> get props => [];
}

class CloseCreatePaiementMethodeDrawer extends DrawerEvent {
  @override
  List<Object?> get props => [];
}

class OpenUpdateUtilisateurDrawer extends DrawerEvent {
  final UtilisateurModel utilisateur;
  OpenUpdateUtilisateurDrawer({required this.utilisateur});

  @override
  List<Object?> get props => [utilisateur];
}

class OpenUpdatePaiementMethodeDrawer extends DrawerEvent {
  final MoyenDePaiementModel paiementMethode;
  OpenUpdatePaiementMethodeDrawer({required this.paiementMethode});

  @override
  List<Object?> get props => [paiementMethode];
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

class CloseCreateTauxTvaDrawer extends DrawerEvent {
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

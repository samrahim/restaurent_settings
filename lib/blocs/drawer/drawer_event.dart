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
  @override
  List<Object?> get props => [];
}

class CloseCreateCategoriePrixDrawer extends DrawerEvent {
  @override
  List<Object?> get props => [];
}

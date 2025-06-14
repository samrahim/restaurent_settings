part of 'categorie_modificateur_bloc.dart';

sealed class CategorieModificateurEvent extends Equatable {}

class CreateNewCategorieDeModificateur extends CategorieModificateurEvent {
  final CategorieDeModificateur modificateur;

  CreateNewCategorieDeModificateur({required this.modificateur});
  @override
  List<Object?> get props => [modificateur];
}

class SelectCategorie extends CategorieModificateurEvent {
  final CategorieDeModificateur modificateur;

  SelectCategorie({required this.modificateur});

  @override
  List<Object?> get props => [modificateur];
}

class DeselectCategorie extends CategorieModificateurEvent {
  @override
  List<Object?> get props => [];
}

class UpdateCategorieDeModificateur extends CategorieModificateurEvent {
  final CategorieDeModificateur modificateur;
  UpdateCategorieDeModificateur({required this.modificateur});

  @override
  List<Object?> get props => [modificateur];
}

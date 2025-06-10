part of 'categorie_de_prix_bloc.dart';

sealed class CategorieDePrixEvent extends Equatable {}

class CreateCategorieDePrix extends CategorieDePrixEvent {
  final CategorieDePrixModel categorieDePrixModel;
  CreateCategorieDePrix({required this.categorieDePrixModel});

  @override
  List<Object?> get props => [categorieDePrixModel];
}

class GetAllCategoriesDePrix extends CategorieDePrixEvent {
  final List<CategorieDePrixModel> categories;

  GetAllCategoriesDePrix({required this.categories});
  @override
  List<Object?> get props => [categories];
}

class ClearData extends CategorieDePrixEvent {
  @override
  List<Object?> get props => [];
}

class SelectCategoriDePrix extends CategorieDePrixEvent {
  final CategorieDePrixModel model;

  SelectCategoriDePrix({required this.model});

  @override
  List<Object?> get props => [];
}

class UpdateCategorieDePrix extends CategorieDePrixEvent {
  final CategorieDePrixModel model;

  UpdateCategorieDePrix({required this.model});
  @override
  List<Object?> get props => [model];
}

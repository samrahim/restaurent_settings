part of 'categorie_de_prix_bloc.dart';

sealed class CategorieDePrixState extends Equatable {}

class CategorieDePrixInitial extends CategorieDePrixState {
  final CategorieDePrixModel? selectedCategorie;
  final List<CategorieDePrixModel> categories;

  CategorieDePrixInitial({this.selectedCategorie, required this.categories});

  @override
  List<Object?> get props => [selectedCategorie, categories];

  CategorieDePrixInitial copyWith({
    CategorieDePrixModel? selectedCategorie,
    List<CategorieDePrixModel>? categories,
  }) {
    return CategorieDePrixInitial(
      selectedCategorie: selectedCategorie,
      categories: categories ?? this.categories,
    );
  }
}

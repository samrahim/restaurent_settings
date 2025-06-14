part of 'categorie_modificateur_bloc.dart';

sealed class CategorieModificateurState extends Equatable {}

class CategorieModificateurInitial extends CategorieModificateurState {
  final List<CategorieDeModificateur> allcategories;
  final CategorieDeModificateur? selectedCategorie;

  CategorieModificateurInitial({
    required this.allcategories,
    required this.selectedCategorie,
  });

  @override
  List<Object?> get props => [allcategories, selectedCategorie];
  CategorieModificateurInitial copyWith({
    List<CategorieDeModificateur>? allcategories,
    CategorieDeModificateur? selectedCategorie,
  }) {
    return CategorieModificateurInitial(
      allcategories: allcategories ?? this.allcategories,
      selectedCategorie: selectedCategorie,
    );
  }
}

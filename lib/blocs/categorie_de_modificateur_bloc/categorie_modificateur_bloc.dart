import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurent/models/categorie_de_modificateur.dart';

part 'categorie_modificateur_event.dart';
part 'categorie_modificateur_state.dart';

class CategorieModificateurBloc
    extends Bloc<CategorieModificateurEvent, CategorieModificateurState> {
  CategorieModificateurBloc()
    : super(
        CategorieModificateurInitial(
          allcategories: categoriesdemodificateursList,
          selectedCategorie: null,
        ),
      ) {
    on<CategorieModificateurEvent>((event, emit) {
      if (event is CreateNewCategorieDeModificateur) {
        emit(
          (state as CategorieModificateurInitial).copyWith(
            allcategories: [
              ...categoriesdemodificateursList,
              event.modificateur,
            ],
          ),
        );
      }

      if (event is SelectCategorie) {
        emit(
          (state as CategorieModificateurInitial).copyWith(
            selectedCategorie: event.modificateur,
          ),
        );
      }
      if (event is DeselectCategorie) {
        emit(
          (state as CategorieModificateurInitial).copyWith(
            selectedCategorie: null,
          ),
        );
      }
      if (event is UpdateCategorieDeModificateur) {
        emit(
          (state as CategorieModificateurInitial).copyWith(
            selectedCategorie: event.modificateur,
          ),
        );
      }
    });
  }
}

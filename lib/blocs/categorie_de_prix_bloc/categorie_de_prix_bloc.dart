import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:restaurent/models/categorie_de_prix_model.dart';
import 'package:restaurent/models/produits_model.dart';

part 'categorie_de_prix_event.dart';
part 'categorie_de_prix_state.dart';

class CategorieDePrixBloc
    extends Bloc<CategorieDePrixEvent, CategorieDePrixState> {
  CategorieDePrixBloc()
    : super(
        CategorieDePrixInitial(
          selectedCategorie: null,
          categories: categoriesPrix,
        ),
      ) {
    on<CategorieDePrixEvent>((event, emit) {
      if (event is SelectCategoriDePrix) {
        emit(
          (state as CategorieDePrixInitial).copyWith(
            selectedCategorie: event.model,
          ),
        );
      }
      if (event is ClearData) {
        emit(
          (state as CategorieDePrixInitial).copyWith(selectedCategorie: null),
        );
      }
      if (event is CreateCategorieDePrix) {
        emit(
          (state as CategorieDePrixInitial).copyWith(
            categories: [...categoriesPrix, event.categorieDePrixModel],
          ),
        );
      }
    });
  }
}

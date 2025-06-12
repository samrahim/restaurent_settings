import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'categorie_modificateur_event.dart';
part 'categorie_modificateur_state.dart';

class CategorieModificateurBloc extends Bloc<CategorieModificateurEvent, CategorieModificateurState> {
  CategorieModificateurBloc() : super(CategorieModificateurInitial()) {
    on<CategorieModificateurEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

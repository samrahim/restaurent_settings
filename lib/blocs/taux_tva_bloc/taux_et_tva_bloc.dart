import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurent/models/taux_tva_model.dart';

part 'taux_et_tva_event.dart';
part 'taux_et_tva_state.dart';

class TauxEtTvaBloc extends Bloc<TauxEtTvaEvent, TauxEtTvaState> {
  TauxEtTvaBloc()
    : super(
        TauxEtTvaInitial(
          tauxTvas: tauxTvaList,
          selectedTauxTva: tauxTvaList.first,
        ),
      ) {
    on<TauxEtTvaEvent>((event, emit) {
      if (event is CreatTauxTva) {
        final TauxTvaModel newTauxTva = TauxTvaModel(
          id: '${(state as TauxEtTvaInitial).tauxTvas!.length + 1}',
          tauxTva: event.tauxTva,
          elementsInclus: event.elementsInclus,
        );
        emit(
          (state as TauxEtTvaInitial).copyWith(
            tauxTvas: [...(state as TauxEtTvaInitial).tauxTvas!, newTauxTva],
            selectedTauxTva: newTauxTva,
          ),
        );
      }
      if (event is UpdateTauxTva) {
        final updatedTauxTva = event.tauxTvaModel;

        final updatedList =
            (state as TauxEtTvaInitial).tauxTvas!
                .map((u) => u.id == updatedTauxTva.id ? updatedTauxTva : u)
                .toList();

        final updatedSelected = updatedTauxTva;

        emit(
          (state as TauxEtTvaInitial).copyWith(
            tauxTvas: updatedList,
            selectedTauxTva: updatedSelected,
          ),
        );
      }
    });
  }
}

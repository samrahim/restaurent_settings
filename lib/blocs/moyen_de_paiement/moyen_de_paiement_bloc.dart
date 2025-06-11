import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurent/models/moyen_de_paiement_model.dart';

part 'moyen_de_paiement_event.dart';
part 'moyen_de_paiement_state.dart';

class MoyenDePaiementBloc
    extends Bloc<MoyenDePaiementEvent, MoyenDePaiementState> {
  MoyenDePaiementBloc()
    : super(
        MoyenDePaiementInitial(
          moyenDePaiement: moyenPaiementList,
          selectedModel: moyenPaiementList.first,
        ),
      ) {
    on<MoyenDePaiementEvent>((event, emit) {
      if (event is SelectMoyenDePaiement) {
        emit(
          (state as MoyenDePaiementInitial).copyWith(
            selectedModel: event.moyenDePaiement,
          ),
        );
      }
      if (event is UpdateMoyenDePaiementEvent) {
        emit(
          (state as MoyenDePaiementInitial).copyWith(
            selectedModel: event.moyenDePaiement,
          ),
        );
      }
      if (event is CreateMoyenDePaiementEvent) {
        emit(
          (state as MoyenDePaiementInitial).copyWith(
            moyenDePaiement: List.from(
              (state as MoyenDePaiementInitial).moyenDePaiement,
            )..add(
              event.model.copyWith(id: moyenPaiementList.length.toString()),
            ),
          ),
        );
      }
    });
  }
}

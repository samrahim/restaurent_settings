import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurent/models/utilisateur_model.dart';

part 'etulisateur_event.dart';
part 'etulisateur_state.dart';

class UtilisateurBloc extends Bloc<UtilisateurEvent, UtilisateurState> {
  UtilisateurBloc()
    : super(
        UtilisateurInitial(
          utilisateurs: utilisateurList,
          selectedEtulisateur: utilisateurList.first,
        ),
      ) {
    on<UtilisateurEvent>((event, emit) {
      if (event is CreateUtilisateur) {
        UtilisateurModel utilisateur = UtilisateurModel(
          id: '${utilisateurList.length + 1}',
          nom: event.nom,
          prenom: event.prenom,
          groupe: event.groupe,
          motPasseSchema: event.motPasseSchema ?? '',
          motPasseChiffre: event.motPasseChiffre ?? '',
          qrCode: event.qrCode ?? '',
          role: event.role,
        );
        emit(
          (state as UtilisateurInitial).copyWith(
            utilisateursList: [...utilisateurList, utilisateur],
            selectedUtilisateurItem:
                (state as UtilisateurInitial).selectedEtulisateur,
          ),
        );
      }

      if (event is SelectUtilisateur) {
        emit(
          (state as UtilisateurInitial).copyWith(
            selectedUtilisateurItem: event.utilisateurModel,
          ),
        );
      }
      if (event is UpdateUtilisateur) {
        final updatedUser = event.utilisateurModel;

        final updatedList =
            (state as UtilisateurInitial).utilisateurs!
                .map((u) => u.id == updatedUser.id ? updatedUser : u)
                .toList();

        final updatedSelected = updatedUser;

        emit(
          (state as UtilisateurInitial).copyWith(
            utilisateursList: updatedList,
            selectedUtilisateurItem: updatedSelected,
          ),
        );
      }
    });
  }
}

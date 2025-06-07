import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurent/models/moyen_de_paiement_model.dart';
import 'package:restaurent/models/utilisateur_model.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  DrawerBloc() : super(DrawerInitial()) {
    on<DrawerEvent>((event, emit) {
      if (event is OpenCreateUtilisateurDrawer) {
        emit(DrawerCreateUtilisateur(isOpen: true));
      }
      if (event is CloseCreateUtilisateurDrawer) {
        emit(DrawerCreateUtilisateur(isOpen: false));
      }
      if (event is OpenCreatePaiementMethodeDrawer) {
        emit(DrawerCreatePaiementMethode(isOpen: true));
      }
      if (event is CloseCreatePaiementMethodeDrawer) {
        emit(DrawerCreatePaiementMethode(isOpen: false));
      }
      if (event is OpenUpdateUtilisateurDrawer) {
        emit(DrawerUpdateUtilisateurState(utilisateur: event.utilisateur));
      }
      if (event is OpenUpdatePaiementMethodeDrawer) {
        emit(
          DrawerUpdatePaiementMethodeState(
            paiementMethode: event.paiementMethode,
          ),
        );
      }
      if (event is OpenCreateCategoriePrixDrawer) {
        emit(DrawerCreateCategoriePrix(isOpen: true));
      }
      if (event is CloseCreateCategoriePrixDrawer) {
        emit(DrawerCreateCategoriePrix(isOpen: false));
      }
    });
  }
}

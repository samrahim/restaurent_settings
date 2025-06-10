import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurent/blocs/categorie_de_prix_bloc/categorie_de_prix_bloc.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/categorie_de_prix_model.dart';
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
      if (event is OpenUpdateUtilisateurAttributeDrawer) {
        emit(
          DrawerUpdateUtilisateurAttributeState(
            utilisateur: event.utilisateur,
            attributeName: event.attributeName,
            currentValue: event.currentValue,
          ),
        );
      }
      if (event is OpenUpdatePaiementMethodeDrawer) {
        emit(
          DrawerUpdatePaiementMethodeState(
            paiementMethode: event.paiementMethode,
          ),
        );
      }

      if (event is OpenCreateCategoriePrixDrawer) {
        emit(DrawerCreateCategoriePrix(model: event.model));
      }

      if (event is OpenCreateTauxTvaDrawer) {
        emit(DrawerCreateTauxTva(isOpen: true));
      }
      if (event is CloseCreateTauxTvaDrawer) {
        emit(DrawerCreateTauxTva(isOpen: false));
      }
      if (event is UpdateCreateCategoriePrixModel) {
        emit(DrawerCreateCategoriePrix(model: event.model));
      }
    });
  }
}

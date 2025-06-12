import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurent/models/categorie_de_modificateur.dart';
import 'package:restaurent/models/models.dart';

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
        emit(DrawerCreatePaiementMethode(model: event.model));
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
          DrawerUpdateMoyenDePaiement(
            model: event.model,
            attributeName: event.attributeName,
            currentValue: event.currentValue,
          ),
        );
      }

      if (event is OpenCreateCategoriePrixDrawer) {
        emit(DrawerCreateCategoriePrix(model: event.model));
      }

      if (event is OpenCreateTauxTvaDrawer) {
        emit(DrawerCreateTauxTva(isOpen: true));
      }

      if (event is UpdateCreateCategoriePrixModel) {
        emit(DrawerCreateCategoriePrix(model: event.model));
      }
      if (event is OpenProduitsAttachementDrawer) {
        emit(DrawerDeAttacheProduitsToCategorie(produits: []));
      }
      if (event is OpenCreateCategorieDeModificateur) {
        emit(
          DrawerCreateCategorieDeModificateur(modificateur: event.modificateur),
        );
      }
    });
  }
}

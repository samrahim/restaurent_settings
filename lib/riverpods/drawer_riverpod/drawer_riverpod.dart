import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/models/models.dart';
import 'package:restaurent/riverpods/drawer_riverpod/drawer_state.dart';

class DrawerNotifier extends StateNotifier<DrawerState> {
  DrawerNotifier() : super(DrawerInitial());

  void openCreateUtilisateurDrawer() {
    state = DrawerCreateUtilisateur(isOpen: true);
  }

  void openCreatePaiementMethodeDrawer(MoyenDePaiementModel model) {
    state = DrawerCreatePaiementMethode(model: model);
  }

  void openUpdateUtilisateurAttributeDrawer(
    UtilisateurModel utilisateur,
    String attributeName,
    dynamic currentValue,
  ) {
    state = DrawerUpdateUtilisateurAttributeState(
      utilisateur: utilisateur,
      attributeName: attributeName,
      currentValue: currentValue,
    );
  }

  void openUpdatePaiementMethodeDrawer(
    MoyenDePaiementModel model,
    String attributeName,
    dynamic currentValue,
  ) {
    state = DrawerUpdateMoyenDePaiement(
      model: model,
      attributeName: attributeName,
      currentValue: currentValue,
    );
  }

  void openCreateCategoriePrixDrawer(CategorieDePrixModel model) {
    state = DrawerCreateCategoriePrix(model: model);
  }

  void updateCreateCategoriePrixModel(CategorieDePrixModel model) {
    state = DrawerCreateCategoriePrix(model: model);
  }

  void openCreateTauxTvaDrawer() {
    state = DrawerCreateTauxTva(isOpen: true);
  }

  void openProduitsAttachementDrawer(String categorieId) {
    state = DrawerDeAttacheProduitsToCategorie(produits: []);
  }

  void openCreateCategorieDeModificateur(CategorieDeModificateur modificateur) {
    state = DrawerCreateCategorieDeModificateur(modificateur: modificateur);
  }

  void openUpdateCategorieDeModificateur(
    CategorieDeModificateur modificateur,
    String attributeName,
    dynamic currentValue,
  ) {
    state = DrawerUpdateCategorieDeModificateur(
      modificateur: modificateur,
      attributeName: attributeName,
      currentValue: currentValue,
    );
  }

  void openUpdateCategorieDePrixAttributs(
    CategorieDePrixModel model,
    String attributeName,
    dynamic currentValue,
  ) {
    state = DrawerUpdateCategoriDePrix(
      model: model,
      attributeName: attributeName,
      currentValue: currentValue,
    );
  }

  void openCreateSubCategorieDeModificateur(
    CategorieDeModificateur modificateur,
  ) {
    state = DrawerCreateSubCategorieDeModificateur(modificateur: modificateur);
  }

  void openCreateImprimantDrawer() {
    state = DrawerCreateImprimant();
  }

  void resetDrawer() {
    state = DrawerInitial();
  }
}

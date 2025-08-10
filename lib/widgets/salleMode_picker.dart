import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/categorie_de_modificateur.dart';
import 'package:restaurent/models/categorie_de_prix_model.dart';
import 'package:restaurent/screens/reglage_screen.dart';
import 'package:restaurent/screens/settings/carte/categorie_de_modificateur/modificateurs_supplements_screen.dart';

Widget buildSalleModeDropdown(
  CategorieDeModificateur? createModel,
  CategorieDePrixModel? createcategorieDePrix,
  BuildContext context,
) {
  return CustomContainer(
    child: DropdownButtonFormField<AffectationMode>(
      value:
          createModel != null
              ? createModel.salleMode
              : createcategorieDePrix != null
              ? createcategorieDePrix.salleMode
              : AffectationMode.POUR_SEULEMENT,
      decoration: const InputDecoration(
        labelText: 'Affectation mode',
        border: InputBorder.none,
      ),
      items:
          AffectationMode.values
              .where((v) => v != AffectationMode.AJOUTER_A_LIST_EXSISTANTE)
              .map(
                (v) => DropdownMenuItem(
                  value: v,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      v.name.replaceAll("_", " "),
                      style: AppTextStyle.indingosubHeading,
                    ),
                  ),
                ),
              )
              .toList(),
      onChanged: (v) {
        if (v != null) {
          if (createModel != null) {
            final updated = createModel.copyWith(salleMode: v);
            final container = ProviderScope.containerOf(context);
            container
                .read(drawerRiverpod.notifier)
                .openCreateCategorieDeModificateur(updated);
          } else if (createcategorieDePrix != null) {
            final updated = createcategorieDePrix.copyWith(salleMode: v);

            final container = ProviderScope.containerOf(context);
            container
                .read(drawerRiverpod.notifier)
                .updateCreateCategoriePrixModel(updated.copyWith(salleMode: v));
          }
        }
      },
    ),
  );
}

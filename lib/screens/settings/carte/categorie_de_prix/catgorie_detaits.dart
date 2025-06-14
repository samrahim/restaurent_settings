import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent/blocs/categorie_de_prix_bloc/categorie_de_prix_bloc.dart';
import 'package:restaurent/blocs/drawer/drawer_bloc.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/categorie_de_prix_model.dart';
import 'package:restaurent/screens/widgets/button_supprimer.dart';
import 'package:restaurent/screens/widgets/custom_list_tile.dart';

buildCategorieDePrixDetails({
  required CategorieDePrixModel model,
  required BuildContext context,
}) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<CategorieDePrixBloc>().add(ClearData());
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(model.nom, style: AppTextStyle.indingoHeading),
        centerTitle: true,
        actions: [SizedBox()],
      ),
      Expanded(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Catégorie de prix',
                        style: AppTextStyle.greyHeading,
                      ),
                    ),

                    ListTile(
                      trailing: Icon(Icons.arrow_forward_ios),
                      tileColor: AppColors.greyaccent,
                      leading: Text(
                        "Information generale",
                        style: AppTextStyle.indingosubHeading.copyWith(
                          color: AppColors.indingo500,
                        ),
                      ),
                    ),

                    SizedBox(height: 32),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Produits', style: AppTextStyle.greyHeading),
                    ),

                    ListTile(
                      onTap: () {
                        // context.read<DrawerBloc>().add(
                        //   OpenCreateCategoriePrixDrawer(model: model),
                        // );
                        // _scaffoldKey.currentState?.openEndDrawer();
                      },
                      trailing: Icon(Icons.arrow_forward_ios),

                      leading: Text(
                        "Produits associés",
                        style: AppTextStyle.indingosubHeading.copyWith(
                          color: AppColors.indingo500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4, right: 4),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    CustomListTile(
                                      trailingwidget: null,
                                      title: null,
                                      leading: 'nom',
                                      trailing: model.nom,
                                    ),
                                    const Divider(),
                                    CustomListTile(
                                      trailingwidget: null,
                                      leading: 'Nom court',
                                      title: null,
                                      trailing: model.nomCourt,
                                    ),
                                    const Divider(),
                                    CustomListTile(
                                      trailingwidget: Switch(
                                        activeColor: AppColors.primary,
                                        value: model.status,
                                        onChanged: (v) {},
                                      ),
                                      title: null,
                                      leading: 'Categorie de prix active',
                                      trailing: null,
                                    ),
                                    const Divider(),
                                    CustomListTile(
                                      trailingwidget: Switch(
                                        activeColor: AppColors.primary,
                                        value: model.afficherNomCourtEnCommande,
                                        onChanged: (v) {},
                                      ),
                                      title: null,
                                      leading: 'Afficher nom court en commande',
                                      trailing: null,
                                    ),

                                    const Divider(),
                                    CustomListTile(
                                      trailingwidget: Switch(
                                        activeColor: AppColors.primary,
                                        value:
                                            model
                                                .afficherNomCourtEnEncaissement,
                                        onChanged: (v) {},
                                      ),
                                      title: null,
                                      leading:
                                          'Afficher nom court a l\'encaisement',
                                      trailing: null,
                                    ),
                                    const Divider(),
                                    CustomListTile(
                                      trailingwidget: Switch(
                                        activeColor: AppColors.primary,
                                        value:
                                            model.afficherNomCourtEnFabrication,
                                        onChanged: (v) {},
                                      ),
                                      title: null,
                                      leading:
                                          'Afficher nom court a en fabrication',
                                      trailing: null,
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 16),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    CustomListTile(
                                      trailingwidget: Switch(
                                        activeColor: AppColors.primary,
                                        value: model.actifDansTouteLaJournee,
                                        onChanged: (v) {},
                                      ),
                                      leading: 'Actif toute la journée',
                                      title: null,
                                      trailing: null,
                                    ),
                                    const Divider(),
                                    CustomListTile(
                                      title: null,
                                      trailing: null,
                                      leading:
                                          'Jours d\'activite de la categorie de prix',
                                      trailingwidget: Text(
                                        style: AppTextStyle.indingosubHeading,
                                        model.joursDactivite
                                            .map((e) => e)
                                            .toString(),
                                      ),
                                    ),

                                    const Divider(),
                                    CustomListTile(
                                      trailingwidget: null,
                                      title: null,
                                      leading:
                                          'Salles Consernees par la cetegorie de prix',
                                      trailing: model.salle,
                                    ),
                                    if (!model.actifDansTouteLaJournee)
                                      const Divider(),

                                    if (!model.actifDansTouteLaJournee)
                                      Column(
                                        children: [
                                          CustomListTile(
                                            trailingwidget: null,
                                            title: null,
                                            leading: "Horaire de debut",
                                            trailing:
                                                '${model.heureDebut!.hour.toString()}:${model.heureDebut!.minute}',
                                          ),
                                          Divider(),
                                        ],
                                      ),

                                    if (!model.actifDansTouteLaJournee)
                                      CustomListTile(
                                        trailingwidget: null,
                                        title: null,
                                        leading: "Horaire de fin",
                                        trailing:
                                            '${model.heureFin!.hour.toString()}:${model.heureFin!.minute}',
                                      ),
                                  ],
                                ),
                              ),

                              ButtonSupprimer(onTap: () {}),
                              SizedBox(height: 17),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

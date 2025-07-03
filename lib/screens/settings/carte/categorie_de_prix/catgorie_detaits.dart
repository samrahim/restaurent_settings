import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent/blocs/drawer/drawer_bloc.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/categorie_de_prix_model.dart';
import 'package:restaurent/models/salle_model.dart';
import 'package:restaurent/widgets/button_supprimer.dart';
import 'package:restaurent/widgets/custom_list_tile.dart';

class CategorieDePrixDetails extends StatefulWidget {
  final CategorieDePrixModel categorieDePrixModel;

  final GlobalKey<ScaffoldState> scaffoldKey;
  const CategorieDePrixDetails({
    super.key,

    required this.categorieDePrixModel,
    required this.scaffoldKey,
  });

  @override
  State<CategorieDePrixDetails> createState() => _CategorieDePrixDetailsState();
}

class _CategorieDePrixDetailsState extends State<CategorieDePrixDetails> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
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

                const SizedBox(height: 32),

                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Produits', style: AppTextStyle.greyHeading),
                ),

                ListTile(
                  onTap: () {},
                  trailing: const Icon(Icons.arrow_forward_ios),
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
          flex: 5,
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
                          const SizedBox(height: 16),
                          Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    context.read<DrawerBloc>().add(
                                      OpenUpdateCategrieDePrixAttributs(
                                        model: widget.categorieDePrixModel,
                                        attributeName: 'nom',
                                        currentValue:
                                            widget.categorieDePrixModel.nom,
                                      ),
                                    );
                                    widget.scaffoldKey.currentState
                                        ?.openEndDrawer();
                                  },
                                  child: CustomListTile(
                                    trailingwidget: null,
                                    title: null,
                                    leading: 'nom',
                                    trailing: widget.categorieDePrixModel.nom,
                                  ),
                                ),
                                const Divider(),
                                InkWell(
                                  onTap: () {
                                    context.read<DrawerBloc>().add(
                                      OpenUpdateCategrieDePrixAttributs(
                                        model: widget.categorieDePrixModel,
                                        attributeName: 'nom court',
                                        currentValue:
                                            widget
                                                .categorieDePrixModel
                                                .nomCourt,
                                      ),
                                    );
                                    widget.scaffoldKey.currentState
                                        ?.openEndDrawer();
                                  },
                                  child: CustomListTile(
                                    trailingwidget: null,
                                    leading: 'Nom court',
                                    title: null,
                                    trailing:
                                        widget.categorieDePrixModel.nomCourt,
                                  ),
                                ),
                                const Divider(),
                                InkWell(
                                  onTap: () {
                                    context.read<DrawerBloc>().add(
                                      OpenUpdateCategrieDePrixAttributs(
                                        model: widget.categorieDePrixModel,
                                        attributeName: 'categorie de prix',
                                        currentValue:
                                            widget
                                                .categorieDePrixModel
                                                .categorieDePrixActive,
                                      ),
                                    );
                                    widget.scaffoldKey.currentState
                                        ?.openEndDrawer();
                                  },
                                  child: CustomListTile(
                                    trailingwidget: Switch(
                                      activeTrackColor: AppColors.primary,
                                      value:
                                          widget
                                              .categorieDePrixModel
                                              .categorieDePrixActive!,

                                      onChanged: null,
                                    ),
                                    title: null,
                                    leading: 'Categorie de prix active',
                                    trailing: null,
                                  ),
                                ),
                                const Divider(),
                                InkWell(
                                  onTap: () {
                                    context.read<DrawerBloc>().add(
                                      OpenUpdateCategrieDePrixAttributs(
                                        model: widget.categorieDePrixModel,
                                        attributeName:
                                            'Afficher nom court en commande',
                                        currentValue:
                                            widget
                                                .categorieDePrixModel
                                                .afficherNomCourtEnCommande,
                                      ),
                                    );
                                    widget.scaffoldKey.currentState
                                        ?.openEndDrawer();
                                  },
                                  child: CustomListTile(
                                    trailingwidget: Switch(
                                      activeTrackColor: AppColors.primary,
                                      value:
                                          widget
                                              .categorieDePrixModel
                                              .afficherNomCourtEnCommande!,
                                      onChanged: null,
                                    ),
                                    title: null,
                                    leading: 'Afficher nom court en commande',
                                    trailing: null,
                                  ),
                                ),

                                const Divider(),
                                InkWell(
                                  onTap: () {
                                    context.read<DrawerBloc>().add(
                                      OpenUpdateCategrieDePrixAttributs(
                                        model: widget.categorieDePrixModel,
                                        attributeName:
                                            'Afficher nom court a l\'encaissement',
                                        currentValue:
                                            widget
                                                .categorieDePrixModel
                                                .afficherNomCourtEnEncaissement,
                                      ),
                                    );
                                    widget.scaffoldKey.currentState
                                        ?.openEndDrawer();
                                  },
                                  child: CustomListTile(
                                    trailingwidget: Switch(
                                      activeTrackColor: AppColors.primary,
                                      value:
                                          widget
                                              .categorieDePrixModel
                                              .afficherNomCourtEnEncaissement!,
                                      onChanged: null,
                                    ),
                                    title: null,
                                    leading:
                                        'Afficher nom court a l\'encaissement',
                                    trailing: null,
                                  ),
                                ),
                                const Divider(),
                                InkWell(
                                  onTap: () {
                                    context.read<DrawerBloc>().add(
                                      OpenUpdateCategrieDePrixAttributs(
                                        model: widget.categorieDePrixModel,
                                        attributeName:
                                            'Afficher nom court en fabrication',
                                        currentValue:
                                            widget
                                                .categorieDePrixModel
                                                .afficherNomCourtEnFabrication,
                                      ),
                                    );
                                    widget.scaffoldKey.currentState
                                        ?.openEndDrawer();
                                  },
                                  child: CustomListTile(
                                    trailingwidget: Switch(
                                      activeTrackColor: AppColors.primary,
                                      value:
                                          widget
                                              .categorieDePrixModel
                                              .afficherNomCourtEnFabrication!,
                                      onChanged: null,
                                    ),
                                    title: null,
                                    leading:
                                        'Afficher nom court en fabrication',
                                    trailing: null,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),
                          Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                CustomListTile(
                                  trailingwidget: Switch(
                                    activeColor: AppColors.primary,
                                    value:
                                        widget
                                            .categorieDePrixModel
                                            .actifDansTouteLaJournee!,
                                    onChanged: null,
                                  ),
                                  leading: 'Actif toute la journée',
                                  title: null,
                                  trailing: null,
                                ),
                                const Divider(),
                                InkWell(
                                  onTap: () {
                                    context.read<DrawerBloc>().add(
                                      OpenUpdateCategrieDePrixAttributs(
                                        model: widget.categorieDePrixModel,
                                        attributeName: 'jours d\'activite',
                                        currentValue:
                                            widget
                                                .categorieDePrixModel
                                                .joursDactivite,
                                      ),
                                    );
                                    widget.scaffoldKey.currentState
                                        ?.openEndDrawer();
                                  },
                                  child: CustomListTile(
                                    title: null,
                                    trailing: null,
                                    leading:
                                        'Jours d\'activite de la categorie de prix',
                                    trailingwidget: Text(
                                      widget
                                          .categorieDePrixModel
                                          .joursDactivite!
                                          .join(", "),
                                      style: AppTextStyle.indingosubHeading,
                                    ),
                                  ),
                                ),

                                const Divider(),
                                InkWell(
                                  onTap: () {
                                    context.read<DrawerBloc>().add(
                                      OpenUpdateCategrieDePrixAttributs(
                                        model: widget.categorieDePrixModel,
                                        attributeName: 'Salles',
                                        currentValue:
                                            widget
                                                .categorieDePrixModel
                                                .salleIDS,
                                      ),
                                    );
                                    widget.scaffoldKey.currentState
                                        ?.openEndDrawer();
                                  },
                                  child: CustomListTile(
                                    trailingwidget: null,
                                    title: null,
                                    leading:
                                        'Salles Consernees par la cetegorie de prix',
                                    trailing:
                                        widget.categorieDePrixModel.salleIDS !=
                                                null
                                            ? widget
                                                .categorieDePrixModel
                                                .salleIDS!
                                                .map(
                                                  (id) =>
                                                      salles
                                                          .firstWhere(
                                                            (s) => s.id == id,
                                                          )
                                                          .nom,
                                                )
                                                .join(', ')
                                            : 'Aucune salle sélectionnée',
                                  ),
                                ),

                                if (!widget
                                    .categorieDePrixModel
                                    .actifDansTouteLaJournee!)
                                  const Divider(),

                                if (!widget
                                    .categorieDePrixModel
                                    .actifDansTouteLaJournee!)
                                  Column(
                                    children: [
                                      CustomListTile(
                                        trailingwidget: null,
                                        title: null,
                                        leading: "Horaire de debut",
                                        trailing:
                                            '${widget.categorieDePrixModel.heureDebut!.hour.toString().padLeft(2, '0')}:${widget.categorieDePrixModel.heureDebut!.minute.toString().padLeft(2, '0')}',
                                      ),
                                      const Divider(),
                                    ],
                                  ),

                                if (!widget
                                    .categorieDePrixModel
                                    .actifDansTouteLaJournee!)
                                  CustomListTile(
                                    trailingwidget: null,
                                    title: null,
                                    leading: "Horaire de fin",
                                    trailing:
                                        '${widget.categorieDePrixModel.heureFin!.hour.toString().padLeft(2, '0')}:${widget.categorieDePrixModel.heureFin!.minute.toString().padLeft(2, '0')}',
                                  ),
                              ],
                            ),
                          ),

                          ButtonSupprimer(
                            style: null,
                            onTap: () {},
                            text: 'Supprimer',
                          ),
                          const SizedBox(height: 17),
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
    );
  }
}

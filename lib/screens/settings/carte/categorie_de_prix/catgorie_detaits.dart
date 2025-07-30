import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/categorie_de_prix_model.dart';
import 'package:restaurent/models/salle_model.dart';
import 'package:restaurent/riverpods/drawer_riverpod/drawer_riverpod.dart';
import 'package:restaurent/screens/reglage_screen.dart';
import 'package:restaurent/widgets/button_supprimer.dart';
import 'package:restaurent/widgets/custom_list_tile.dart';

class CategorieDePrixDetails extends ConsumerStatefulWidget {
  final CategorieDePrixModel categorieDePrixModel;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CategorieDePrixDetails({
    super.key,
    required this.categorieDePrixModel,
    required this.scaffoldKey,
  });

  @override
  ConsumerState<CategorieDePrixDetails> createState() =>
      _CategorieDePrixDetailsState();
}

class _CategorieDePrixDetailsState
    extends ConsumerState<CategorieDePrixDetails> {
  @override
  Widget build(BuildContext context) {
    final salleList = ref.watch(salleRiverpod);
    final drawerNotifier = ref.read(drawerRiverpod.notifier);
    final model = widget.categorieDePrixModel;

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
                    "Information générale",
                    style: AppTextStyle.indingosubHeading.copyWith(
                      color: AppColors.indingo400,
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
                      color: AppColors.indingo400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          _buildInfoCard(drawerNotifier, model),
                          const SizedBox(height: 16),
                          _buildScheduleCard(drawerNotifier, model, salleList),
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

  Widget _buildInfoCard(
    DrawerNotifier drawerNotifier,
    CategorieDePrixModel model,
  ) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          CustomListTile(
            onTap: () {
              drawerNotifier.openUpdateCategorieDePrixAttributs(
                model,
                'nom',
                model.nom,
              );
              widget.scaffoldKey.currentState?.openEndDrawer();
            },
            trailingwidget: null,
            title: null,
            leading: 'Nom',
            trailing: model.nom,
          ),
          const Divider(),
          CustomListTile(
            onTap: () {
              drawerNotifier.openUpdateCategorieDePrixAttributs(
                model,
                'nom court',
                model.nomCourt,
              );
              widget.scaffoldKey.currentState?.openEndDrawer();
            },
            trailingwidget: null,
            leading: 'Nom court',
            title: null,
            trailing: model.nomCourt,
          ),
          const Divider(),
          CustomListTile(
            onTap: () {
              drawerNotifier.openUpdateCategorieDePrixAttributs(
                model,
                'Afficher nom court en commande',
                model.afficherNomCourtEnCommande,
              );
              widget.scaffoldKey.currentState?.openEndDrawer();
            },
            trailingwidget: Switch(
              activeTrackColor: AppColors.primary,
              value: model.afficherNomCourtEnCommande ?? false,
              onChanged: null,
            ),
            title: null,
            leading: 'Afficher nom court en commande',
            trailing: null,
          ),
          const Divider(),
          CustomListTile(
            onTap: () {
              drawerNotifier.openUpdateCategorieDePrixAttributs(
                model,
                'Afficher nom court a l\'encaissement',
                model.afficherNomCourtEnEncaissement,
              );
              widget.scaffoldKey.currentState?.openEndDrawer();
            },
            trailingwidget: Switch(
              activeTrackColor: AppColors.primary,
              value: model.afficherNomCourtEnEncaissement ?? false,
              onChanged: null,
            ),
            title: null,
            leading: 'Afficher nom court à l\'encaissement',
            trailing: null,
          ),
          const Divider(),
          CustomListTile(
            onTap: () {
              drawerNotifier.openUpdateCategorieDePrixAttributs(
                model,
                'Afficher nom court en fabrication',
                model.afficherNomCourtEnFabrication,
              );
              widget.scaffoldKey.currentState?.openEndDrawer();
            },
            trailingwidget: Switch(
              activeTrackColor: AppColors.primary,
              value: model.afficherNomCourtEnFabrication ?? false,
              onChanged: null,
            ),
            title: null,
            leading: 'Afficher nom court en fabrication',
            trailing: null,
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(
    DrawerNotifier drawerNotifier,
    CategorieDePrixModel model,
    List<SalleModel> salles,
  ) {
    final selectedSalleNames =
        model.salleIDS != null
            ? model.salleIDS!
                .map(
                  (id) =>
                      salles
                          .firstWhere(
                            (s) => s.id == id,
                            orElse:
                                () => SalleModel(id: 0, name: 'Salle inconnue'),
                          )
                          .name,
                )
                .join(', ')
            : 'Aucune salle sélectionnée';

    return Card(
      color: Colors.white,
      child: Column(
        children: [
          CustomListTile(
            onTap: null,
            trailingwidget: Switch(
              activeColor: AppColors.primary,
              value: model.actifDansTouteLaJournee ?? false,
              onChanged: null,
            ),
            leading: 'Actif toute la journée',
            title: null,
            trailing: null,
          ),
          const Divider(),
          CustomListTile(
            onTap: () {
              drawerNotifier.openUpdateCategorieDePrixAttributs(
                model,
                'jours d\'activite',
                model.joursDactivite,
              );
              widget.scaffoldKey.currentState?.openEndDrawer();
            },
            title: null,
            trailing: null,
            leading: 'Jours d\'activite de la catégorie de prix',
            trailingwidget: Text(
              model.joursDactivite?.join(", ") ?? '',
              style: AppTextStyle.indingosubHeading,
            ),
          ),
          const Divider(),
          CustomListTile(
            onTap: () {
              drawerNotifier.openUpdateCategorieDePrixAttributs(
                model,
                'Salles',
                model.salleIDS,
              );
              widget.scaffoldKey.currentState?.openEndDrawer();
            },
            trailingwidget: null,
            title: null,
            leading: 'Salles concernées par la catégorie de prix',
            trailing: selectedSalleNames,
          ),
          if (!(model.actifDansTouteLaJournee ?? true)) ...[
            const Divider(),
            CustomListTile(
              onTap: null,
              trailingwidget: null,
              title: null,
              leading: "Horaire de début",
              trailing:
                  '${model.heureDebut?.hour.toString().padLeft(2, '0')}:${model.heureDebut?.minute.toString().padLeft(2, '0')}',
            ),
            const Divider(),
            CustomListTile(
              onTap: null,
              trailingwidget: null,
              title: null,
              leading: "Horaire de fin",
              trailing:
                  '${model.heureFin?.hour.toString().padLeft(2, '0')}:${model.heureFin?.minute.toString().padLeft(2, '0')}',
            ),
          ],
        ],
      ),
    );
  }
}

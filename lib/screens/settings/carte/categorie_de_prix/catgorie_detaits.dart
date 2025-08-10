import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/categorie_de_prix_model.dart';
import 'package:restaurent/models/salle_model.dart';
import 'package:restaurent/riverpods/drawer_riverpod/drawer_riverpod.dart';
import 'package:restaurent/screens/reglage_screen.dart';
import 'package:restaurent/screens/settings/carte/categorie_de_modificateur/modificteur_details.dart';
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
    final drawerNotifier = ref.read(drawerRiverpod.notifier);
    final model = widget.categorieDePrixModel;

    final categorieDePrixNotifier = ref.read(categorieDePrixRiverpod.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(model.nom!, style: AppTextStyle.indingoHeading),
        actions: [const SizedBox()],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            categorieDePrixNotifier.clearSelection();
          },
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'CATÉGORIE DE PRIX',
                          style: AppTextStyle.greysubHeading,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey.shade400,
                    child: ListTile(
                      title: Text(
                        'Informations générales',
                        style: AppTextStyle.indingoHeading,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('PRODUITS', style: AppTextStyle.greysubHeading),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add, color: Colors.red),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: model.produitsIds?.length ?? 0,
                      itemBuilder: (context, index) {
                        final product = ref
                            .read(productRiverpod.notifier)
                            .getProductById(model.produitsIds![index]);

                        if (product == null) {
                          return SizedBox.shrink();
                        }

                        return Column(
                          children: [
                            buildModifierTile(product.name ?? 'Nom non défini'),
                            if (model.produitsIds != null &&
                                index != model.produitsIds?.length)
                              Divider(),
                          ],
                        );
                      },
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
                            _buildScheduleCard(
                              drawerNotifier,
                              model,
                              model.salleIDS ?? [],
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
      ),
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
    List<int> salles,
  ) {
    List<String?> salleName = [];

    model.salleIDS?.forEach((e) {
      final salle = ref.watch(salleRiverpod.notifier).getSalleById(e);
      if (salle != null) {
        salleName.add(salle.name);
      }
    });

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
              model.joursDactivite?.join(",") ?? '',
              style: AppTextStyle.indingosubHeading,
            ),
          ),
          const Divider(),
          CustomListTile(
            onTap: () {
              drawerNotifier.openUpdateCategorieDePrixAttributs(
                model,
                'salle',
                model.salleIDS,
              );
              widget.scaffoldKey.currentState?.openEndDrawer();
            },
            trailingwidget: null,
            title: null,
            leading: 'Salles concernées par la catégorie de prix',
            trailing: salleName.join(','),
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

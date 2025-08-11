import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/models.dart';
import 'package:restaurent/riverpods/drawer_riverpod/drawer_state.dart';
import 'package:restaurent/screens/reglage_screen.dart';
import 'package:restaurent/widgets/update_prod_ui.dart';
import 'package:restaurent/widgets/widgets.dart';

class ModificateurDetails extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ModificateurDetails({required this.scaffoldKey, super.key});

  @override
  ConsumerState<ModificateurDetails> createState() =>
      _ModificateurDetailsState();
}

class _ModificateurDetailsState extends ConsumerState<ModificateurDetails> {
  AffectationMode mode = AffectationMode.POUR_SEULEMENT;
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(tempSelectedIdsProvider.notifier).state = List.from(
        ref.read(categorieModificateurRiverpod).selected?.produitsIds ?? [],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final categorieModificateurState = ref.watch(categorieModificateurRiverpod);
    final categorieModificateurNotifier = ref.read(
      categorieModificateurRiverpod.notifier,
    );
    final drawerNotifier = ref.read(drawerRiverpod.notifier);
    final drawerState = ref.watch(drawerRiverpod);
    final modificateur = categorieModificateurState.selected;
    final tempSelected = ref.watch(tempSelectedIdsProvider);
    return (modificateur != null &&
            (drawerState is! UpdateProdsScreenModificateur))
        ? Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                categorieModificateurNotifier.deselect();
                ref.read(tempSelectedIdsProvider.notifier).state.clear();
              },
            ),

            centerTitle: true,
            title: Text(
              modificateur.nom ?? "",
              style: AppTextStyle.largeindingotext,
            ),
          ),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'CATÉGORIE DE MODIFICATEURS',
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
                              Text(
                                'MODIFICATEURS / SUPPLÉMENTS',
                                style: AppTextStyle.greysubHeading,
                              ),
                              IconButton(
                                onPressed: () {
                                  final container = ProviderScope.containerOf(
                                    context,
                                  );
                                  container
                                      .read(drawerRiverpod.notifier)
                                      .openCreateSubCategorieDeModificateur(
                                        modificateur,
                                      );
                                  widget.scaffoldKey.currentState!.openDrawer();
                                },
                                icon: Icon(Icons.add, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: modificateur.modificateurs.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  buildModifierTile(
                                    modificateur.modificateurs[index].nom,
                                  ),
                                  if (index !=
                                      modificateur.modificateurs.length - 1)
                                    const Divider(),
                                ],
                              );
                            },
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'PRODUITS',
                                style: AppTextStyle.greysubHeading,
                              ),
                              IconButton(
                                onPressed: () {
                                  drawerNotifier.updateProdModificateur(
                                    modificateur: modificateur,
                                  );
                                },
                                icon: Icon(Icons.add, color: Colors.red),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: modificateur.produitsIds?.length ?? 0,
                            itemBuilder: (context, index) {
                              final product = ref
                                  .read(productRiverpod.notifier)
                                  .getProductById(
                                    modificateur.produitsIds![index],
                                  );

                              if (product == null) {
                                return SizedBox.shrink();
                              }

                              return Column(
                                children: [
                                  buildModifierTile(
                                    product.name ?? 'Nom non défini',
                                  ),
                                  if (index !=
                                      modificateur.produitsIds!.length - 1)
                                    const Divider(),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),

              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Card(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    CustomListTile(
                                      onTap: () {
                                        final container =
                                            ProviderScope.containerOf(context);
                                        container
                                            .read(drawerRiverpod.notifier)
                                            .openUpdateCategorieDeModificateur(
                                              modificateur,
                                              'nom',
                                              modificateur.nom,
                                            );

                                        widget.scaffoldKey.currentState!
                                            .openEndDrawer();
                                      },
                                      trailingwidget: null,
                                      title: Text(
                                        'Nom',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      leading: null,
                                      trailing: modificateur.nom,
                                    ),
                                    const Divider(),
                                    CustomListTile(
                                      onTap: null,
                                      trailingwidget: const Icon(
                                        Icons.restaurant,
                                        color: Colors.indigo,
                                      ),
                                      title: Text(
                                        'Icone',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      leading: null,
                                      trailing: null,
                                    ),

                                    const Divider(),

                                    CustomListTile(
                                      onTap: () {
                                        final container =
                                            ProviderScope.containerOf(context);
                                        container
                                            .read(drawerRiverpod.notifier)
                                            .openUpdateCategorieDeModificateur(
                                              modificateur,
                                              'couleur',
                                              Color(
                                                int.parse(
                                                  '0X${modificateur.couleur!.replaceAll('#', '')}',
                                                ),
                                              ),
                                            );

                                        widget.scaffoldKey.currentState!
                                            .openEndDrawer();
                                      },
                                      leading: null,
                                      trailing: null,
                                      title: Text(
                                        "Couleur",
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      trailingwidget: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: hexToColor(
                                            modificateur.couleur!,
                                          ),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.black26,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    buildScheduleCard(modificateur),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 32),
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    CustomListTile(
                                      onTap: () {
                                        final container =
                                            ProviderScope.containerOf(context);
                                        container
                                            .read(drawerRiverpod.notifier)
                                            .openUpdateCategorieDeModificateur(
                                              modificateur,
                                              'typeDeSelection',
                                              modificateur.typeSelection?.name
                                                      .replaceAll('_', ' ') ??
                                                  '',
                                            );

                                        widget.scaffoldKey.currentState!
                                            .openEndDrawer();
                                      },
                                      leading: null,
                                      trailing:
                                          modificateur.typeSelection != null
                                              ? modificateur.typeSelection?.name
                                                  .replaceAll('_', ' ')
                                              : "",
                                      title: Text(
                                        'Type de sélection',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      trailingwidget: null,
                                    ),

                                    Divider(),
                                    CustomListTile(
                                      onTap: () {
                                        final container =
                                            ProviderScope.containerOf(context);
                                        container
                                            .read(drawerRiverpod.notifier)
                                            .openUpdateCategorieDeModificateur(
                                              modificateur,
                                              'obligatoire',
                                              modificateur.obligatoire,
                                            );

                                        widget.scaffoldKey.currentState!
                                            .openEndDrawer();
                                      },
                                      leading: 'Obligatoire',
                                      trailing: null,
                                      title: null,
                                      trailingwidget: Switch(
                                        activeTrackColor: AppColors.primary,
                                        value: modificateur.obligatoire!,
                                        onChanged: null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              ButtonSupprimer(
                                style: null,
                                text: 'Supprimer',
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        : (modificateur != null &&
            (drawerState is UpdateProdsScreenModificateur))
        ? ProductSelectionScreen(
          selectedIds: tempSelected,
          isForCreate: false,
          currentMode: mode,
          onSelectionChanged: (ids) {
            ref.read(tempSelectedIdsProvider.notifier).state = ids;
          },
          onModeChanged: (newMode) {
            setState(() {
              mode = newMode;
            });
          },
          onBack: () async {
            await categorieModificateurNotifier.update(
              modificateur.copyWith(
                produitMode: mode,
                produitsIds: tempSelected,
              ),
            );
            ref.read(tempSelectedIdsProvider.notifier).state.clear();
            drawerNotifier.resetDrawer();
          },
        )
        : SizedBox.shrink();
  }

  Widget buildScheduleCard(CategorieDeModificateur model) {
    List<String?> salleName = [];

    model.sallesIDS?.forEach((e) {
      final salle = ref.watch(salleRiverpod.notifier).getSalleById(e);
      if (salle != null) {
        salleName.add(salle.name);
      }
    });
    return CustomListTile(
      onTap: () {
        final container = ProviderScope.containerOf(context);
        container
            .read(drawerRiverpod.notifier)
            .openUpdateCategorieDeModificateur(model, 'salle', model.sallesIDS);
        widget.scaffoldKey.currentState?.openEndDrawer();
      },
      trailingwidget: null,
      title: null,
      leading: 'Salles concernées par la catégorie de prix',
      trailing: salleName.join(','),
    );
  }
}

Widget buildModifierTile(String nom) {
  return ListTile(
    title: Text(nom, style: AppTextStyle.indingosubHeading),
    trailing: const Icon(Icons.drag_handle),
  );
}

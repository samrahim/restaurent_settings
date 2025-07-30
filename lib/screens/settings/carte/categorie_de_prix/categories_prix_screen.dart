import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/models/categorie_de_prix_model.dart';
import 'package:restaurent/riverpods/drawer_riverpod/drawer_state.dart';
import 'package:restaurent/screens/reglage_screen.dart';
import 'package:restaurent/screens/settings/carte/categorie_de_prix/catgorie_detaits.dart';
import 'package:restaurent/widgets/widgets.dart';
import 'package:restaurent/consts.dart';

class CategoriesPrixScreen extends StatefulWidget {
  const CategoriesPrixScreen({super.key});

  @override
  State<CategoriesPrixScreen> createState() => _CategoriesPrixScreenState();
}

class _CategoriesPrixScreenState extends State<CategoriesPrixScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CategorieDePrixModel model = CategorieDePrixModel(
    id: categoriesPrixList.length.toString(),
    nom: '',
    nomCourt: '',
    actif: false,

    afficherNomCourtEnCommande: false,
    afficherNomCourtEnEncaissement: false,
    afficherNomCourtEnFabrication: false,
    actifDansTouteLaJournee: false,

    joursDactivite: [],
    salleIDS: [],
    heureDebut: const TimeOfDay(hour: 12, minute: 00),
    heureFin: const TimeOfDay(hour: 12, minute: 00),
    priorite: 10,
    jourFerie: false,
    produitsIds: [],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Consumer(
        builder: (context, ref, _) {
          final salles = ref.watch(salleRiverpod);

          final state = ref.watch(drawerRiverpod);

          if (state is DrawerCreateCategoriePrix) {
            final m = state.model;
            return Drawer(
              width: MediaQuery.of(context).size.width * 0.3,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Créer une nouvelle catégorie de prix',
                        style: AppTextStyle.indingoHeading,
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      initialValue: m.nom,
                      decoration: InputDecoration(
                        labelText: 'Nom',
                        labelStyle: AppTextStyle.indingosubHeading,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      onChanged: (v) {
                        final container = ProviderScope.containerOf(context);
                        container
                            .read(drawerRiverpod.notifier)
                            .updateCreateCategoriePrixModel(m.copyWith(nom: v));
                      },
                    ),
                    const SizedBox(height: 16),

                    // Nom court
                    TextFormField(
                      initialValue: m.nomCourt,
                      decoration: InputDecoration(
                        labelStyle: AppTextStyle.indingosubHeading,
                        labelText: 'Nom court',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      onChanged: (v) {
                        final container = ProviderScope.containerOf(context);
                        container
                            .read(drawerRiverpod.notifier)
                            .updateCreateCategoriePrixModel(
                              m.copyWith(nomCourt: v),
                            );
                      },
                    ),
                    const SizedBox(height: 16),

                    ...[
                      [
                        'Activer catégorie',
                        m.actif,
                        (bool v) => m.copyWith(actif: v),
                      ],
                      [
                        'Afficher nom court (Commande)',
                        m.afficherNomCourtEnCommande,
                        (bool v) => m.copyWith(afficherNomCourtEnCommande: v),
                      ],
                      [
                        'Afficher nom court (Encaissement)',
                        m.afficherNomCourtEnEncaissement,
                        (bool v) =>
                            m.copyWith(afficherNomCourtEnEncaissement: v),
                      ],
                      [
                        'Afficher nom court (Fabrication)',
                        m.afficherNomCourtEnFabrication,
                        (bool v) =>
                            m.copyWith(afficherNomCourtEnFabrication: v),
                      ],

                      [
                        'Actif toute la journée',
                        m.actifDansTouteLaJournee,
                        (bool v) => m.copyWith(actifDansTouteLaJournee: v),
                      ],
                    ].map((entry) {
                      final label = entry[0] as String;
                      final value = entry[1] as bool;
                      final copy =
                          entry[2] as CategorieDePrixModel Function(bool);
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: CustomListTile(
                              onTap: null,
                              leading: null,
                              trailing: null,
                              title: Text(
                                label,
                                style: AppTextStyle.indingosubHeading,
                              ),
                              trailingwidget: Switch(
                                inactiveTrackColor: Colors.grey[300],

                                activeColor:
                                    AppTextStyle.indingosubHeading.color,
                                value: value,
                                onChanged: (v) {
                                  final container = ProviderScope.containerOf(
                                    context,
                                  );
                                  container
                                      .read(drawerRiverpod.notifier)
                                      .updateCreateCategoriePrixModel(copy(v));
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      );
                    }),

                    if (!m.actifDansTouteLaJournee!) ...[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: ListTile(
                          title: Text(
                            'Heure début',
                            style: AppTextStyle.indingosubHeading,
                          ),
                          trailing: Text(
                            m.heureDebut?.format(context) ?? '--:--',
                            style: AppTextStyle.indingosubHeading,
                          ),
                          onTap: () async {
                            final t = await showTimePicker(
                              context: context,
                              initialTime: m.heureDebut ?? TimeOfDay.now(),
                            );
                            if (t != null && context.mounted) {
                              final container = ProviderScope.containerOf(
                                context,
                              );
                              container
                                  .read(drawerRiverpod.notifier)
                                  .updateCreateCategoriePrixModel(
                                    m.copyWith(heureDebut: t),
                                  );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: ListTile(
                          title: Text(
                            'Heure fin',
                            style: AppTextStyle.indingosubHeading,
                          ),
                          trailing: Text(
                            m.heureFin?.format(context) ?? '--:--',
                            style: AppTextStyle.indingosubHeading,
                          ),
                          onTap: () async {
                            final t = await showTimePicker(
                              context: context,
                              initialTime: m.heureFin ?? TimeOfDay.now(),
                            );
                            if (t != null && context.mounted) {
                              final container = ProviderScope.containerOf(
                                context,
                              );
                              container
                                  .read(drawerRiverpod.notifier)
                                  .updateCreateCategoriePrixModel(
                                    m.copyWith(heureFin: t),
                                  );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    SalleIdsPicker(
                      salles: salles,
                      selectedSalleIds: m.salleIDS!,
                      onSelectionChanged: (selectedIds) {
                        final container = ProviderScope.containerOf(context);
                        container
                            .read(drawerRiverpod.notifier)
                            .updateCreateCategoriePrixModel(
                              m.copyWith(salleIDS: selectedIds),
                            );
                      },
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jours d\'activite',
                            style: AppTextStyle.indingosubHeading,
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 40,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: joursSemaine.length,
                              separatorBuilder:
                                  (_, __) => const SizedBox(width: 8),
                              itemBuilder: (_, i) {
                                final d = joursSemaine[i];
                                final selected = m.joursDactivite!.contains(d);
                                return ChoiceChip(
                                  selectedColor:
                                      AppTextStyle.indingosubHeading.color,
                                  showCheckmark: false,
                                  label: Text(
                                    d.toString(),
                                    style:
                                        selected
                                            ? AppTextStyle.greysubHeading
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                )
                                            : AppTextStyle.greysubHeading
                                                .copyWith(
                                                  fontSize: 16,
                                                  color: Colors.grey.shade600,
                                                ),
                                  ),
                                  selected: selected,

                                  onSelected: (sel) {
                                    final jours = List<String>.from(
                                      m.joursDactivite!,
                                    );
                                    sel
                                        ? jours.add(d.toString())
                                        : jours.remove(d);
                                    final container = ProviderScope.containerOf(
                                      context,
                                    );
                                    container
                                        .read(drawerRiverpod.notifier)
                                        .updateCreateCategoriePrixModel(
                                          m.copyWith(joursDactivite: jours),
                                        );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                    CreateButton(
                      onPressed: () {
                        final riverpod = ref.read(
                          categorieDePrixRiverpod.notifier,
                        );
                        riverpod.create(m);

                        _scaffoldKey.currentState?.closeEndDrawer();
                      },
                      buttonText: "Créer la catégorie",
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is DrawerUpdateCategoriDePrix) {
            switch (state.attributeName) {
              case 'nom':
                return UpdateAttributeDrawer(
                  fieldType: FieldType.string,
                  label: 'nom',
                  initialValue: state.model.nom,
                  onSaved: (v) {
                    final riverpod = ref.read(categorieDePrixRiverpod.notifier);
                    riverpod.update(state.model.copyWith(nom: v));
                  },
                );

              case 'nom court':
                return UpdateAttributeDrawer(
                  label: 'nom court',
                  initialValue: state.model.nomCourt,
                  fieldType: FieldType.string,
                  onSaved: (v) {
                    final riverpod = ref.read(categorieDePrixRiverpod.notifier);
                    riverpod.update(state.model.copyWith(nomCourt: v));
                  },
                );

              case 'Afficher nom court en commande':
                return UpdateAttributeDrawer(
                  label: 'Afficher nom court en commande',
                  initialValue: state.model.afficherNomCourtEnCommande,
                  fieldType: FieldType.boolean,
                  onSaved: (v) {
                    final riverpod = ref.read(categorieDePrixRiverpod.notifier);
                    riverpod.update(
                      state.model.copyWith(afficherNomCourtEnCommande: v),
                    );
                  },
                );

              case 'Afficher nom court a l\'encaissement':
                return UpdateAttributeDrawer(
                  label: 'Afficher nom court a l\'encaissement',
                  initialValue: state.model.afficherNomCourtEnEncaissement,
                  fieldType: FieldType.boolean,
                  onSaved: (v) {
                    final riverpod = ref.read(categorieDePrixRiverpod.notifier);
                    riverpod.update(
                      state.model.copyWith(afficherNomCourtEnEncaissement: v),
                    );
                  },
                );
              case 'Salles':
                return UpdateAttributeDrawer(
                  label: 'Salles',
                  options: salles,
                  initialValue: state.model.salleIDS,
                  fieldType: FieldType.choice,
                  onSaved: (v) {
                    final riverpod = ref.read(categorieDePrixRiverpod.notifier);
                    riverpod.update(state.model.copyWith(salleIDS: v));
                  },
                );
              case 'Afficher nom court en fabrication':
                return UpdateAttributeDrawer(
                  label: 'Afficher nom court en fabrication',
                  initialValue: state.model.afficherNomCourtEnFabrication,
                  fieldType: FieldType.boolean,
                  onSaved: (v) {
                    final riverpod = ref.read(categorieDePrixRiverpod.notifier);
                    riverpod.update(
                      state.model.copyWith(afficherNomCourtEnFabrication: v),
                    );
                  },
                );
              case "jours d'activite":
                return UpdateAttributeDrawer(
                  label: "jours d'activite",
                  options: joursSemaine,
                  initialValue: state.model.joursDactivite,
                  fieldType: FieldType.choice,
                  onSaved: (v) {
                    final riverpod = ref.read(categorieDePrixRiverpod.notifier);
                    riverpod.update(state.model.copyWith(joursDactivite: v));
                  },
                );
              default:
                return SizedBox.shrink();
            }
          }
          return SizedBox.shrink();
        },
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Consumer(
          builder: (context, ref, _) {
            final provider = ref.watch(categorieDePrixRiverpod);
            return Column(
              children: [
                if (provider.selected != null)
                  AppBar(
                    backgroundColor: Colors.white,
                    centerTitle: true,
                    title: Text(
                      provider.selected!.nom!,
                      style: AppTextStyle.indingoHeading,
                    ),
                    actions: [const SizedBox()],
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        ref
                            .read(categorieDePrixRiverpod.notifier)
                            .clearSelection();
                      },
                    ),
                  )
                else
                  AppBar(
                    title: Text(
                      'Catégories de prix',
                      style: AppTextStyle.largeindingotext,
                    ),
                    centerTitle: true,
                    actions: [
                      ActionButton(onPressed: () {}, text: "Reorganiser"),
                      ActionButton(
                        onPressed: () {
                          final container = ProviderScope.containerOf(context);
                          container
                              .read(drawerRiverpod.notifier)
                              .openCreateCategoriePrixDrawer(model);

                          _scaffoldKey.currentState?.openEndDrawer();
                        },
                        text: "Nouveau",
                      ),
                    ],
                  ),
                if (provider.selected != null)
                  Expanded(
                    child: CategorieDePrixDetails(
                      categorieDePrixModel: provider.selected!,
                      scaffoldKey: _scaffoldKey,
                    ),
                  )
                else
                  Expanded(child: _buildCategorieDePrixList(ref: ref)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategorieDePrixList({required WidgetRef ref}) {
    final state = ref.watch(categorieDePrixRiverpod);
    final notifier = ref.read(categorieDePrixRiverpod.notifier);
    return Container(
      color: Colors.grey.shade200,
      margin: const EdgeInsets.all(6),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            margin: const EdgeInsets.all(18),
            child: Column(
              children: [
                ...state.categories.map(
                  (categorie) => Column(
                    children: [
                      InkWell(
                        child: ListTile(
                          hoverColor: Colors.grey.shade200,
                          title: Text(
                            categorie.nom!,
                            style: AppTextStyle.indingoHeading,
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.indigo,
                          ),
                        ),
                        onTap: () {
                          notifier.select(categorie);
                        },
                      ),
                      categorie != state.categories.last
                          ? const Divider()
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

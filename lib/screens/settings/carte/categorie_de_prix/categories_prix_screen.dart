import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/models/categorie_de_prix_model.dart';
import 'package:restaurent/riverpods/drawer_riverpod/drawer_state.dart';
import 'package:restaurent/screens/reglage_screen.dart';
import 'package:restaurent/screens/settings/carte/categorie_de_modificateur/modificateurs_supplements_screen.dart';
import 'package:restaurent/screens/settings/carte/categorie_de_modificateur/produit_attachement.dart';
import 'package:restaurent/screens/settings/carte/categorie_de_prix/catgorie_detaits.dart';
import 'package:restaurent/widgets/salleMode_picker.dart';
import 'package:restaurent/widgets/widgets.dart';
import 'package:restaurent/consts.dart';

class CategoriesPrixScreen extends ConsumerStatefulWidget {
  const CategoriesPrixScreen({super.key});

  @override
  ConsumerState<CategoriesPrixScreen> createState() =>
      _CategoriesPrixScreenState();
}

class _CategoriesPrixScreenState extends ConsumerState<CategoriesPrixScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CategorieDePrixModel model = CategorieDePrixModel(
    nom: '',
    nomCourt: '',
    status: false,
    afficherNomCourtEnCommande: false,
    afficherNomCourtEnEncaissement: false,
    afficherNomCourtEnFabrication: false,
    actifDansTouteLaJournee: false,
    joursDactivite: [],
    salleIDS: [],
    heureDebut: const TimeOfDay(hour: 12, minute: 00),
    heureFin: const TimeOfDay(hour: 12, minute: 00),
    priorite: 1,
    jourFerie: false,
    produitsIds: [],
    salleMode: AffectationMode.POUR_TOUT,
    produitMode: AffectationMode.POUR_TOUT,
    actif: false,
    categorieActive: false,
  );

  @override
  Widget build(BuildContext context) {
    final categorieDePrixNotifier = ref.read(categorieDePrixRiverpod.notifier);
    final categoriePrixState = ref.watch(categorieDePrixRiverpod);
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

                    const SizedBox(height: 8),

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
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: m.priorite.toString(),
                      decoration: InputDecoration(
                        labelText: 'Priorite',
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
                            .updateCreateCategoriePrixModel(
                              m.copyWith(priorite: int.parse(v.toString())),
                            );
                      },
                    ),
                    const SizedBox(height: 8),
                    ...[
                      ['Actif', m.actif, (bool v) => m.copyWith(actif: v)],
                      [
                        'Activer catégorie',
                        m.categorieActive,
                        (bool v) => m.copyWith(categorieActive: v),
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
                      ['Status', m.status, (bool v) => m.copyWith(status: v)],
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
                    ],
                    const SizedBox(height: 8),

                    buildSalleModeDropdown(null, m, context),
                    const SizedBox(height: 8),

                    SalleIdsPicker(
                      salles: salles.salles,
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
                    SizedBox(height: 16),
                    CustomContainer(
                      child: CustomListTile(
                        leading: 'Prodtuid',
                        title: null,
                        trailing: null,
                        onTap: () {
                          categorieDePrixNotifier.openAttachmentScreen();
                          _scaffoldKey.currentState?.closeEndDrawer();
                        },
                        trailingwidget: null,
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
              case 'salle':
                return UpdateAttributeDrawer(
                  label: 'salle',
                  options: salles.salles,
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
      body:
          (categoriePrixState.selected == null &&
                  categoriePrixState.attachmentProductScreen)
              ? ProduitAttachement(
                scaffoldKey: _scaffoldKey,
                provider: categorieDePrixRiverpod,
              )
              : (categoriePrixState.selected == null &&
                  !categoriePrixState.attachmentProductScreen)
              ? _buildCategorieDePrixList(ref: ref)
              : (categoriePrixState.selected != null &&
                  !categoriePrixState.attachmentProductScreen)
              ? CategorieDePrixDetails(
                categorieDePrixModel: categoriePrixState.selected!,
                scaffoldKey: _scaffoldKey,
              )
              : SizedBox.shrink(),
    );
  }

  Widget _buildCategorieDePrixList({required WidgetRef ref}) {
    final state = ref.watch(categorieDePrixRiverpod);
    final notifier = ref.read(categorieDePrixRiverpod.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text('Catégories de prix', style: AppTextStyle.indingoHeading),
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
      body: Container(
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
      ),
    );
  }
}

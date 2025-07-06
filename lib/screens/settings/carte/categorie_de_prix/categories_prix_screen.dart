import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:restaurent/blocs/drawer/drawer_bloc.dart';
import 'package:restaurent/models/categorie_de_prix_model.dart';
import 'package:restaurent/models/salle_model.dart';
import 'package:restaurent/providers/categorie_de_prix_provider.dart';
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
    status: false,
    afficherNomCourtEnCommande: false,
    afficherNomCourtEnEncaissement: false,
    afficherNomCourtEnFabrication: false,
    actifDansTouteLaJournee: false,
    categorieDePrixActive: false,
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
      endDrawer: BlocBuilder<DrawerBloc, DrawerState>(
        builder: (context, state) {
          if (state is DrawerCreateCategoriePrix) {
            final m = state.model;
            return Drawer(
              width: MediaQuery.of(context).size.width * 0.3,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Créer une nouvelle catégorie de prix',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      initialValue: m.nom,
                      decoration: InputDecoration(
                        labelText: 'Nom',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      onChanged: (v) {
                        context.read<DrawerBloc>().add(
                          UpdateCreateCategoriePrixModel(m.copyWith(nom: v)),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Nom court
                    TextFormField(
                      initialValue: m.nomCourt,
                      decoration: InputDecoration(
                        labelText: 'Nom court',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      onChanged: (v) {
                        context.read<DrawerBloc>().add(
                          UpdateCreateCategoriePrixModel(
                            m.copyWith(nomCourt: v),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Switches
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
                        'Catégorie active',
                        m.categorieDePrixActive,
                        (bool v) => m.copyWith(categorieDePrixActive: v),
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
                              leading: null,
                              trailing: null,
                              title: Text(label),
                              trailingwidget: Switch(
                                activeColor: AppColors.primary,
                                value: value,
                                onChanged: (v) {
                                  context.read<DrawerBloc>().add(
                                    UpdateCreateCategoriePrixModel(copy(v)),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      );
                    }),

                    // Plages horaires si ni journée ni nuit
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
                            style: AppTextStyle.greysubHeading,
                          ),
                          trailing: Text(
                            m.heureDebut?.format(context) ?? '--:--',
                          ),
                          onTap: () async {
                            final t = await showTimePicker(
                              context: context,
                              initialTime: m.heureDebut ?? TimeOfDay.now(),
                            );
                            if (t != null) {
                              context.read<DrawerBloc>().add(
                                UpdateCreateCategoriePrixModel(
                                  m.copyWith(heureDebut: t),
                                ),
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
                            style: AppTextStyle.greysubHeading,
                          ),
                          trailing: Text(
                            m.heureFin?.format(context) ?? '--:--',
                          ),
                          onTap: () async {
                            final t = await showTimePicker(
                              context: context,
                              initialTime: m.heureFin ?? TimeOfDay.now(),
                            );
                            if (t != null) {
                              context.read<DrawerBloc>().add(
                                UpdateCreateCategoriePrixModel(
                                  m.copyWith(heureFin: t),
                                ),
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
                        context.read<DrawerBloc>().add(
                          UpdateCreateCategoriePrixModel(
                            m.copyWith(salleIDS: selectedIds),
                          ),
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
                          const Text('Jours d\'activite'),
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
                                  label: Text(d.toString()),
                                  selected: selected,
                                  selectedColor: AppColors.indingo200,
                                  onSelected: (sel) {
                                    final jours = List<String>.from(
                                      m.joursDactivite!,
                                    );
                                    sel
                                        ? jours.add(d.toString())
                                        : jours.remove(d);
                                    context.read<DrawerBloc>().add(
                                      UpdateCreateCategoriePrixModel(
                                        m.copyWith(joursDactivite: jours),
                                      ),
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
                        // Utilisation du Provider au lieu du BLoC
                        final provider =
                            context.read<CategorieDePrixProvider>();
                        provider.create(m);
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
                    final provider = context.read<CategorieDePrixProvider>();
                    provider.update(state.model.copyWith(nom: v));
                  },
                );

              case 'nom court':
                return UpdateAttributeDrawer(
                  label: 'nom court',
                  initialValue: state.model.nomCourt,
                  fieldType: FieldType.string,
                  onSaved: (v) {
                    final provider = context.read<CategorieDePrixProvider>();
                    provider.update(state.model.copyWith(nom: v));
                  },
                );

              case 'categorie de prix':
                return UpdateAttributeDrawer(
                  label: 'categorie de prix',
                  initialValue: state.model.categorieDePrixActive,
                  fieldType: FieldType.boolean,
                  onSaved: (v) {
                    final provider = context.read<CategorieDePrixProvider>();
                    provider.update(
                      state.model.copyWith(categorieDePrixActive: v),
                    );
                  },
                );
              case 'Afficher nom court en commande':
                return UpdateAttributeDrawer(
                  label: 'Afficher nom court en commande',
                  initialValue: state.model.afficherNomCourtEnCommande,
                  fieldType: FieldType.boolean,
                  onSaved: (v) {
                    final provider = context.read<CategorieDePrixProvider>();
                    provider.update(
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
                    final provider = context.read<CategorieDePrixProvider>();
                    provider.update(
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
                    final provider = context.read<CategorieDePrixProvider>();
                    provider.update(state.model.copyWith(salleIDS: v));
                  },
                );
              case 'Afficher nom court en fabrication':
                return UpdateAttributeDrawer(
                  label: 'Afficher nom court en fabrication',
                  initialValue: state.model.afficherNomCourtEnFabrication,
                  fieldType: FieldType.boolean,
                  onSaved: (v) {
                    final provider = context.read<CategorieDePrixProvider>();
                    provider.update(
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
                    final provider = context.read<CategorieDePrixProvider>();
                    provider.update(state.model.copyWith(joursDactivite: v));
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
        child: Consumer<CategorieDePrixProvider>(
          builder: (context, provider, _) {
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
                        provider.clearSelection();
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
                          context.read<DrawerBloc>().add(
                            OpenCreateCategoriePrixDrawer(model: model),
                          );
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
                  Expanded(
                    child: _buildCategorieDePrixList(provider: provider),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategorieDePrixList({
    required CategorieDePrixProvider provider,
  }) {
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
                ...provider.categories.map(
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
                          provider.select(categorie);
                        },
                      ),
                      categorie != provider.categories.last
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

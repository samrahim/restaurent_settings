import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent/blocs/categorie_de_prix_bloc/categorie_de_prix_bloc.dart';
import 'package:restaurent/blocs/drawer/drawer_bloc.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/categorie_de_prix_model.dart';
import 'package:restaurent/screens/settings/carte/categorie_de_prix/catgorie_detaits.dart';
import 'package:restaurent/screens/widgets/action_button.dart';
import 'package:restaurent/screens/widgets/button_supprimer.dart';
import 'package:restaurent/screens/widgets/create_button.dart';
import 'package:restaurent/screens/widgets/custom_list_tile.dart';

class CategoriesPrixScreen extends StatelessWidget {
  const CategoriesPrixScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DrawerBloc()),
        BlocProvider(create: (context) => CategorieDePrixBloc()),
      ],
      child: CategoriesPrixScreenView(),
    );
  }
}

class CategoriesPrixScreenView extends StatefulWidget {
  const CategoriesPrixScreenView({super.key});

  @override
  State<CategoriesPrixScreenView> createState() =>
      _CategoriesPrixScreenViewState();
}

class _CategoriesPrixScreenViewState extends State<CategoriesPrixScreenView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CategorieDePrixModel model = CategorieDePrixModel(
    produits: [],
    id: categoriesPrix.length.toString(),
    nom: '',
    nomCourt: '',
    status: false,
    afficherNomCourtEnCommande: false,
    afficherNomCourtEnEncaissement: false,
    afficherNomCourtEnFabrication: false,
    actifDansTouteLaJournee: false,
    categorieDePrixActive: false,
    joursDactivite: [],
    salle: salles.first,
    heureDebut: TimeOfDay(hour: 12, minute: 00),
    heureFin: TimeOfDay(hour: 12, minute: 00),
  );
  TextEditingController nom = TextEditingController();
  TextEditingController nomCourt = TextEditingController();
  String salle = salles.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: BlocBuilder<DrawerBloc, DrawerState>(
        builder: (context, state) {
          if (state is! DrawerCreateCategoriePrix)
            return const SizedBox.shrink();
          final m = state.model;

          return Drawer(
            width: MediaQuery.of(context).size.width * 0.3,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Nouvelle catégorie de prix',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),

                    // Nom
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

                    // Salle
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: ListTile(
                        title: const Text('Disponible dans les salles'),
                        trailing: DropdownButton<String>(
                          style: AppTextStyle.indingosubHeading,
                          value: m.salle,
                          underline: const SizedBox(),
                          items:
                              salles
                                  .map(
                                    (s) => DropdownMenuItem(
                                      value: s,
                                      child: Text(s),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (v) {
                            if (v == null) return;
                            context.read<DrawerBloc>().add(
                              UpdateCreateCategoriePrixModel(
                                m.copyWith(salle: v),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Switches
                    ...[
                      [
                        'Activer catégorie',
                        m.status,
                        (bool v) => m.copyWith(status: v),
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
                    if (!m.actifDansTouteLaJournee) ...[
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

                    // Jours d'activité (chips scrollables)
                    const Text('Jours d’activité'),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            const [
                              'Lundi',
                              'Mardi',
                              'Mercredi',
                              'Jeudi',
                              'Vendredi',
                              'Samedi',
                              'Dimanche',
                            ].length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (_, i) {
                          final d =
                              const [
                                'Lundi',
                                'Mardi',
                                'Mercredi',
                                'Jeudi',
                                'Vendredi',
                                'Samedi',
                                'Dimanche',
                              ][i];
                          final selected = m.joursDactivite.contains(d);
                          return ChoiceChip(
                            label: Text(d),
                            selected: selected,
                            selectedColor: AppColors.indingo200,
                            onSelected: (sel) {
                              final jours = List<String>.from(m.joursDactivite);
                              sel ? jours.add(d) : jours.remove(d);
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

                    const SizedBox(height: 24),
                    CreateButton(
                      onPressed: () {
                        context.read<CategorieDePrixBloc>().add(
                          CreateCategorieDePrix(categorieDePrixModel: m),
                        );
                        _scaffoldKey.currentState?.closeEndDrawer();
                      },
                      buttonText: "Créer la catégorie",
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      body: BlocBuilder<CategorieDePrixBloc, CategorieDePrixState>(
        builder: (context, state) {
          if (state is CategorieDePrixInitial &&
              state.selectedCategorie == null) {
            return _buildCategorieDePrixList(
              context: context,
              data: state.categories,
            );
          }
          if (state is CategorieDePrixInitial &&
              state.selectedCategorie != null) {
            return buildCategorieDePrixDetails(
              context: context,
              model: state.selectedCategorie!,
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  _buildCategorieDePrixList({
    required BuildContext context,
    required List<CategorieDePrixModel> data,
  }) {
    return Container(
      color: Colors.grey.shade200,
      margin: EdgeInsets.all(6),
      child: Column(
        children: [
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),

            margin: EdgeInsets.all(18),
            child: Column(
              children: [
                ...data.map(
                  (categorie) => Column(
                    children: [
                      InkWell(
                        child: ListTile(
                          hoverColor: Colors.grey.shade200,

                          title: Text(
                            categorie.nom,
                            style: AppTextStyle.indingoHeading,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.indigo,
                          ),
                        ),
                        onTap: () {
                          context.read<CategorieDePrixBloc>().add(
                            SelectCategoriDePrix(model: categorie),
                          );
                        },
                      ),
                      categorie != data.last ? Divider() : SizedBox(),
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

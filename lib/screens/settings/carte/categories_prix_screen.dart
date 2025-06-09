import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent/blocs/categorie_de_prix_bloc/categorie_de_prix_bloc.dart';
import 'package:restaurent/blocs/drawer/drawer_bloc.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/categorie_de_prix_model.dart';
import 'package:restaurent/screens/widgets/action_button.dart';

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
  String? nom, nomCourt, salle;
  bool status = true;
  bool afficherCommande = false;
  bool afficherEncaissement = false;
  bool afficherFabrication = false;
  bool actifJour = true, actifNuit = false, categorieActive = true;
  List<String> jours = [];
  TimeOfDay? debut, fin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: BlocBuilder<DrawerBloc, DrawerState>(
        builder: (context, state) {
          if (state is DrawerCreateCategoriePrix) {
            return Drawer(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                children: [
                  // Name inputs
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nom *',
                      hintText: 'Entrer le nom',
                    ),
                    validator:
                        (v) => (v?.isEmpty ?? true) ? 'Champ requis' : null,
                    onSaved: (v) => nom = v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nom court'),
                    onSaved: (v) => nomCourt = v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Salle'),
                    onSaved: (v) => salle = v,
                  ),
                  const SizedBox(height: 16),

                  // Toggles
                  ..._buildSwitch(
                    "Activer catégorie",
                    status,
                    (v) => setState(() => status = v),
                  ),
                  ..._buildSwitch(
                    "Afficher nom court (Commande)",
                    afficherCommande,
                    (v) => setState(() => afficherCommande = v),
                  ),
                  ..._buildSwitch(
                    "Afficher nom court (Encaissement)",
                    afficherEncaissement,
                    (v) => setState(() => afficherEncaissement = v),
                  ),
                  ..._buildSwitch(
                    "Afficher nom court (Fabrication)",
                    afficherFabrication,
                    (v) => setState(() => afficherFabrication = v),
                  ),
                  ..._buildSwitch(
                    "Actif toute la journée",
                    actifJour,
                    (v) => setState(() {
                      actifJour = v;
                      if (v) {
                        actifNuit = false;
                        debut = fin = null;
                      }
                    }),
                  ),
                  ..._buildSwitch(
                    "Actif toute la nuit",
                    actifNuit,
                    (v) => setState(() {
                      actifNuit = v;
                      if (v) {
                        actifJour = false;
                        debut = fin = null;
                      }
                    }),
                  ),
                  ..._buildSwitch(
                    "Catégorie active",
                    categorieActive,
                    (v) => setState(() => categorieActive = v),
                  ),
                  const SizedBox(height: 16),

                  // Time selection
                  if (!(actifJour || actifNuit)) ...[
                    _buildTimePicker(
                      'Heure début',
                      debut,
                      (time) => setState(() => debut = time),
                    ),
                    _buildTimePicker(
                      'Heure fin',
                      fin,
                      (time) => setState(() => fin = time),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Days selector
                  _buildDaysChips(),

                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Créer la catégorie'),
                  ),
                ],
              ),
            );
          }

          return SizedBox.shrink();
        },
      ),
      body: BlocBuilder<CategorieDePrixBloc, CategorieDePrixState>(
        builder: (context, state) {
          if (state is CategorieDePrixInitial &&
              state.selectedCategorie == null) {
            return _buildCategorieDePrixList(context: context);
          }
          if (state is CategorieDePrixInitial &&
              state.selectedCategorie != null) {
            return _buildCategorieDePrixDetails(
              model: state.selectedCategorie!,
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildDaysChips() {
    const days = [
      'Lundi',
      'Mardi',
      'Mercredi',
      'Jeudi',
      'Vendredi',
      'Samedi',
      'Dimanche',
    ];
    return Wrap(
      spacing: 8,
      children:
          days.map((d) {
            final selected = jours.contains(d);
            return ChoiceChip(
              label: Text(d),
              selected: selected,
              onSelected:
                  (sel) => setState(() {
                    sel ? jours.add(d) : jours.remove(d);
                  }),
            );
          }).toList(),
    );
  }

  Iterable<Widget> _buildSwitch(
    String label,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
      const SizedBox(height: 8),
    ];
  }

  Widget _buildTimePicker(
    String label,
    TimeOfDay? time,
    ValueChanged<TimeOfDay> onPicked,
  ) {
    return ListTile(
      title: Text(label),
      trailing: Text(time != null ? time.format(context) : '--:--'),
      onTap: () async {
        final t = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (t != null) onPicked(t);
      },
    );
  }

  _buildCategorieDePrixDetails({required CategorieDePrixModel model}) {
    return Column(
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
      ],
    );
  }

  _buildCategorieDePrixList({required BuildContext context}) {
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
                    OpenCreateCategoriePrixDrawer(),
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
                ...categoriesPrix.map(
                  (e) => Column(
                    children: [
                      InkWell(
                        child: ListTile(
                          hoverColor: Colors.grey.shade200,

                          title: Text(
                            e.nom,
                            style: AppTextStyle.indingoHeading,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.indigo,
                          ),
                        ),
                        onTap: () {
                          context.read<CategorieDePrixBloc>().add(
                            SelectCategoriDePrix(model: e),
                          );
                        },
                      ),
                      e != categoriesPrix.last ? Divider() : SizedBox(),
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

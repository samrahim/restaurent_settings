import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurent/blocs/drawer/drawer_bloc.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/categorie_de_modificateur.dart';
import 'package:restaurent/screens/settings/carte/modificteur_details.dart';
import 'package:restaurent/screens/widgets/create_button.dart';
import 'package:restaurent/screens/widgets/show_picket.dart';
import 'package:restaurent/screens/widgets/widgets.dart';

class ModificateursSupplementsScreen extends StatelessWidget {
  const ModificateursSupplementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DrawerBloc(),
      child: ModificateursSupplementsScreenView(),
    );
  }
}

class ModificateursSupplementsScreenView extends StatefulWidget {
  const ModificateursSupplementsScreenView({super.key});

  @override
  State<ModificateursSupplementsScreenView> createState() =>
      _ModificateursSupplementsScreenViewState();
}

class _ModificateursSupplementsScreenViewState
    extends State<ModificateursSupplementsScreenView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController name = TextEditingController();
  String? selectedCategory;
  CategorieDeModificateur modificateur = CategorieDeModificateur(
    id: '',
    color: Colors.pink,
    icon: null,
    nom: '',
    obligatoire: true,
    typeDeSalleDisponible: salles[0],
    typeDeSelection: optiontypeDeSelection[0],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: BlocBuilder<DrawerBloc, DrawerState>(
        builder: (context, state) {
          if (state is DrawerCreateCategorieDeModificateur) {
            final createModel = state.modificateur;
            return Drawer(
              width: MediaQuery.of(context).size.width * .33,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Créer une nouvelle categorie',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      onChanged: (value) {
                        createModel.copyWith(nom: value);
                      },
                      decoration: InputDecoration(
                        labelText: 'Nom',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: ListTile(
                        title: const Text('Disponible dans les salles'),
                        trailing: DropdownButton<String>(
                          underline: SizedBox(),
                          value: createModel.typeDeSalleDisponible,
                          style: AppTextStyle.indingosubHeading,
                          items:
                              salles
                                  .map(
                                    (v) => DropdownMenuItem(
                                      value: v,
                                      child: Text(v),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (v) {
                            if (v != null) {
                              final updated = createModel.copyWith(
                                typeDeSalleDisponible: v,
                              );
                              context.read<DrawerBloc>().add(
                                OpenCreateCategorieDeModificateur(
                                  modificateur: updated,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: ListTile(
                        trailing: InkWell(
                          onTap: () {
                            openColorPicker(
                              context: context,
                              currentColor: createModel.color ?? Colors.pink,
                              onColorSelected: (Color selectedColor) {
                                final updated = createModel.copyWith(
                                  color: selectedColor,
                                );
                                context.read<DrawerBloc>().add(
                                  OpenCreateCategorieDeModificateur(
                                    modificateur: updated,
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 12,
                            width: 12,
                            color: createModel.color,
                          ),
                        ),
                        title: Text('Couleur'),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: ListTile(
                        title: const Text('Type de selection'),
                        trailing: DropdownButton<String>(
                          underline: SizedBox(),
                          value: createModel.typeDeSelection,
                          style: AppTextStyle.indingosubHeading,
                          items:
                              optiontypeDeSelection
                                  .map(
                                    (v) => DropdownMenuItem(
                                      value: v,
                                      child: Text(v),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (v) {
                            if (v != null) {
                              final updated = createModel.copyWith(
                                typeDeSelection: v,
                              );
                              context.read<DrawerBloc>().add(
                                OpenCreateCategorieDeModificateur(
                                  modificateur: updated,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: ListTile(
                        title: Text('Obligatoire'),
                        trailing: Switch(
                          activeColor: AppColors.primary,
                          value: createModel.obligatoire!,
                          onChanged: (value) {
                            final updated = createModel.copyWith(
                              obligatoire: value,
                            );
                            context.read<DrawerBloc>().add(
                              OpenCreateCategorieDeModificateur(
                                modificateur: updated,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    CreateButton(
                      onPressed: () {},
                      buttonText: 'Cree une nouvelle categorie de prix',
                    ),
                  ],
                ),
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Column(
          children: [
            selectedCategory != null
                ? AppBar(
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title: Text(
                    selectedCategory!,
                    style: AppTextStyle.indingoHeading,
                  ),
                  actions: [SizedBox()],
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      setState(() {
                        selectedCategory = null;
                      });
                    },
                  ),
                )
                : AppBar(
                  actions: [
                    ActionButton(onPressed: () {}, text: 'Reorganiser'),
                    ActionButton(
                      onPressed: () {
                        context.read<DrawerBloc>().add(
                          OpenCreateCategorieDeModificateur(
                            modificateur: modificateur,
                          ),
                        );
                        _scaffoldKey.currentState?.openEndDrawer();
                      },
                      text: 'Nouveau',
                    ),
                  ],
                  centerTitle: true,
                  title: Text(
                    'Categories de modificateurs / Supplements ',
                    style: AppTextStyle.largeindingotext,
                  ),
                ),
            Expanded(
              child:
                  selectedCategory == null
                      ? _buildCategoriesList()
                      : ModificateurDetails(categoryName: selectedCategory!),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesList() {
    return Container(
      color: Colors.grey.shade200,
      margin: EdgeInsets.all(6),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),

            margin: EdgeInsets.all(18),
            child: Column(
              children: [
                ...categories_de_modificateurs.map(
                  (e) => Column(
                    children: [
                      GestureDetector(
                        child: ListTile(
                          title: Text(e, style: AppTextStyle.indingoHeading),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.indigo,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selectedCategory = e;
                          });
                        },
                      ),
                      e != categories_de_modificateurs.last
                          ? Divider()
                          : SizedBox(),
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

List<String> categories_de_modificateurs = [
  "Cuisson",
  "Sauces",
  "Supplements payants",
  "Accompagnement",
  "Glaces",
];

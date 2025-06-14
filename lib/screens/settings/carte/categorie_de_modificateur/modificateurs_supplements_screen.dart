import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent/blocs/categorie_de_modificateur_bloc/categorie_modificateur_bloc.dart';
import 'package:restaurent/blocs/drawer/drawer_bloc.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/categorie_de_modificateur.dart';
import 'package:restaurent/screens/settings/carte/categorie_de_modificateur/modificteur_details.dart';
import 'package:restaurent/screens/widgets/create_button.dart';
import 'package:restaurent/screens/widgets/show_picket.dart';
import 'package:restaurent/screens/widgets/widgets.dart';

class ModificateursSupplementsScreen extends StatelessWidget {
  const ModificateursSupplementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DrawerBloc()),
        BlocProvider(create: (context) => CategorieModificateurBloc()),
      ],
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
                      controller: name,
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
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: createModel.color,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black26),
                            ),
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
                      onPressed: () {
                        context.read<CategorieModificateurBloc>().add(
                          CreateNewCategorieDeModificateur(
                            modificateur: createModel.copyWith(nom: name.text),
                          ),
                        );

                        _scaffoldKey.currentState?.closeEndDrawer();
                      },
                      buttonText: 'Cree une nouvelle categorie de prix',
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is DrawerUpdateCategorieDeModificateur) {
            print('hw');
            switch (state.attributeName) {
              case 'nom':
                return UpdateAttributeDrawer(
                  fieldType: FieldType.string,
                  label: 'nom',
                  initialValue: state.modificateur.nom!,
                  onSaved:
                      (v) => context.read<CategorieModificateurBloc>().add(
                        UpdateCategorieDeModificateur(
                          modificateur: state.modificateur.copyWith(nom: v),
                        ),
                      ),
                );
              case 'salle':
                return UpdateAttributeDrawer(
                  fieldType: FieldType.dropdown,
                  label: 'Salle',
                  options: salles,
                  initialValue: state.modificateur.typeDeSalleDisponible!,
                  onSaved:
                      (v) => context.read<CategorieModificateurBloc>().add(
                        UpdateCategorieDeModificateur(
                          modificateur: state.modificateur.copyWith(
                            typeDeSalleDisponible: v,
                          ),
                        ),
                      ),
                );
              case 'couleur':
                return UpdateAttributeDrawer(
                  fieldType: FieldType.color,
                  label: 'Couleur',

                  initialValue: state.modificateur.color!,
                  onSaved:
                      (v) => context.read<CategorieModificateurBloc>().add(
                        UpdateCategorieDeModificateur(
                          modificateur: state.modificateur.copyWith(color: v),
                        ),
                      ),
                );
              case 'typeDeSelection':
                return UpdateAttributeDrawer(
                  fieldType: FieldType.dropdown,
                  label: 'Type de selection',
                  options: optiontypeDeSelection,
                  initialValue: state.modificateur.typeDeSelection!,
                  onSaved:
                      (v) => context.read<CategorieModificateurBloc>().add(
                        UpdateCategorieDeModificateur(
                          modificateur: state.modificateur.copyWith(
                            typeDeSelection: v,
                          ),
                        ),
                      ),
                );
              case 'obligatoire':
                return UpdateAttributeDrawer(
                  fieldType: FieldType.boolean,
                  label: 'Obligatoire',
                  options: ['true', 'false'],
                  initialValue: state.modificateur.obligatoire!,
                  onSaved:
                      (v) => context.read<CategorieModificateurBloc>().add(
                        UpdateCategorieDeModificateur(
                          modificateur: state.modificateur.copyWith(
                            obligatoire: v,
                          ),
                        ),
                      ),
                );

              default:
                return const SizedBox.shrink();
            }
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      body: Container(
        color: Colors.grey.shade200,
        child:
            BlocBuilder<CategorieModificateurBloc, CategorieModificateurState>(
              builder: (context, state) {
                return Column(
                  children: [
                    if (state is CategorieModificateurInitial &&
                        state.selectedCategorie != null)
                      AppBar(
                        backgroundColor: Colors.white,
                        centerTitle: true,
                        title: Text(
                          state.selectedCategorie!.nom!,
                          style: AppTextStyle.indingoHeading,
                        ),
                        actions: [SizedBox()],
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            context.read<CategorieModificateurBloc>().add(
                              DeselectCategorie(),
                            );
                            print((state).selectedCategorie);
                          },
                        ),
                      )
                    else
                      AppBar(
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
                    if (state is CategorieModificateurInitial &&
                        state.selectedCategorie != null)
                      Expanded(
                        child: ModificateurDetails(
                          modificateur: state.selectedCategorie!,
                          categoryName: state.selectedCategorie!.nom!,
                          scaffoldKey: _scaffoldKey,
                        ),
                      )
                    else
                      Expanded(
                        child: _buildCategoriesList(
                          state as CategorieModificateurInitial,
                        ),
                      ),
                  ],
                );
              },
            ),
      ),
    );
  }

  Widget _buildCategoriesList(CategorieModificateurInitial state) {
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
                ...state.allcategories.map(
                  (e) => Column(
                    children: [
                      GestureDetector(
                        child: ListTile(
                          title: Text(
                            e.nom!,
                            style: AppTextStyle.indingoHeading,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.indigo,
                          ),
                        ),
                        onTap: () {
                          context.read<CategorieModificateurBloc>().add(
                            SelectCategorie(modificateur: e),
                          );
                        },
                      ),
                      e != state.allcategories.last ? Divider() : SizedBox(),
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

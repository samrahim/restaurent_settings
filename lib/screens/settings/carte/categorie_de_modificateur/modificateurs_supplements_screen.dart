import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:restaurent/blocs/drawer/drawer_bloc.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/models.dart';
import 'package:restaurent/providers/providers.dart';
import 'package:restaurent/screens/settings/carte/categorie_de_modificateur/modificteur_details.dart';
import 'package:restaurent/widgets/widgets.dart';

class ModificateursSupplementsScreen extends StatefulWidget {
  const ModificateursSupplementsScreen({super.key});

  @override
  State<ModificateursSupplementsScreen> createState() =>
      _ModificateursSupplementsScreenState();
}

class _ModificateursSupplementsScreenState
    extends State<ModificateursSupplementsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController name = TextEditingController();
  TextEditingController prix = TextEditingController();
  TextEditingController supplement = TextEditingController();

  CategorieDeModificateur modificateur = CategorieDeModificateur(
    id: '',
    color: '',
    icone: '',
    nom: '',
    obligatoire: true,
    sallesIDS: [],
    typeSelection: optiontypeDeSelection[0],
    modificateurs: [],
    produitsIds: [],
    affectationMode: AffectationMode.Pour_tout,
    salleIds: [],
  );

  TauxTvaModel tvaModel = tauxTvaList[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _endDrawer(),
      drawer: BlocBuilder<DrawerBloc, DrawerState>(
        builder: (context, state) {
          if (state is DrawerCreateSubCategorieDeModificateur) {
            return Drawer(
              width: MediaQuery.of(context).size.width * .33,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Créer une nouvelle sous-catégorie',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: supplement,

                          decoration: InputDecoration(
                            labelText: 'Nom',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: prix,

                          decoration: InputDecoration(
                            labelText: 'Prix',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<TauxTvaModel>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.greyaccent!,
                              ),
                            ),
                            labelText: 'Selectionner TVA',
                          ),
                          value: tvaModel,
                          items:
                              context.read<TauxEtTvaProvider>().tauxTvas.map((
                                item,
                              ) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item.tauxTva.toString()),
                                );
                              }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                tvaModel = value;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    CreateButton(
                      onPressed: () {
                        context.read<CategorieModificateurProvider>().update(
                          state.modificateur.copyWith(
                            modificateurs: [
                              ...state.modificateur.modificateurs,
                              SubCategorieDeModificateur(
                                id:
                                    (state.modificateur.modificateurs.length +
                                            1)
                                        .toString(),
                                nom: supplement.text,
                                prix: double.tryParse(prix.text) ?? 0.0,
                                tvaValue: tauxTvaList[1].tauxTva ?? 0.0,
                                actif: true,
                              ),
                            ],
                          ),
                        );

                        supplement.clear();
                        prix.clear();

                        _scaffoldKey.currentState?.closeDrawer();
                      },
                      buttonText:
                          'Créer une nouvelle sous-catégorie de modificateurs',
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Consumer<CategorieModificateurProvider>(
          builder: (context, provider, _) {
            return Column(
              children: [
                if (provider.selectedCategorie != null)
                  AppBar(
                    backgroundColor: Colors.white,
                    centerTitle: true,
                    title: Text(
                      provider.selectedCategorie!.nom!,
                      style: AppTextStyle.indingoHeading,
                    ),
                    actions: [const SizedBox()],
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        provider.deselect();
                      },
                    ),
                  )
                else
                  AppBar(
                    leading: SizedBox.shrink(),
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
                if (provider.selectedCategorie != null)
                  Expanded(
                    child: ModificateurDetails(
                      modificateur: provider.selectedCategorie!,

                      scaffoldKey: _scaffoldKey,
                    ),
                  )
                else
                  Expanded(child: _buildCategoriesList(provider)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoriesList(CategorieModificateurProvider provider) {
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
                ...provider.allcategories.map(
                  (e) => Column(
                    children: [
                      GestureDetector(
                        child: ListTile(
                          title: Text(
                            e.nom!,
                            style: AppTextStyle.indingoHeading,
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.indigo,
                          ),
                        ),
                        onTap: () {
                          provider.select(e);
                        },
                      ),
                      e != provider.allcategories.last
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

  Widget _endDrawer() {
    return BlocBuilder<DrawerBloc, DrawerState>(
      builder: (context, state) {
        if (state is DrawerCreateCategorieDeModificateur) {
          final createModel = state.modificateur;
          return Drawer(
            width: MediaQuery.of(context).size.width * .33,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: name,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Nom de la categorie est requis';
                      }
                      return null;
                    },
                    hint: 'Nom',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),

                  const SizedBox(height: 16),
                  SalleIdsPicker(
                    salles: salles,
                    selectedSalleIds: createModel.sallesIDS!,
                    onSelectionChanged: (updatedSalleIds) {
                      final updated = createModel.copyWith(
                        sallesIDS: updatedSalleIds,
                      );
                      context.read<DrawerBloc>().add(
                        OpenCreateCategorieDeModificateur(
                          modificateur: updated,
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
                    child: ListTile(
                      trailing: InkWell(
                        onTap: () {
                          openColorPicker(
                            context: context,
                            currentColor: Colors.pink,
                            onColorSelected: (Color selectedColor) {
                              final updated = createModel.copyWith(color: '');
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
                            color: Colors.pink,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black26),
                          ),
                        ),
                      ),
                      title: const Text('Couleur'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ListTile(
                      title: const Text('Type de selection'),
                      trailing: DropdownButton<String>(
                        underline: const SizedBox(),
                        value: createModel.typeSelection,
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
                              typeSelection: v,
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
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ListTile(
                      title: const Text('Affectation mode'),
                      trailing: DropdownButton<AffectationMode>(
                        underline: const SizedBox(),
                        value: createModel.affectationMode,
                        style: AppTextStyle.indingosubHeading,
                        items:
                            AffectationMode.values
                                .map(
                                  (v) => DropdownMenuItem(
                                    value: v,
                                    child: Text(v.name),
                                  ),
                                )
                                .toList(),
                        onChanged: (v) {
                          if (v != null) {
                            final updated = createModel.copyWith(
                              affectationMode: v,
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
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ListTile(
                      title: const Text('Obligatoire'),
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
                  const SizedBox(height: 32),
                  CreateButton(
                    onPressed: () {
                      // Utilisation du Provider pour créer la catégorie
                      final provider =
                          context.read<CategorieModificateurProvider>();
                      provider.create(createModel.copyWith(nom: name.text));
                      _scaffoldKey.currentState?.closeEndDrawer();
                    },
                    buttonText: 'Créer une nouvelle catégorie de prix',
                  ),
                ],
              ),
            ),
          );
        }
        if (state is DrawerUpdateCategorieDeModificateur) {
          switch (state.attributeName) {
            case 'nom':
              return UpdateAttributeDrawer(
                fieldType: FieldType.string,
                label: 'nom',
                initialValue: state.modificateur.nom,
                onSaved: (v) {
                  final provider =
                      context.read<CategorieModificateurProvider>();
                  provider.update(state.modificateur.copyWith(nom: v));
                },
              );
            case 'affectaionMode':
              return UpdateAttributeDrawer(
                fieldType: FieldType.dropdown,
                label: 'Affectation mode',
                options:
                    AffectationMode.values.map((mode) {
                      return mode.name.replaceAll('_', ' ');
                    }).toList(),
                initialValue:
                    state.modificateur.affectationMode?.name.replaceAll(
                      '_',
                      ' ',
                    ) ??
                    AffectationMode.Pour_tout.name.replaceAll('_', ' '),
                onSaved: (v) {
                  final provider =
                      context.read<CategorieModificateurProvider>();
                  final updatedMode = AffectationMode.values.firstWhere(
                    (mode) => mode.name.replaceAll('_', ' ') == v,
                    orElse: () => AffectationMode.Pour_tout, // Default fallback
                  );
                  provider.update(
                    state.modificateur.copyWith(affectationMode: updatedMode),
                  );
                },
              );
            case 'salle':
              return UpdateAttributeDrawer(
                fieldType: FieldType.choice,
                label: 'Salle',
                options: salles,
                initialValue: state.modificateur.sallesIDS,
                onSaved: (v) {
                  final provider =
                      context.read<CategorieModificateurProvider>();
                  provider.update(state.modificateur.copyWith(sallesIDS: v));
                },
              );
            case 'couleur':
              return UpdateAttributeDrawer(
                fieldType: FieldType.color,
                label: 'Couleur',
                initialValue: state.modificateur.color!,
                onSaved: (v) {
                  final provider =
                      context.read<CategorieModificateurProvider>();
                  provider.update(state.modificateur.copyWith(color: v));
                },
              );
            case 'typeDeSelection':
              return UpdateAttributeDrawer(
                fieldType: FieldType.dropdown,
                label: 'Type de selection',
                options: optiontypeDeSelection,
                initialValue: state.modificateur.typeSelection!.replaceAll(
                  '_',
                  ' ',
                ),
                onSaved: (v) {
                  final provider =
                      context.read<CategorieModificateurProvider>();
                  provider.update(
                    state.modificateur.copyWith(typeSelection: v),
                  );
                },
              );
            case 'obligatoire':
              return UpdateAttributeDrawer(
                fieldType: FieldType.boolean,
                label: 'Obligatoire',
                options: ['true', 'false'],
                initialValue: state.modificateur.obligatoire!,
                onSaved: (v) {
                  final provider =
                      context.read<CategorieModificateurProvider>();
                  provider.update(state.modificateur.copyWith(obligatoire: v));
                },
              );

            default:
              return const SizedBox.shrink();
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

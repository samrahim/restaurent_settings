import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
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
    couleur: '',
    icone: '',
    nom: '',
    obligatoire: true,
    sallesIDS: [],
    typeSelection: optiontypeDeSelection[0],
    modificateurs: [],
    produitsIds: [],
    salleMode: SalleMode.Pour_tout,
    produitMode: SalleMode.Pour_tout,
  );

  TauxTvaModel tvaModel = tauxTvaList[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _endDrawer(),

      drawer: Consumer<DrawerProvider>(
        builder: (context, drawerProvider, _) {
          final state = drawerProvider.state;
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
                          context
                              .read<DrawerProvider>()
                              .openCreateCategorieDeModificateur(modificateur);

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
    return Consumer<DrawerProvider>(
      builder: (context, drawerProvider, _) {
        final state = drawerProvider.state;

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
                  Text(
                    'Créer une nouvelle categorie',
                    style: AppTextStyle.indingoHeading,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: 'Nom',
                      labelStyle: AppTextStyle.indingosubHeading,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: Text(
                      'Couleur',
                      style: AppTextStyle.indingosubHeading,
                    ),
                    trailing: InkWell(
                      onTap: () {
                        openColorPicker(
                          context: context,
                          currentColor: Colors.pink,
                          onColorSelected: (Color selectedColor) {
                            final updated = createModel.copyWith(
                              couleur: selectedColor.toHex(),
                            );
                            context
                                .read<DrawerProvider>()
                                .openCreateCategorieDeModificateur(updated);
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
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: Text(
                      'Type de selection',
                      style: AppTextStyle.indingosubHeading,
                    ),
                    trailing: DropdownButton<String>(
                      underline: const SizedBox(),
                      value: createModel.typeSelection,
                      style: AppTextStyle.indingosubHeading,
                      items:
                          optiontypeDeSelection
                              .map(
                                (v) =>
                                    DropdownMenuItem(value: v, child: Text(v)),
                              )
                              .toList(),
                      onChanged: (v) {
                        if (v != null) {
                          final updated = createModel.copyWith(
                            typeSelection: v,
                          );
                          context
                              .read<DrawerProvider>()
                              .openCreateCategorieDeModificateur(updated);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: Text(
                      'Obligatoire',
                      style: AppTextStyle.indingosubHeading,
                    ),
                    trailing: Switch(
                      value: createModel.obligatoire!,
                      onChanged: (value) {
                        final updated = createModel.copyWith(
                          obligatoire: value,
                        );
                        context
                            .read<DrawerProvider>()
                            .openCreateCategorieDeModificateur(updated);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: Text(
                      'Affectation mode',
                      style: AppTextStyle.indingosubHeading,
                    ),
                    trailing: DropdownButton<SalleMode>(
                      underline: const SizedBox(),
                      value: createModel.salleMode,
                      style: AppTextStyle.indingosubHeading,
                      items:
                          SalleMode.values
                              .map(
                                (v) => DropdownMenuItem(
                                  value: v,
                                  child: Text(v.name.replaceAll("_", " ")),
                                ),
                              )
                              .toList(),
                      onChanged: (v) {
                        if (v != null) {
                          final updated = createModel.copyWith(salleMode: v);
                          context
                              .read<DrawerProvider>()
                              .openCreateCategorieDeModificateur(updated);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  createModel.salleMode == SalleMode.Pour_tout
                      ? const SizedBox.shrink()
                      : SalleIdsPicker(
                        salles: salles,
                        selectedSalleIds: createModel.sallesIDS!,
                        onSelectionChanged: (updatedSalleIds) {
                          final updated = createModel.copyWith(
                            sallesIDS: updatedSalleIds,
                          );
                          context
                              .read<DrawerProvider>()
                              .openCreateCategorieDeModificateur(updated);
                        },
                      ),
                  const SizedBox(height: 32),
                  CreateButton(
                    onPressed: () {
                      context.read<CategorieModificateurProvider>().create(
                        createModel.copyWith(nom: name.text),
                      );
                      _scaffoldKey.currentState?.closeEndDrawer();
                      context.read<DrawerProvider>().resetDrawer();
                    },
                    buttonText: 'Créer une nouvelle catégorie de prix',
                  ),
                ],
              ),
            ),
          );
        }

        if (state is DrawerUpdateCategorieDeModificateur) {
          final modificateur = state.modificateur;
          final attribute = state.attributeName;

          return UpdateAttributeDrawer(
            label: attribute,
            fieldType: _getFieldType(attribute),
            initialValue: state.currentValue,
            options: _getOptions(attribute),
            onSaved: (value) {
              final updated = _applyUpdatedValue(
                attribute,
                modificateur,
                value,
              );
              context.read<CategorieModificateurProvider>().update(updated);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  List<dynamic> _getOptions(String? attributeName) {
    switch (attributeName) {
      case 'affectaionMode':
      case 'produitMode':
        return SalleMode.values
            .map((e) => e.name.replaceAll('_', ' '))
            .toList();
      case 'typeDeSelection':
        return optiontypeDeSelection;
      case 'obligatoire':
        return ['true', 'false'];
      case 'salle':
        return salles; // ta variable globale/locale selon ton contexte
      default:
        return [];
    }
  }

  FieldType _getFieldType(String? attributeName) {
    switch (attributeName) {
      case 'nom':
        return FieldType.string;
      case 'affectaionMode':
      case 'produitMode':
      case 'typeDeSelection':
        return FieldType.dropdown;
      case 'obligatoire':
        return FieldType.boolean;
      case 'couleur':
        return FieldType.color;
      case 'salle':
        return FieldType.choice;
      default:
        return FieldType.string;
    }
  }

  CategorieDeModificateur _applyUpdatedValue(
    String attribute,
    CategorieDeModificateur model,
    dynamic value,
  ) {
    switch (attribute) {
      case 'nom':
        return model.copyWith(nom: value as String);
      case 'affectaionMode':
        return model.copyWith(
          salleMode: SalleMode.values.firstWhere(
            (mode) => mode.name.replaceAll('_', ' ') == value,
            orElse: () => SalleMode.Pour_tout,
          ),
        );
      case 'produitMode':
        return model.copyWith(
          produitMode: SalleMode.values.firstWhere(
            (mode) => mode.name.replaceAll('_', ' ') == value,
            orElse: () => SalleMode.Pour_tout,
          ),
        );
      case 'typeDeSelection':
        return model.copyWith(typeSelection: value as String);
      case 'obligatoire':
        final boolVal = value is bool ? value : value.toString() == 'true';
        return model.copyWith(obligatoire: boolVal);
      case 'salle':
        return model.copyWith(sallesIDS: value as List<int>);
      case 'couleur':
        return model.copyWith(couleur: value as String);
      default:
        return model;
    }
  }
}

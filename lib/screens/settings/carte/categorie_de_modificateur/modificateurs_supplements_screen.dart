import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/models.dart';
import 'package:restaurent/providers/providers.dart';
import 'package:restaurent/screens/settings/carte/categorie_de_modificateur/modificteur_details.dart';
import 'package:restaurent/screens/settings/carte/categorie_de_modificateur/produit_attachement.dart';
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

  TextEditingController prix = TextEditingController();
  TextEditingController supplement = TextEditingController();
  TauxTvaModel tvaModel = tauxTvaList[0];
  bool isSelectingProduits = false;
  CategorieDeModificateur createmodificateur = CategorieDeModificateur(
    couleur: '',
    icone: '',
    nom: '',
    obligatoire: true,
    sallesIDS: [],
    typeSelection: TypeDeSelection.SINGLE,
    modificateurs: [],
    produitsIds: [],
    salleMode: AffectationMode.POUR_TOUT,
    produitMode: AffectationMode.POUR_TOUT,
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<CategorieModificateurProvider>(
      builder: (context, provider, _) {
        print(
          'provider.attachemntProductScreen  ${provider.attachemntProductScreen}',
        );
        print('provider.selectedCategorie ${provider.selectedCategorie}');
        return Scaffold(
          key: _scaffoldKey,
          endDrawer: _endDrawer(provider, _scaffoldKey),

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
                                  context
                                      .read<TauxEtTvaProvider>()
                                      .tauxTvas
                                      .map((item) {
                                        return DropdownMenuItem(
                                          value: item,
                                          child: Text(item.tauxTva.toString()),
                                        );
                                      })
                                      .toList(),
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
                            context
                                .read<CategorieModificateurProvider>()
                                .update(
                                  state.modificateur.copyWith(
                                    modificateurs: [
                                      ...state.modificateur.modificateurs,
                                      SubCategorieDeModificateur(
                                        id:
                                            (state
                                                        .modificateur
                                                        .modificateurs
                                                        .length +
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
            child:
                (provider.attachemntProductScreen &&
                        provider.selectedCategorie == null)
                    ? ProduitAttachement(scaffoldKey: _scaffoldKey)
                    : (provider.selectedCategorie == null &&
                        !provider.loadingall)
                    ? _buildCategoriesList(provider)
                    : (provider.selectedCategorie != null &&
                        !provider.loadingselected)
                    ? ModificateurDetails(scaffoldKey: _scaffoldKey)
                    : Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget _buildCategoriesList(CategorieModificateurProvider provider) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Categorie de modificateur /supplement",
          style: AppTextStyle.indingoHeading,
        ),
        actions: [
          ActionButton(onPressed: () {}, text: 'Reorganiser'),
          ActionButton(
            onPressed: () {
              context.read<DrawerProvider>().openCreateCategorieDeModificateur(
                createmodificateur,
              );

              _scaffoldKey.currentState?.openEndDrawer();
            },
            text: 'Nouveau',
          ),
        ],
        leading: SizedBox.shrink(),
      ),
      body: Container(
        color: Colors.grey.shade200,
        margin: const EdgeInsets.all(6),
        child: SingleChildScrollView(
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
                                e.nom ?? '',
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
        ),
      ),
    );
  }

  Widget _endDrawer(
    CategorieModificateurProvider provider,
    final GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    return Consumer<DrawerProvider>(
      builder: (context, drawerProvider, _) {
        final state = drawerProvider.state;

        if (state is DrawerCreateCategorieDeModificateur) {
          final createModel = state.modificateur;

          return Drawer(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _buildHeader('Créer une nouvelle categorie'),
                  const SizedBox(height: 16),
                  _buildNomInput(createModel),
                  const SizedBox(height: 16),
                  _buildCouleurPicker(createModel),
                  const SizedBox(height: 16),
                  _buildTypeSelectionDropdown(createModel),
                  const SizedBox(height: 16),
                  _buildObligatoireSwitch(createModel),
                  const SizedBox(height: 16),
                  _buildSalleModeDropdown(createModel),
                  const SizedBox(height: 16),
                  if (createModel.salleMode != AffectationMode.POUR_TOUT)
                    _buildSallePicker(createModel),
                  const SizedBox(height: 16),
                  _buildProduitsButton(provider, scaffoldKey),
                  const SizedBox(height: 32),
                  _buildCreateButton(createModel),
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
        return AffectationMode.values
            .map((e) => e.name.replaceAll('_', ' '))
            .toList();
      case 'typeDeSelection':
        return TypeDeSelection.values
            .map((e) => e.name.replaceAll('_', ' '))
            .toList();
      case 'obligatoire':
        return ['true', 'false'];
      case 'salle':
        return Provider.of<SalleProvider>(context).salles;
      default:
        return [];
    }
  }

  FieldType _getFieldType(String? attributeName) {
    switch (attributeName) {
      case 'nom':
        return FieldType.string;
      case 'affectaionMode':
        return FieldType.dropdown;
      case 'produitMode':
        return FieldType.dropdown;
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
          salleMode: AffectationMode.values.firstWhere(
            (mode) => mode.name.replaceAll('_', ' ') == value,
            orElse: () => AffectationMode.POUR_TOUT,
          ),
        );
      case 'produitMode':
        return model.copyWith(
          produitMode: AffectationMode.values.firstWhere(
            (mode) => mode.name.replaceAll('_', ' ') == value,
            orElse: () => AffectationMode.POUR_TOUT,
          ),
        );
      case 'typeDeSelection':
        return model.copyWith(
          typeSelection: TypeDeSelection.values.firstWhere(
            (mode) => mode.name.replaceAll('_', ' ') == value,
            orElse: () => TypeDeSelection.SINGLE,
          ),
        );
      case 'obligatoire':
        final boolVal = value is bool ? value : value.toString() == 'true';
        return model.copyWith(obligatoire: boolVal);
      case 'salle':
        // Handle the new format that includes both choices and affectation mode
        if (value is Map<String, dynamic>) {
          final List<int> choices = value['choices'] as List<int>;
          final AffectationMode affectationMode =
              value['affectationMode'] as AffectationMode;
          return model.copyWith(sallesIDS: choices, salleMode: affectationMode);
        } else {
          // Fallback for old format
          return model.copyWith(sallesIDS: value as List<int>);
        }
      case 'couleur':
        return model.copyWith(couleur: value as String);
      default:
        return model;
    }
  }

  Widget _buildHeader(String title) {
    return Text(title, style: AppTextStyle.indingoHeading);
  }

  Widget _buildNomInput(CategorieDeModificateur createModel) {
    return TextFormField(
      onChanged: (value) {
        context.read<DrawerProvider>().openCreateCategorieDeModificateur(
          createModel.copyWith(nom: value),
        );
      },
      initialValue: createModel.nom,
      decoration: InputDecoration(
        labelText: 'Nom',
        labelStyle: AppTextStyle.indingosubHeading,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildCouleurPicker(CategorieDeModificateur createModel) {
    return CustomContainer(
      child: ListTile(
        title: Text('Couleur', style: AppTextStyle.indingosubHeading),
        trailing: InkWell(
          onTap: () {
            openColorPicker(
              context: context,
              currentColor: hexToColor(createModel.couleur ?? '#FFFFFFFF'),
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
              color: hexToColor(createModel.couleur ?? '#FFFFFFFF'),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black26),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeSelectionDropdown(CategorieDeModificateur createModel) {
    return CustomContainer(
      child: DropdownButtonFormField<TypeDeSelection>(
        value: createModel.typeSelection,
        decoration: const InputDecoration(
          labelText: 'Type de selection',
          border: InputBorder.none,
        ),
        items:
            TypeDeSelection.values
                .map(
                  (v) => DropdownMenuItem(
                    value: v,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        v.name.replaceAll("_", " "),
                        style: AppTextStyle.indingosubHeading,
                      ),
                    ),
                  ),
                )
                .toList(),
        onChanged: (v) {
          if (v != null) {
            final updated = createModel.copyWith(typeSelection: v);
            context.read<DrawerProvider>().openCreateCategorieDeModificateur(
              updated,
            );
          }
        },
      ),
    );
  }

  Widget _buildObligatoireSwitch(CategorieDeModificateur createModel) {
    return CustomContainer(
      child: ListTile(
        title: Text('Obligatoire', style: AppTextStyle.indingosubHeading),
        trailing: Switch(
          value: createModel.obligatoire!,
          activeColor: AppColors.indingo400,
          onChanged: (value) {
            final updated = createModel.copyWith(obligatoire: value);
            context.read<DrawerProvider>().openCreateCategorieDeModificateur(
              updated,
            );
          },
        ),
      ),
    );
  }

  Widget _buildSalleModeDropdown(CategorieDeModificateur createModel) {
    return CustomContainer(
      child: DropdownButtonFormField<AffectationMode>(
        value: createModel.salleMode,
        decoration: const InputDecoration(
          labelText: 'Affectation mode',
          border: InputBorder.none,
        ),
        items:
            AffectationMode.values
                .where((v) => v != AffectationMode.AJOUTER_A_LIST_EXSISTANTE)
                .map(
                  (v) => DropdownMenuItem(
                    value: v,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        v.name.replaceAll("_", " "),
                        style: AppTextStyle.indingosubHeading,
                      ),
                    ),
                  ),
                )
                .toList(),
        onChanged: (v) {
          if (v != null) {
            final updated = createModel.copyWith(salleMode: v);
            context.read<DrawerProvider>().openCreateCategorieDeModificateur(
              updated,
            );
          }
        },
      ),
    );
  }

  Widget _buildSallePicker(CategorieDeModificateur createModel) {
    return SalleIdsPicker(
      salles: Provider.of<SalleProvider>(context).salles,
      selectedSalleIds: createModel.sallesIDS!,
      onSelectionChanged: (updatedSalleIds) {
        final updated = createModel.copyWith(sallesIDS: updatedSalleIds);
        context.read<DrawerProvider>().openCreateCategorieDeModificateur(
          updated,
        );
      },
    );
  }

  Widget _buildProduitsButton(
    CategorieModificateurProvider provider,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    return CustomContainer(
      child: CustomListTile(
        leading: 'Prodtuid',
        title: null,
        trailing: null,
        onTap: () {
          provider.openattachemtScreen();
          scaffoldKey.currentState?.closeEndDrawer();
        },
        trailingwidget: null,
      ),
    );
  }

  Widget _buildCreateButton(CategorieDeModificateur createModel) {
    return CreateButton(
      onPressed: () {
        context.read<CategorieModificateurProvider>().create(createModel);
        _scaffoldKey.currentState?.closeEndDrawer();
        context.read<DrawerProvider>().resetDrawer();
      },
      buttonText: 'Créer une nouvelle catégorie de modificateur',
    );
  }
}

class CustomContainer extends StatelessWidget {
  final Widget child;

  const CustomContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
        color: Colors.grey[50],
      ),
      child: child,
    );
  }
}

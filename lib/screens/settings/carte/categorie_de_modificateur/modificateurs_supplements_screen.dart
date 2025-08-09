import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/models.dart';
import 'package:restaurent/riverpods/drawer_riverpod/drawer_state.dart';
import 'package:restaurent/screens/reglage_screen.dart';
import 'package:restaurent/riverpods/categorie_modificateur_riverpod.dart';
import 'package:restaurent/screens/settings/carte/categorie_de_modificateur/modificteur_details.dart';
import 'package:restaurent/screens/settings/carte/categorie_de_modificateur/produit_attachement.dart';
import 'package:restaurent/widgets/widgets.dart';

class ModificateursSupplementsScreen extends ConsumerStatefulWidget {
  const ModificateursSupplementsScreen({super.key});

  @override
  ConsumerState<ModificateursSupplementsScreen> createState() =>
      _ModificateursSupplementsScreenState();
}

class _ModificateursSupplementsScreenState
    extends ConsumerState<ModificateursSupplementsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController prix = TextEditingController();
  TextEditingController supplement = TextEditingController();
  TauxTvaModel tvaModel = tauxTvaList[0];
  bool isSelectingProduits = false;
  bool subActif = false;
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
    final tauxEtTvaState = ref.watch(tauxEtTvaRiverpod);
    final categorieModificateurState = ref.watch(categorieModificateurRiverpod);
    final categorieModificateurNotifier = ref.read(
      categorieModificateurRiverpod.notifier,
    );

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _endDrawer(categorieModificateurNotifier, _scaffoldKey),

      drawer: Consumer(
        builder: (context, drawerProvider, _) {
          final state = ref.watch(drawerRiverpod);
          if (state is DrawerCreateSubCategorieDeModificateur) {
            return Drawer(
              width: MediaQuery.of(context).size.width * .33,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Créer une nouvelle sous-catégorie',
                        style: AppTextStyle.indingoHeading,
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller: supplement,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Le nom est requis";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,

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
                    TextField(
                      controller: prix,
                      decoration: InputDecoration(
                        labelText: 'Prix',
                        labelStyle: AppTextStyle.indingosubHeading,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomContainer(
                      child: ListTile(
                        title: Text(
                          'Actif',
                          style: AppTextStyle.indingosubHeading,
                        ),
                        trailing: Switch(
                          value: subActif,
                          activeColor: AppColors.indingo400,
                          onChanged: (value) {
                            setState(() {
                              subActif = !subActif;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade400),
                        color: Colors.grey[50],
                      ),
                      child: DropdownButtonFormField<TauxTvaModel>(
                        value: tvaModel,
                        decoration: const InputDecoration(
                          labelText: 'TVA',
                          border: InputBorder.none,
                        ),
                        items:
                            tauxEtTvaState.tauxTvas
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.tauxTva.toString(),
                                      style: AppTextStyle.indingosubHeading,
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              tvaModel = value;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    CreateButton(
                      onPressed: () {
                        SubCategorieDeModificateur sub =
                            SubCategorieDeModificateur(
                              nom: supplement.text,
                              actif: subActif,
                              prix: double.parse(prix.text),
                              tvaValue: 32,
                            );
                        categorieModificateurNotifier.update(
                          categorieModificateurState.selected!.copyWith(
                            modificateurs: [sub],
                          ),
                        );
                        supplement.clear();
                        prix.clear();
                        _scaffoldKey.currentState?.closeDrawer();
                      },
                      buttonText: 'Créer',
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      body:
          (categorieModificateurState.attachmentProductScreen &&
                  categorieModificateurState.selected == null)
              ? ProduitAttachement(
                scaffoldKey: _scaffoldKey,
                provider: categorieModificateurRiverpod,
              )
              : (categorieModificateurState.selected == null &&
                  !categorieModificateurState.loadingAll)
              ? _buildCategoriesList(
                categorieModificateurState,
                categorieModificateurNotifier,
              )
              : (categorieModificateurState.selected != null &&
                  !categorieModificateurState.loadingSelected)
              ? ModificateurDetails(scaffoldKey: _scaffoldKey)
              : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildCategoriesList(
    CategorieModificateurState state,
    CategorieModificateurNotifier notifier,
  ) {
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
              final container = ProviderScope.containerOf(context);
              container
                  .read(drawerRiverpod.notifier)
                  .openCreateCategorieDeModificateur(createmodificateur);

              _scaffoldKey.currentState?.openEndDrawer();
            },
            text: 'Nouveau',
          ),
        ],
        leading: const SizedBox.shrink(),
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
                    ...state.allCategories.map(
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
                              notifier.select(e);
                            },
                          ),
                          e != state.allCategories.last
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
    CategorieModificateurNotifier notifier,
    final GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    return Consumer(
      builder: (context, drawerProvider, _) {
        final state = ref.watch(drawerRiverpod);

        if (state is DrawerCreateCategorieDeModificateur) {
          final createModel = state.modificateur;

          return Drawer(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Créer une nouvelle catégorie de modificateur',
                      style: AppTextStyle.indingoHeading,
                    ),
                  ),

                  const SizedBox(height: 16),
                  _buildNomField(createModel),
                  const SizedBox(height: 16),
                  _buildCouleurField(createModel),
                  const SizedBox(height: 16),

                  _buildObligatoireField(createModel),
                  const SizedBox(height: 16),
                  _buildTypeSelectionField(createModel),
                  const SizedBox(height: 16),
                  _buildSalleModeDropdown(createModel),
                  const SizedBox(height: 16),
                  _buildSallePicker(createModel),
                  const SizedBox(height: 16),
                  _buildProduitsButton(notifier, scaffoldKey),
                  const SizedBox(height: 32),
                  _buildCreateButton(createModel, notifier),
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

              notifier.update(updated);
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
        return ref.watch(salleRiverpod);
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
        return model.copyWith(obligatoire: value == 'true');
      case 'couleur':
        return model.copyWith(couleur: value as String);
      case 'icone':
        return model.copyWith(icone: value as String);
      case 'salle':
        return model.copyWith(
          sallesIDS: value['choices'],
          salleMode: value['affectationMode'],
        );
      default:
        return model;
    }
  }

  Widget _buildNomField(CategorieDeModificateur createModel) {
    return TextFormField(
      initialValue: createModel.nom,
      decoration: InputDecoration(
        labelText: 'Nom',
        labelStyle: AppTextStyle.indingosubHeading,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      onChanged: (v) {
        final updated = createModel.copyWith(nom: v);
        final container = ProviderScope.containerOf(context);
        container
            .read(drawerRiverpod.notifier)
            .openCreateCategorieDeModificateur(updated);
      },
    );
  }

  Widget _buildCouleurField(CategorieDeModificateur createModel) {
    return CustomContainer(
      child: CustomListTile(
        leading: 'Couleur',
        title: null,
        trailing: null,
        onTap: () {
          openColorPicker(
            context: context,

            currentColor: hexToColor(createModel.couleur ?? '#FFFFFFFF'),
            onColorSelected: (Color selectedColor) {
              final updated = createModel.copyWith(
                couleur: selectedColor.toHex(),
              );
              ref
                  .read(drawerRiverpod.notifier)
                  .openCreateCategorieDeModificateur(updated);
            },
          );
        },
        trailingwidget: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: hexToColor(createModel.couleur ?? '#FFFFFFFF'),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildObligatoireField(CategorieDeModificateur createModel) {
    return CustomContainer(
      child: ListTile(
        title: Text('Obligatoire', style: AppTextStyle.indingosubHeading),
        trailing: Switch(
          value: createModel.obligatoire!,
          activeColor: AppColors.indingo400,
          onChanged: (value) {
            final updated = createModel.copyWith(obligatoire: value);

            final container = ProviderScope.containerOf(context);
            container
                .read(drawerRiverpod.notifier)
                .openCreateCategorieDeModificateur(updated);
          },
        ),
      ),
    );
  }

  Widget _buildTypeSelectionField(CategorieDeModificateur createModel) {
    return CustomContainer(
      child: DropdownButtonFormField<TypeDeSelection>(
        value: createModel.typeSelection,
        decoration: const InputDecoration(
          labelText: 'Type de sélection',
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
            final container = ProviderScope.containerOf(context);
            container
                .read(drawerRiverpod.notifier)
                .openCreateCategorieDeModificateur(updated);
          }
        },
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

            final container = ProviderScope.containerOf(context);
            container
                .read(drawerRiverpod.notifier)
                .openCreateCategorieDeModificateur(updated);
          }
        },
      ),
    );
  }

  Widget _buildSallePicker(CategorieDeModificateur createModel) {
    final salles = ref.watch(salleRiverpod);
    return SalleIdsPicker(
      salles: salles,
      selectedSalleIds: createModel.sallesIDS!,
      onSelectionChanged: (updatedSalleIds) {
        final updated = createModel.copyWith(sallesIDS: updatedSalleIds);

        final container = ProviderScope.containerOf(context);
        container
            .read(drawerRiverpod.notifier)
            .openCreateCategorieDeModificateur(updated);
      },
    );
  }

  Widget _buildProduitsButton(
    CategorieModificateurNotifier notifier,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    return CustomContainer(
      child: CustomListTile(
        leading: 'Prodtuid',
        title: null,
        trailing: null,
        onTap: () {
          notifier.openAttachmentScreen();
          scaffoldKey.currentState?.closeEndDrawer();
        },
        trailingwidget: null,
      ),
    );
  }

  Widget _buildCreateButton(
    CategorieDeModificateur createModel,
    CategorieModificateurNotifier notifier,
  ) {
    return CreateButton(
      onPressed: () {
        notifier.create(createModel);
        final container = ProviderScope.containerOf(context);
        container.read(drawerRiverpod.notifier).resetDrawer();
        _scaffoldKey.currentState?.closeEndDrawer();
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

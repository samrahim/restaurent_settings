import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/models.dart';
import 'package:restaurent/riverpods/drawer_riverpod/drawer_state.dart';
import 'package:restaurent/screens/reglage_screen.dart';
import 'package:restaurent/widgets/widgets.dart';

class MoyenPaiementScreen extends ConsumerStatefulWidget {
  const MoyenPaiementScreen({super.key});

  @override
  ConsumerState<MoyenPaiementScreen> createState() =>
      _MoyenPaiementScreenState();
}

class _MoyenPaiementScreenState extends ConsumerState<MoyenPaiementScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final MoyenDePaiementModel _emptyModel = MoyenDePaiementModel(
    id: null,
    nom: '',
    icon: null,
    modeEncaissement: modeEncaissementList.first,
    getsionDuTropPercu: gestionDuTropPercuList.first,
    ouvertureDeTiroirCaisse: true,
    disponibleEnModeExpress: true,
    variationDuMoyenDePaiement: moyenDePaiementList.first,
    compterAlaFinDuService: true,
    rensignerleFondDeCaisee: true,
    sallesIDS: [],
    actif: true,
  );
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final moyenDePaiementState = ref.watch(moyenDePaiementRiverpod);
    final moyenDePaiementNotifier = ref.read(moyenDePaiementRiverpod.notifier);
    final salleList = ref.watch(salleRiverpod);
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Consumer(
        builder: (context, ref, _) {
          final state = ref.watch(drawerRiverpod);
          if (state is DrawerCreatePaiementMethode) {
            final m = state.model;

            return Drawer(
              width: MediaQuery.of(context).size.width * .3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Créer une nouvelle moyen de paiement',
                          style: AppTextStyle.indingoHeading,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: nameController,
                        label: 'Nom de la catégorie',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nom de la catégorie est requis';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          final updated = m.copyWith(nom: value);
                          ref
                              .read(drawerRiverpod.notifier)
                              .openCreatePaiementMethodeDrawer(updated);
                        },
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.greyaccent!,
                            width: .9,
                          ),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: m.modeEncaissement,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.greyaccent!,
                              ),
                            ),
                            labelText: 'Mode d’encaissement',
                          ),
                          items:
                              modeEncaissementList
                                  .map(
                                    (v) => DropdownMenuItem(
                                      value: v,
                                      child: Text(
                                        v,
                                        style: AppTextStyle.indingosubHeading,
                                      ),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (v) {
                            if (v != null) {
                              final updated = m.copyWith(modeEncaissement: v);
                              ref
                                  .read(drawerRiverpod.notifier)
                                  .openCreatePaiementMethodeDrawer(updated);
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.greyaccent!,
                            width: .9,
                          ),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: m.getsionDuTropPercu,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.greyaccent!,
                              ),
                            ),
                            labelText: 'Gestion du trop-perçu',
                          ),

                          items:
                              gestionDuTropPercuList
                                  .map(
                                    (v) => DropdownMenuItem(
                                      value: v,
                                      child: Text(
                                        v,
                                        style: AppTextStyle.indingosubHeading,
                                      ),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (v) {
                            if (v != null) {
                              final updated = m.copyWith(getsionDuTropPercu: v);
                              ref
                                  .read(drawerRiverpod.notifier)
                                  .openCreatePaiementMethodeDrawer(updated);
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.greyaccent!,
                            width: .9,
                          ),
                        ),
                        child: SwitchListTile(
                          activeColor: AppColors.indingo400,
                          title: Text(
                            'Ouverture du tiroir caisse',
                            style: AppTextStyle.indingosubHeading,
                          ),
                          value: m.ouvertureDeTiroirCaisse ?? false,
                          onChanged: (v) {
                            final updated = m.copyWith(
                              ouvertureDeTiroirCaisse: v,
                            );
                            ref
                                .read(drawerRiverpod.notifier)
                                .openCreatePaiementMethodeDrawer(updated);
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.greyaccent!,
                            width: .9,
                          ),
                        ),
                        child: SwitchListTile(
                          title: Text(
                            'Disponible en mode express',
                            style: AppTextStyle.indingosubHeading,
                          ),
                          value: m.disponibleEnModeExpress ?? false,
                          activeColor: AppColors.indingo400,
                          onChanged: (v) {
                            final updated = m.copyWith(
                              disponibleEnModeExpress: v,
                            );
                            ref
                                .read(drawerRiverpod.notifier)
                                .openCreatePaiementMethodeDrawer(updated);
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.greyaccent!,
                            width: .9,
                          ),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: m.variationDuMoyenDePaiement,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.greyaccent!,
                              ),
                            ),
                            labelText: 'Variation',
                          ),

                          items:
                              moyenDePaiementList
                                  .map(
                                    (v) => DropdownMenuItem(
                                      value: v,
                                      child: Text(
                                        v,
                                        style: AppTextStyle.indingosubHeading,
                                      ),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (v) {
                            if (v != null) {
                              final updated = m.copyWith(
                                variationDuMoyenDePaiement: v,
                              );
                              ref
                                  .read(drawerRiverpod.notifier)
                                  .openCreatePaiementMethodeDrawer(updated);
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.greyaccent!,
                            width: .9,
                          ),
                        ),
                        child: SwitchListTile(
                          activeColor: AppColors.indingo400,
                          title: Text(
                            'Compter à la fin du service',
                            style: AppTextStyle.indingosubHeading,
                          ),
                          value: m.compterAlaFinDuService ?? false,
                          onChanged: (v) {
                            final updated = m.copyWith(
                              compterAlaFinDuService: v,
                            );
                            ref
                                .read(drawerRiverpod.notifier)
                                .openCreatePaiementMethodeDrawer(updated);
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.greyaccent!,
                            width: .9,
                          ),
                        ),
                        child: SwitchListTile(
                          activeColor: AppColors.indingo400,
                          title: Text(
                            'Renseigner le fond de caisse',
                            style: AppTextStyle.indingosubHeading,
                          ),
                          value: m.rensignerleFondDeCaisee ?? false,
                          onChanged: (v) {
                            final updated = m.copyWith(
                              rensignerleFondDeCaisee: v,
                            );
                            ref
                                .read(drawerRiverpod.notifier)
                                .openCreatePaiementMethodeDrawer(updated);
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      SalleIdsPicker(
                        salles: salleList.salles,
                        selectedSalleIds: m.sallesIDS as List<int> ?? [],
                        onSelectionChanged: (newSalles) {
                          final updated = m.copyWith(sallesIDS: newSalles);
                          ref
                              .read(drawerRiverpod.notifier)
                              .openCreatePaiementMethodeDrawer(updated);
                        },
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.greyaccent!,
                            width: .9,
                          ),
                        ),
                        child: SwitchListTile(
                          activeColor: AppColors.indingo400,
                          title: Text(
                            'Actif',
                            style: AppTextStyle.indingosubHeading,
                          ),
                          value: m.actif ?? false,
                          onChanged: (v) {
                            final updated = m.copyWith(actif: v);
                            ref
                                .read(drawerRiverpod.notifier)
                                .openCreatePaiementMethodeDrawer(updated);
                          },
                        ),
                      ),

                      const SizedBox(height: 32),

                      CreateButton(
                        onPressed: () async {
                          await ref
                              .read(moyenDePaiementRiverpod.notifier)
                              .create(model: state.model);

                          nameController.clear();
                          Navigator.pop(context);
                        },
                        buttonText: 'Crée une nouvelle moyen de paiement',
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is DrawerUpdateMoyenDePaiement) {
            switch (state.attributeName) {
              case 'nom':
                return UpdateAttributeDrawer(
                  fieldType: FieldType.string,
                  label: 'Nom',
                  initialValue: state.currentValue as String,
                  onSaved: (v) {
                    ref
                        .read(moyenDePaiementRiverpod.notifier)
                        .update(updatedModel: state.model.copyWith(nom: v));
                  },
                );
              case 'modeEncaissement':
                return UpdateAttributeDrawer(
                  fieldType: FieldType.dropdown,
                  label: 'Mode d’encaissement',
                  initialValue: state.currentValue as String,
                  options: modeEncaissementList,
                  onSaved: (v) {
                    ref
                        .read(moyenDePaiementRiverpod.notifier)
                        .update(
                          updatedModel: state.model.copyWith(
                            modeEncaissement: v,
                          ),
                        );
                  },
                );
              case 'actif':
                return UpdateAttributeDrawer(
                  fieldType: FieldType.boolean,
                  label: 'Actif',
                  initialValue: (state.currentValue as bool).toString(),

                  onSaved: (v) {
                    ref
                        .read(moyenDePaiementRiverpod.notifier)
                        .update(updatedModel: state.model.copyWith(actif: v));
                  },
                );
              case 'GestionDuTropPerçu':
                return UpdateAttributeDrawer(
                  fieldType: FieldType.dropdown,
                  options: gestionDuTropPercuList,
                  label: 'Gestion du trop-perçu',
                  initialValue: (state.currentValue) as String,
                  onSaved: (v) {
                    ref
                        .read(moyenDePaiementRiverpod.notifier)
                        .update(
                          updatedModel: state.model.copyWith(
                            getsionDuTropPercu: v,
                          ),
                        );
                  },
                );
              case 'VariationsDuMoyenDePaiement':
                return UpdateAttributeDrawer(
                  fieldType: FieldType.dropdown,
                  options: moyenDePaiementList,
                  label: 'Variations du moyen de paiement',
                  initialValue: (state.currentValue) as String,

                  onSaved: (v) {
                    ref
                        .read(moyenDePaiementRiverpod.notifier)
                        .update(
                          updatedModel: state.model.copyWith(
                            variationDuMoyenDePaiement: v,
                          ),
                        );
                  },
                );
              case 'OuvertureDuTiroir':
                return UpdateAttributeDrawer(
                  fieldType: FieldType.boolean,
                  label: 'Ouverture du tiroir caisse',
                  initialValue: (state.currentValue as bool).toString(),
                  options: ['true', 'false'],
                  onSaved: (v) {
                    ref
                        .read(moyenDePaiementRiverpod.notifier)
                        .update(
                          updatedModel: state.model.copyWith(
                            ouvertureDeTiroirCaisse: v,
                          ),
                        );
                  },
                );
              case 'DisponibleEnModeExpress':
                return UpdateAttributeDrawer(
                  fieldType: FieldType.boolean,
                  label: 'Disponible en mode express',
                  initialValue: (state.currentValue as bool).toString(),
                  options: ['true', 'false'],
                  onSaved: (v) {
                    ref
                        .read(moyenDePaiementRiverpod.notifier)
                        .update(
                          updatedModel: state.model.copyWith(
                            disponibleEnModeExpress: v,
                          ),
                        );
                  },
                );

              case 'CompterALaFinDuService':
                return UpdateAttributeDrawer(
                  fieldType: FieldType.boolean,
                  label: 'Compter à la fin du service',
                  initialValue: (state.currentValue as bool).toString(),
                  options: ['true', 'false'],
                  onSaved: (v) {
                    ref
                        .read(moyenDePaiementRiverpod.notifier)
                        .update(
                          updatedModel: state.model.copyWith(
                            compterAlaFinDuService: v,
                          ),
                        );
                  },
                );
              case 'RenseignerLeFondDeCaisse':
                return UpdateAttributeDrawer(
                  fieldType: FieldType.boolean,
                  label: 'Renseigner le fond de caisse',
                  initialValue: (state.currentValue as bool).toString(),
                  options: ['true', 'false'],
                  onSaved: (v) {
                    ref
                        .read(moyenDePaiementRiverpod.notifier)
                        .update(
                          updatedModel: state.model.copyWith(
                            rensignerleFondDeCaisee: v,
                          ),
                        );
                  },
                );

              case 'DisponibleDansLesSalles':
                return UpdateAttributeDrawer(
                  fieldType: FieldType.choice,
                  options: salleList.salles,
                  label: 'Disponible dans les salles',
                  initialValue: (state.currentValue) as List<int>,
                  onSaved: (v) {
                    ref
                        .read(moyenDePaiementRiverpod.notifier)
                        .update(
                          updatedModel: state.model.copyWith(
                            sallesIDS:
                                (v as List<dynamic>)
                                    .map((e) => e as int)
                                    .toList(),
                          ),
                        );
                  },
                );

              default:
                return const SizedBox.shrink();
            }
          } else {
            return SizedBox.shrink();
          }
        },
      ),

      body:
          moyenDePaiementState.isloading!
              ? Center(child: CircularProgressIndicator())
              : Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child:
                          moyenDePaiementState.moyens.isNotEmpty
                              ? ListView(
                                children: [
                                  ...moyenDePaiementState.moyens.map(
                                    (moyen) => ListTile(
                                      selectedTileColor: Colors.grey.shade300,
                                      title: Text(
                                        moyen.nom ?? '',
                                        style: AppTextStyle.indingosubHeading,
                                      ),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios,
                                      ),
                                      selected:
                                          moyenDePaiementState.selected !=
                                              null &&
                                          moyen.id ==
                                              moyenDePaiementState.selected!.id,
                                      onTap: () {
                                        moyenDePaiementNotifier.select(moyen);
                                      },
                                    ),
                                  ),
                                ],
                              )
                              : Center(
                                child: Text(
                                  "Aucun moyen de paiement trouvé",
                                  style: AppTextStyle.greyHeading,
                                ),
                              ),
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child:
                        moyenDePaiementState.selected != null
                            ? Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            CustomListTile(
                                              onTap: () {
                                                final container =
                                                    ProviderScope.containerOf(
                                                      context,
                                                    );
                                                container
                                                    .read(
                                                      drawerRiverpod.notifier,
                                                    )
                                                    .openUpdatePaiementMethodeDrawer(
                                                      moyenDePaiementState
                                                          .selected!,
                                                      'nom',
                                                      moyenDePaiementState
                                                          .selected!
                                                          .nom,
                                                    );

                                                _scaffoldKey.currentState
                                                    ?.openEndDrawer();
                                              },
                                              trailing: null,
                                              title: Text(
                                                'Nom',
                                                style: AppTextStyle.greyHeading,
                                              ),
                                              trailingwidget: Text(
                                                moyenDePaiementState
                                                    .selected!
                                                    .nom!,
                                                style:
                                                    AppTextStyle
                                                        .indingosubHeading,
                                              ),
                                              leading: null,
                                            ),
                                            const Divider(),

                                            CustomListTile(
                                              onTap: null,
                                              leading: null,
                                              trailing: null,
                                              title: Text(
                                                'Icône',
                                                style: AppTextStyle.greyHeading,
                                              ),
                                              trailingwidget: Icon(Icons.money),
                                            ),
                                            const Divider(),
                                            CustomListTile(
                                              onTap: () {
                                                final container =
                                                    ProviderScope.containerOf(
                                                      context,
                                                    );
                                                container
                                                    .read(
                                                      drawerRiverpod.notifier,
                                                    )
                                                    .openUpdatePaiementMethodeDrawer(
                                                      moyenDePaiementState
                                                          .selected!,
                                                      'modeEncaissement',
                                                      moyenDePaiementState
                                                          .selected!
                                                          .modeEncaissement,
                                                    );

                                                _scaffoldKey.currentState
                                                    ?.openEndDrawer();
                                              },
                                              leading: null,
                                              trailing: null,
                                              title: Text(
                                                'Mode d’encaissement',
                                                style: AppTextStyle.greyHeading,
                                              ),
                                              trailingwidget: Text(
                                                moyenDePaiementState
                                                    .selected!
                                                    .modeEncaissement!,
                                                style:
                                                    AppTextStyle
                                                        .indingosubHeading,
                                              ),
                                            ),
                                            const Divider(),
                                            CustomListTile(
                                              onTap: () {
                                                final container =
                                                    ProviderScope.containerOf(
                                                      context,
                                                    );
                                                container
                                                    .read(
                                                      drawerRiverpod.notifier,
                                                    )
                                                    .openUpdatePaiementMethodeDrawer(
                                                      moyenDePaiementState
                                                          .selected!,
                                                      'GestionDuTropPerçu',
                                                      moyenDePaiementState
                                                          .selected!
                                                          .getsionDuTropPercu,
                                                    );

                                                _scaffoldKey.currentState
                                                    ?.openEndDrawer();
                                              },
                                              leading: null,
                                              trailing: null,
                                              title: Text(
                                                'Gestion du trop-perçu',
                                                style: AppTextStyle.greyHeading,
                                              ),
                                              trailingwidget: Text(
                                                moyenDePaiementState
                                                    .selected!
                                                    .modeEncaissement!,
                                                style:
                                                    AppTextStyle
                                                        .indingosubHeading,
                                              ),
                                            ),
                                            const Divider(),

                                            InkWell(
                                              onTap: () {
                                                final container =
                                                    ProviderScope.containerOf(
                                                      context,
                                                    );
                                                container
                                                    .read(
                                                      drawerRiverpod.notifier,
                                                    )
                                                    .openUpdatePaiementMethodeDrawer(
                                                      moyenDePaiementState
                                                          .selected!,
                                                      'OuvertureDuTiroir',
                                                      moyenDePaiementState
                                                          .selected!
                                                          .ouvertureDeTiroirCaisse,
                                                    );

                                                _scaffoldKey.currentState
                                                    ?.openEndDrawer();
                                              },
                                              child: SwitchListTile(
                                                activeTrackColor:
                                                    AppColors.indingo400,
                                                title: Text(
                                                  'Ouverture du tiroir caisse',
                                                  style:
                                                      AppTextStyle.greyHeading,
                                                ),
                                                value:
                                                    moyenDePaiementState
                                                        .selected!
                                                        .ouvertureDeTiroirCaisse ??
                                                    false,
                                                onChanged: null,
                                              ),
                                            ),
                                            Divider(),
                                            InkWell(
                                              onTap: () {
                                                final container =
                                                    ProviderScope.containerOf(
                                                      context,
                                                    );
                                                container
                                                    .read(
                                                      drawerRiverpod.notifier,
                                                    )
                                                    .openUpdatePaiementMethodeDrawer(
                                                      moyenDePaiementState
                                                          .selected!,
                                                      'DisponibleEnModeExpress',
                                                      moyenDePaiementState
                                                          .selected!
                                                          .disponibleEnModeExpress,
                                                    );
                                                _scaffoldKey.currentState
                                                    ?.openEndDrawer();
                                              },
                                              child: SwitchListTile(
                                                activeTrackColor:
                                                    AppColors.indingo400,
                                                title: Text(
                                                  'Disponible en mode express',
                                                  style:
                                                      AppTextStyle.greyHeading,
                                                ),
                                                value:
                                                    moyenDePaiementState
                                                        .selected!
                                                        .disponibleEnModeExpress ??
                                                    false,
                                                onChanged: null,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: CustomListTile(
                                          onTap: () {
                                            final container =
                                                ProviderScope.containerOf(
                                                  context,
                                                );
                                            container
                                                .read(drawerRiverpod.notifier)
                                                .openUpdatePaiementMethodeDrawer(
                                                  moyenDePaiementState
                                                      .selected!,
                                                  'VariationsDuMoyenDePaiement',
                                                  moyenDePaiementState
                                                      .selected!
                                                      .variationDuMoyenDePaiement,
                                                );

                                            _scaffoldKey.currentState
                                                ?.openEndDrawer();
                                          },
                                          leading: null,
                                          trailing: null,
                                          title: Text(
                                            'Variations du moyen de paiement',
                                            style: AppTextStyle.greyHeading,
                                          ),
                                          trailingwidget: Text(
                                            moyenDePaiementState
                                                    .selected
                                                    ?.variationDuMoyenDePaiement ??
                                                "",
                                            style:
                                                AppTextStyle.indingosubHeading,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                final container =
                                                    ProviderScope.containerOf(
                                                      context,
                                                    );
                                                container
                                                    .read(
                                                      drawerRiverpod.notifier,
                                                    )
                                                    .openUpdatePaiementMethodeDrawer(
                                                      moyenDePaiementState
                                                          .selected!,
                                                      'CompterALaFinDuService',
                                                      moyenDePaiementState
                                                          .selected!
                                                          .compterAlaFinDuService,
                                                    );

                                                _scaffoldKey.currentState
                                                    ?.openEndDrawer();
                                              },
                                              child: SwitchListTile(
                                                activeTrackColor:
                                                    AppColors.indingo400,
                                                title: Text(
                                                  'Compter à la fin du service',
                                                  style:
                                                      AppTextStyle.greyHeading,
                                                ),
                                                value:
                                                    moyenDePaiementState
                                                        .selected
                                                        ?.compterAlaFinDuService ??
                                                    false,
                                                onChanged: null,
                                              ),
                                            ),
                                            Divider(),
                                            InkWell(
                                              onTap: () {
                                                final container =
                                                    ProviderScope.containerOf(
                                                      context,
                                                    );
                                                container
                                                    .read(
                                                      drawerRiverpod.notifier,
                                                    )
                                                    .openUpdatePaiementMethodeDrawer(
                                                      moyenDePaiementState
                                                          .selected!,
                                                      'RenseignerLeFondDeCaisse',
                                                      moyenDePaiementState
                                                          .selected!
                                                          .rensignerleFondDeCaisee,
                                                    );

                                                _scaffoldKey.currentState
                                                    ?.openEndDrawer();
                                              },
                                              child: SwitchListTile(
                                                activeTrackColor:
                                                    AppColors.indingo400,
                                                title: Text(
                                                  'Renseigner le fond de caisse',
                                                  style:
                                                      AppTextStyle.greyHeading,
                                                ),
                                                value:
                                                    moyenDePaiementState
                                                        .selected!
                                                        .rensignerleFondDeCaisee ??
                                                    false,
                                                onChanged: null,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            CustomListTile(
                                              onTap: () {
                                                final container =
                                                    ProviderScope.containerOf(
                                                      context,
                                                    );
                                                container
                                                    .read(
                                                      drawerRiverpod.notifier,
                                                    )
                                                    .openUpdatePaiementMethodeDrawer(
                                                      moyenDePaiementState
                                                          .selected!,
                                                      'RenseignerLeFondDeCaisse',
                                                      moyenDePaiementState
                                                          .selected!
                                                          .sallesIDS,
                                                    );

                                                _scaffoldKey.currentState
                                                    ?.openEndDrawer();
                                              },
                                              leading: null,
                                              trailing: null,
                                              // moyenDePaiementState
                                              //             .selected
                                              //             ?.sallesIDS !=
                                              //         null
                                              //     ? moyenDePaiementState
                                              //         .selected
                                              //         ?.sallesIDS!
                                              //         .map(
                                              //           (id) =>
                                              //               salleList
                                              //                   .firstWhere(
                                              //                     (s) => s.id == id,
                                              //                   )
                                              //                   .name,
                                              //         )
                                              //         .join(', ')
                                              //     : 'Aucune salle sélectionnée',
                                              title: Text(
                                                'Disponible dans les salles',
                                                style: AppTextStyle.greyHeading,
                                              ),
                                              trailingwidget: null,
                                            ),

                                            Divider(),
                                            InkWell(
                                              onTap: () {
                                                final container =
                                                    ProviderScope.containerOf(
                                                      context,
                                                    );
                                                container
                                                    .read(
                                                      drawerRiverpod.notifier,
                                                    )
                                                    .openUpdatePaiementMethodeDrawer(
                                                      moyenDePaiementState
                                                          .selected!,
                                                      'actif',
                                                      moyenDePaiementState
                                                          .selected!
                                                          .actif,
                                                    );

                                                _scaffoldKey.currentState
                                                    ?.openEndDrawer();
                                              },
                                              child: SwitchListTile(
                                                activeTrackColor:
                                                    AppColors.indingo400,
                                                title: Text(
                                                  'Actif',
                                                  style:
                                                      AppTextStyle.greyHeading,
                                                ),
                                                value:
                                                    moyenDePaiementState
                                                        .selected
                                                        ?.actif ??
                                                    false,
                                                onChanged: null,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      ButtonSupprimer(
                                        onTap: () {},
                                        text: 'Supprimer',
                                        style: null,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            : Center(
                              child: Text(
                                "Sélectionnez un moyen de paiement",
                                style: AppTextStyle.greyHeading,
                              ),
                            ),
                  ),
                ],
              ),

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Moyens de paiement', style: AppTextStyle.largeindingotext),
        centerTitle: true,
        actions: [
          ActionButton(onPressed: () {}, text: 'Reorganiser'),
          ActionButton(
            onPressed: () {
              final container = ProviderScope.containerOf(context);
              container
                  .read(drawerRiverpod.notifier)
                  .openCreatePaiementMethodeDrawer(_emptyModel);

              _scaffoldKey.currentState?.openEndDrawer();
            },
            text: 'Nouveau',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent/blocs/drawer/drawer_bloc.dart';
import 'package:restaurent/blocs/moyen_de_paiement/moyen_de_paiement_bloc.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/moyen_de_paiement_model.dart';
import 'package:restaurent/screens/widgets/create_button.dart';

import '../../widgets/widgets.dart';

class MoyenPaiementScreen extends StatelessWidget {
  const MoyenPaiementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MoyenDePaiementBloc()),
        BlocProvider(create: (context) => DrawerBloc()),
      ],
      child: MoyenPaiementView(),
    );
  }
}

class MoyenPaiementView extends StatefulWidget {
  MoyenPaiementView({super.key});

  @override
  State<MoyenPaiementView> createState() => _MoyenPaiementViewState();
}

class _MoyenPaiementViewState extends State<MoyenPaiementView> {
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
    typeDeSalleDisponible: salles.first,
    actif: true,
  );
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: BlocBuilder<DrawerBloc, DrawerState>(
        builder: (context, state) {
          if (state is DrawerCreatePaiementMethode) {
            final m = state.model;

            return Drawer(
              width: MediaQuery.of(context).size.width * .3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Créer une nouvelle moyen de paiement',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.greyaccent!,
                            width: .9,
                          ),
                        ),
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Nom de la catégorie',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (value) {
                            final updated = m.copyWith(nom: value);
                            context.read<DrawerBloc>().add(
                              OpenCreatePaiementMethodeDrawer(model: updated),
                            );
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4.0),
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
                                      child: Text(v),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (v) {
                            if (v != null) {
                              final updated = m.copyWith(modeEncaissement: v);
                              context.read<DrawerBloc>().add(
                                OpenCreatePaiementMethodeDrawer(model: updated),
                              );
                            }
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4.0),
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
                                      child: Text(v),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (v) {
                            if (v != null) {
                              final updated = m.copyWith(getsionDuTropPercu: v);
                              context.read<DrawerBloc>().add(
                                OpenCreatePaiementMethodeDrawer(model: updated),
                              );
                            }
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.greyaccent!,
                            width: .9,
                          ),
                        ),
                        child: SwitchListTile(
                          activeColor: AppColors.primary,
                          title: Text('Ouverture du tiroir caisse'),
                          value: m.ouvertureDeTiroirCaisse ?? false,
                          onChanged: (v) {
                            final updated = m.copyWith(
                              ouvertureDeTiroirCaisse: v,
                            );
                            context.read<DrawerBloc>().add(
                              OpenCreatePaiementMethodeDrawer(model: updated),
                            );
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.greyaccent!,
                            width: .9,
                          ),
                        ),
                        child: SwitchListTile(
                          title: Text('Disponible en mode express'),
                          value: m.disponibleEnModeExpress ?? false,
                          activeColor: AppColors.primary,
                          onChanged: (v) {
                            final updated = m.copyWith(
                              disponibleEnModeExpress: v,
                            );
                            context.read<DrawerBloc>().add(
                              OpenCreatePaiementMethodeDrawer(model: updated),
                            );
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4.0),
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
                                      child: Text(v),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (v) {
                            if (v != null) {
                              final updated = m.copyWith(
                                variationDuMoyenDePaiement: v,
                              );
                              context.read<DrawerBloc>().add(
                                OpenCreatePaiementMethodeDrawer(model: updated),
                              );
                            }
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.greyaccent!,
                            width: .9,
                          ),
                        ),
                        child: SwitchListTile(
                          activeColor: AppColors.primary,
                          title: Text('Compter à la fin du service'),
                          value: m.compterAlaFinDuService ?? false,
                          onChanged: (v) {
                            final updated = m.copyWith(
                              compterAlaFinDuService: v,
                            );
                            context.read<DrawerBloc>().add(
                              OpenCreatePaiementMethodeDrawer(model: updated),
                            );
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.greyaccent!,
                            width: .9,
                          ),
                        ),
                        child: SwitchListTile(
                          activeColor: AppColors.primary,
                          title: Text('Renseigner le fond de caisse'),
                          value: m.rensignerleFondDeCaisee ?? false,
                          onChanged: (v) {
                            final updated = m.copyWith(
                              rensignerleFondDeCaisee: v,
                            );
                            context.read<DrawerBloc>().add(
                              OpenCreatePaiementMethodeDrawer(model: updated),
                            );
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.greyaccent!,
                            width: .9,
                          ),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: m.typeDeSalleDisponible,

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.greyaccent!,
                              ),
                            ),
                            labelText: 'Type de salle',
                          ),
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
                              final updated = m.copyWith(
                                typeDeSalleDisponible: v,
                              );
                              context.read<DrawerBloc>().add(
                                OpenCreatePaiementMethodeDrawer(model: updated),
                              );
                            }
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.greyaccent!,
                            width: .9,
                          ),
                        ),
                        child: SwitchListTile(
                          activeColor: AppColors.primary,
                          title: Text('Actif'),
                          value: m.actif ?? false,
                          onChanged: (v) {
                            final updated = m.copyWith(actif: v);
                            context.read<DrawerBloc>().add(
                              OpenCreatePaiementMethodeDrawer(model: updated),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 24),

                      CreateButton(
                        onPressed: () {
                          context.read<MoyenDePaiementBloc>().add(
                            CreateMoyenDePaiementEvent(model: state.model),
                          );
                          nameController.clear();
                          Navigator.pop(context);
                        },
                        buttonText: 'Cree une nouvelle moyen de paiement',
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
                  label: 'Nom',
                  initialValue: state.currentValue as String,
                  onSaved:
                      (v) => context.read<MoyenDePaiementBloc>().add(
                        UpdateMoyenDePaiementEvent(
                          moyenDePaiement: state.model.copyWith(nom: v),
                        ),
                      ),
                );
              case 'modeEncaissement':
                return UpdateAttributeDrawer(
                  label: 'Mode d’encaissement',
                  initialValue: state.currentValue as String,
                  options: modeEncaissementList,
                  onSaved:
                      (v) => context.read<MoyenDePaiementBloc>().add(
                        UpdateMoyenDePaiementEvent(
                          moyenDePaiement: state.model.copyWith(
                            modeEncaissement: v,
                          ),
                        ),
                      ),
                );
              case 'actif':
                return UpdateAttributeDrawer(
                  label: 'Actif',
                  initialValue: (state.currentValue as bool).toString(),
                  options: ['true', 'false'],
                  onSaved:
                      (v) => context.read<MoyenDePaiementBloc>().add(
                        UpdateMoyenDePaiementEvent(
                          moyenDePaiement: state.model.copyWith(
                            actif: v == 'true',
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

      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Moyen de paiement', style: AppTextStyle.largeindingotext),
        centerTitle: true,
        actions: [
          ActionButton(onPressed: () {}, text: 'Reorganiser'),
          ActionButton(
            onPressed: () {
              context.read<DrawerBloc>().add(
                OpenCreatePaiementMethodeDrawer(model: _emptyModel),
              );
              _scaffoldKey.currentState?.openEndDrawer();
            },
            text: 'Nouveau',
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<MoyenDePaiementBloc, MoyenDePaiementState>(
                builder: (context, state) {
                  if (state is MoyenDePaiementInitial) {
                    return ListView(
                      children: [
                        ...state.moyenDePaiement.map(
                          (method) => ListTile(
                            selectedTileColor: Colors.grey.shade300,

                            title: Text(
                              method.nom ?? '',
                              style: AppTextStyle.indingosubHeading,
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            leading:
                                method.icon != null
                                    ? Image.asset(method.icon!)
                                    : const Icon(Icons.payment),
                            selected:
                                method.nom ==
                                (context.read<MoyenDePaiementBloc>().state
                                        as MoyenDePaiementInitial)
                                    .selectedModel
                                    .nom,
                            onTap: () {
                              context.read<MoyenDePaiementBloc>().add(
                                SelectMoyenDePaiement(moyenDePaiement: method),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<MoyenDePaiementBloc, MoyenDePaiementState>(
                builder: (context, state) {
                  if (state is MoyenDePaiementInitial) {
                    final m = state.selectedModel;
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.read<DrawerBloc>().add(
                                        OpenUpdatePaiementMethodeDrawer(
                                          model: m,
                                          attributeName: 'nom',
                                          currentValue: m.nom,
                                        ),
                                      );
                                      _scaffoldKey.currentState
                                          ?.openEndDrawer();
                                    },
                                    child: CustomListTile(
                                      trailing: null,
                                      title: Text(
                                        'Nom',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      trailingwidget: Text(
                                        m.nom!,
                                        style: AppTextStyle.indingosubHeading,
                                      ),
                                      leading: null,
                                    ),
                                  ),
                                  Divider(),
                                  CustomListTile(
                                    trailingwidget:
                                        m.icon != null
                                            ? Image.network(m.icon!)
                                            : Icon(
                                              Icons.restaurant,
                                              color: Colors.indigo.shade400,
                                            ),
                                    title: Text(
                                      "Icone",
                                      style: AppTextStyle.greyHeading,
                                    ),
                                    leading: null,
                                    trailing: null,
                                  ),
                                  Divider(),

                                  InkWell(
                                    onTap: () {
                                      context.read<DrawerBloc>().add(
                                        OpenUpdatePaiementMethodeDrawer(
                                          model: m,
                                          attributeName: 'modeEncaissement',
                                          currentValue: m.modeEncaissement,
                                        ),
                                      );
                                      _scaffoldKey.currentState
                                          ?.openEndDrawer();
                                    },
                                    child: CustomListTile(
                                      leading: null,
                                      trailing: null,
                                      title: Text(
                                        'Mode d’encaissement',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      trailingwidget: Text(
                                        m.modeEncaissement!,
                                        style: AppTextStyle.indingosubHeading,
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  InkWell(
                                    onTap: () {
                                      context.read<DrawerBloc>().add(
                                        OpenUpdatePaiementMethodeDrawer(
                                          model: m,
                                          attributeName: 'GestionDuTropPerçu',
                                          currentValue: m.getsionDuTropPercu,
                                        ),
                                      );
                                      _scaffoldKey.currentState
                                          ?.openEndDrawer();
                                    },
                                    child: CustomListTile(
                                      leading: null,
                                      trailing: null,
                                      title: Text(
                                        'Gestion du trop-perçu',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      trailingwidget: Text(
                                        m.getsionDuTropPercu!,
                                        style: AppTextStyle.indingosubHeading,
                                      ),
                                    ),
                                  ),

                                  Divider(),
                                  InkWell(
                                    onTap: () {
                                      context.read<DrawerBloc>().add(
                                        OpenUpdatePaiementMethodeDrawer(
                                          model: m,
                                          attributeName: 'OuvertureDuTiroir',
                                          currentValue:
                                              m.ouvertureDeTiroirCaisse,
                                        ),
                                      );
                                      _scaffoldKey.currentState
                                          ?.openEndDrawer();
                                    },
                                    child: SwitchListTile(
                                      activeTrackColor: AppColors.primary,
                                      title: Text(
                                        'Ouverture du tiroir caisse',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      value: m.ouvertureDeTiroirCaisse ?? false,
                                      onChanged: null,
                                    ),
                                  ),
                                  Divider(),
                                  InkWell(
                                    onTap: () {
                                      context.read<DrawerBloc>().add(
                                        OpenUpdatePaiementMethodeDrawer(
                                          model: m,
                                          attributeName:
                                              'DisponibleEnModeExpress',
                                          currentValue:
                                              m.disponibleEnModeExpress,
                                        ),
                                      );
                                      _scaffoldKey.currentState
                                          ?.openEndDrawer();
                                    },
                                    child: SwitchListTile(
                                      activeTrackColor: AppColors.primary,
                                      title: Text(
                                        'Disponible en mode express',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      value: m.disponibleEnModeExpress ?? false,
                                      onChanged: null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            InkWell(
                              onTap: () {
                                context.read<DrawerBloc>().add(
                                  OpenUpdatePaiementMethodeDrawer(
                                    model: m,
                                    attributeName:
                                        'VariationsDuMoyenDePaiement',
                                    currentValue: m.variationDuMoyenDePaiement,
                                  ),
                                );
                                _scaffoldKey.currentState?.openEndDrawer();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: CustomListTile(
                                  leading: null,
                                  trailing: null,
                                  title: Text(
                                    'Variations du moyen de paiement',
                                    style: AppTextStyle.greyHeading,
                                  ),
                                  trailingwidget: Text(
                                    m.variationDuMoyenDePaiement!,
                                    style: AppTextStyle.indingosubHeading,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.read<DrawerBloc>().add(
                                        OpenUpdatePaiementMethodeDrawer(
                                          model: m,
                                          attributeName:
                                              'CompterALaFinDuService',
                                          currentValue:
                                              m.compterAlaFinDuService,
                                        ),
                                      );
                                      _scaffoldKey.currentState
                                          ?.openEndDrawer();
                                    },
                                    child: SwitchListTile(
                                      activeTrackColor: AppColors.primary,
                                      title: Text(
                                        'Compter à la fin du service',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      value: m.compterAlaFinDuService ?? false,
                                      onChanged: null,
                                    ),
                                  ),
                                  Divider(),
                                  InkWell(
                                    onTap: () {
                                      context.read<DrawerBloc>().add(
                                        OpenUpdatePaiementMethodeDrawer(
                                          model: m,
                                          attributeName:
                                              'RenseignerLeFondDeCaisse',
                                          currentValue:
                                              m.rensignerleFondDeCaisee,
                                        ),
                                      );
                                      _scaffoldKey.currentState
                                          ?.openEndDrawer();
                                    },
                                    child: SwitchListTile(
                                      activeTrackColor: AppColors.primary,
                                      title: Text(
                                        'Renseigner le fond de caisse',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      value: m.rensignerleFondDeCaisee ?? false,
                                      onChanged: null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.read<DrawerBloc>().add(
                                        OpenUpdatePaiementMethodeDrawer(
                                          model: m,
                                          attributeName:
                                              'DisponibleDansLesSalles',
                                          currentValue:
                                              m.disponibleEnModeExpress,
                                        ),
                                      );
                                      _scaffoldKey.currentState
                                          ?.openEndDrawer();
                                    },
                                    child: CustomListTile(
                                      leading: null,
                                      trailing: null,
                                      title: Text(
                                        'Disponible dans les salles',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      trailingwidget: Text(
                                        m.typeDeSalleDisponible!,
                                        style: AppTextStyle.indingosubHeading,
                                      ),
                                    ),
                                  ),

                                  Divider(),
                                  InkWell(
                                    onTap: () {
                                      context.read<DrawerBloc>().add(
                                        OpenUpdatePaiementMethodeDrawer(
                                          model: m,
                                          attributeName: 'actif',
                                          currentValue: m.actif,
                                        ),
                                      );
                                      _scaffoldKey.currentState
                                          ?.openEndDrawer();
                                    },
                                    child: SwitchListTile(
                                      activeTrackColor: AppColors.primary,
                                      title: Text(
                                        'Actif',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      value: m.actif!,
                                      onChanged: null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            ButtonSupprimer(onTap: () {}),
                          ],
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: Text('Sélectionnez un moyen de paiement'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UpdateAttributeDrawer extends StatelessWidget {
  final String label;
  final String initialValue;
  final List<String>? options;
  final void Function(String) onSaved;
  const UpdateAttributeDrawer({
    Key? key,
    required this.label,
    required this.initialValue,
    this.options,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = TextEditingController(text: initialValue);
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 16),
            if (options == null)
              TextFormField(controller: ctrl)
            else
              DropdownButtonFormField<String>(
                value: initialValue,
                items:
                    options!
                        .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                        .toList(),
                onChanged: (v) => ctrl.text = v!,
              ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                onSaved(ctrl.text);
                Navigator.of(context).pop();
              },
              child: const Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}

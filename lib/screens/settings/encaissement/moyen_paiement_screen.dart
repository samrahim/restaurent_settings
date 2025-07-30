import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/models.dart';
import 'package:restaurent/providers/providers.dart';
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

  @override
  Widget build(BuildContext context) {
    final moyenDePaiementState = ref.watch(moyenDePaiementRiverpod);
    final moyenDePaiementNotifier = ref.read(moyenDePaiementRiverpod.notifier);

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _endDrawer(moyenDePaiementNotifier, _scaffoldKey),

      body: Row(
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
                              trailing: const Icon(Icons.arrow_forward_ios),
                              selected:
                                  moyenDePaiementState.selected != null &&
                                  moyen.id == moyenDePaiementState.selected!.id,
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
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Padding(
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
                                    CustomListTile(
                                      onTap: () {
                                        context
                                            .read<DrawerProvider>()
                                            .openUpdatePaiementMethodeDrawer(
                                              moyenDePaiementState.selected!,
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
                                        moyenDePaiementState.selected!.nom!,
                                        style: AppTextStyle.indingosubHeading,
                                      ),
                                      leading: null,
                                    ),
                                    const Divider(),
                                    CustomListTile(
                                      onTap: () {
                                        context
                                            .read<DrawerProvider>()
                                            .openUpdatePaiementMethodeDrawer(
                                              moyenDePaiementState.selected!,
                                              'description',
                                              moyenDePaiementState
                                                  .selected!
                                                  .description,
                                            );
                                        _scaffoldKey.currentState
                                            ?.openEndDrawer();
                                      },
                                      leading: null,
                                      trailing: null,
                                      title: Text(
                                        'Description',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      trailingwidget: Text(
                                        moyenDePaiementState
                                            .selected!
                                            .description!,
                                        style: AppTextStyle.indingosubHeading,
                                      ),
                                    ),
                                    const Divider(),
                                    CustomListTile(
                                      onTap: () {
                                        context
                                            .read<DrawerProvider>()
                                            .openUpdatePaiementMethodeDrawer(
                                              moyenDePaiementState.selected!,
                                              'icone',
                                              moyenDePaiementState
                                                  .selected!
                                                  .icone,
                                            );
                                        _scaffoldKey.currentState
                                            ?.openEndDrawer();
                                      },
                                      leading: null,
                                      trailing: null,
                                      title: Text(
                                        'Icône',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      trailingwidget: Text(
                                        moyenDePaiementState.selected!.icone!,
                                        style: AppTextStyle.indingosubHeading,
                                      ),
                                    ),
                                    const Divider(),
                                    CustomListTile(
                                      onTap: () {
                                        context
                                            .read<DrawerProvider>()
                                            .openUpdatePaiementMethodeDrawer(
                                              moyenDePaiementState.selected!,
                                              'couleur',
                                              moyenDePaiementState
                                                  .selected!
                                                  .couleur,
                                            );
                                        _scaffoldKey.currentState
                                            ?.openEndDrawer();
                                      },
                                      leading: null,
                                      trailing: null,
                                      title: Text(
                                        'Couleur',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      trailingwidget: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: hexToColor(
                                            moyenDePaiementState
                                                .selected!
                                                .couleur!,
                                          ),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.black26,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Divider(),
                                    CustomListTile(
                                      onTap: () {
                                        context
                                            .read<DrawerProvider>()
                                            .openUpdatePaiementMethodeDrawer(
                                              moyenDePaiementState.selected!,
                                              'actif',
                                              moyenDePaiementState
                                                  .selected!
                                                  .actif,
                                            );
                                        _scaffoldKey.currentState
                                            ?.openEndDrawer();
                                      },
                                      leading: null,
                                      trailing: null,
                                      title: Text(
                                        'Actif',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      trailingwidget: Switch(
                                        activeTrackColor: AppColors.primary,
                                        value:
                                            moyenDePaiementState
                                                .selected!
                                                .actif!,
                                        onChanged: null,
                                      ),
                                    ),
                                    const Divider(),
                                    CustomListTile(
                                      onTap: () {
                                        context
                                            .read<DrawerProvider>()
                                            .openUpdatePaiementMethodeDrawer(
                                              moyenDePaiementState.selected!,
                                              'type',
                                              moyenDePaiementState
                                                  .selected!
                                                  .type,
                                            );
                                        _scaffoldKey.currentState
                                            ?.openEndDrawer();
                                      },
                                      leading: null,
                                      trailing: null,
                                      title: Text(
                                        'Type',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      trailingwidget: Text(
                                        moyenDePaiementState.selected!.type!,
                                        style: AppTextStyle.indingosubHeading,
                                      ),
                                    ),
                                    const Divider(),
                                    CustomListTile(
                                      onTap: () {
                                        context
                                            .read<DrawerProvider>()
                                            .openUpdatePaiementMethodeDrawer(
                                              moyenDePaiementState.selected!,
                                              'compte',
                                              moyenDePaiementState
                                                  .selected!
                                                  .compte,
                                            );
                                        _scaffoldKey.currentState
                                            ?.openEndDrawer();
                                      },
                                      leading: null,
                                      trailing: null,
                                      title: Text(
                                        'Compte',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      trailingwidget: Text(
                                        moyenDePaiementState.selected!.compte!,
                                        style: AppTextStyle.indingosubHeading,
                                      ),
                                    ),
                                    const Divider(),
                                    CustomListTile(
                                      onTap: () {
                                        context
                                            .read<DrawerProvider>()
                                            .openUpdatePaiementMethodeDrawer(
                                              moyenDePaiementState.selected!,
                                              'taux',
                                              moyenDePaiementState
                                                  .selected!
                                                  .taux,
                                            );
                                        _scaffoldKey.currentState
                                            ?.openEndDrawer();
                                      },
                                      leading: null,
                                      trailing: null,
                                      title: Text(
                                        'Taux',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      trailingwidget: Text(
                                        moyenDePaiementState.selected!.taux!
                                            .toString(),
                                        style: AppTextStyle.indingosubHeading,
                                      ),
                                    ),
                                    const Divider(),
                                    CustomListTile(
                                      onTap: () {
                                        context
                                            .read<DrawerProvider>()
                                            .openUpdatePaiementMethodeDrawer(
                                              moyenDePaiementState.selected!,
                                              'ordre',
                                              moyenDePaiementState
                                                  .selected!
                                                  .ordre,
                                            );
                                        _scaffoldKey.currentState
                                            ?.openEndDrawer();
                                      },
                                      leading: null,
                                      trailing: null,
                                      title: Text(
                                        'Ordre',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      trailingwidget: Text(
                                        moyenDePaiementState.selected!.ordre!
                                            .toString(),
                                        style: AppTextStyle.indingosubHeading,
                                      ),
                                    ),
                                    const Divider(),
                                    CustomListTile(
                                      onTap: () {
                                        context
                                            .read<DrawerProvider>()
                                            .openUpdatePaiementMethodeDrawer(
                                              moyenDePaiementState.selected!,
                                              'tva',
                                              moyenDePaiementState
                                                  .selected!
                                                  .tva,
                                            );
                                        _scaffoldKey.currentState
                                            ?.openEndDrawer();
                                      },
                                      leading: null,
                                      trailing: null,
                                      title: Text(
                                        'TVA',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      trailingwidget: Text(
                                        moyenDePaiementState.selected!.tva!
                                            .toString(),
                                        style: AppTextStyle.indingosubHeading,
                                      ),
                                    ),
                                    const Divider(),
                                    CustomListTile(
                                      onTap: () {
                                        context
                                            .read<DrawerProvider>()
                                            .openUpdatePaiementMethodeDrawer(
                                              moyenDePaiementState.selected!,
                                              'salle',
                                              moyenDePaiementState
                                                  .selected!
                                                  .salle,
                                            );
                                        _scaffoldKey.currentState
                                            ?.openEndDrawer();
                                      },
                                      leading: null,
                                      trailing: null,
                                      title: Text(
                                        'Salle',
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      trailingwidget: Text(
                                        moyenDePaiementState.selected!.salle!,
                                        style: AppTextStyle.indingosubHeading,
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
      endDrawer: provider_package.Consumer<DrawerProvider>(
        builder: (context, drawerProvider, _) {
          final state = drawerProvider.state;
          if (state is DrawerCreatePaiementMethode) {
            return _buildCreatePaiementMethodeDrawer(state.model);
          }
          if (state is DrawerUpdateMoyenDePaiement) {
            return UpdateAttributeDrawer(
              fieldType: _getFieldType(state.attributeName),
              label: state.attributeName,
              initialValue: state.currentValue,
              onSaved: (value) {
                final updated = _applyUpdatedValue(
                  state.attributeName,
                  state.model,
                  value,
                );
                moyenDePaiementNotifier.update(updated);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Moyens de paiement', style: AppTextStyle.largeindingotext),
        centerTitle: true,
        actions: [
          ActionButton(onPressed: () {}, text: 'Reorganiser'),
          ActionButton(
            onPressed: () {
              context.read<DrawerProvider>().openCreatePaiementMethodeDrawer(
                MoyenDePaiementModel(
                  id: '',
                  nom: '',
                  description: '',
                  icone: '',
                  couleur: '#000000',
                  actif: true,
                  type: '',
                  compte: '',
                  taux: 0.0,
                  ordre: 0,
                  tva: 0.0,
                  salle: '',
                ),
              );
              _scaffoldKey.currentState?.openEndDrawer();
            },
            text: 'Nouveau',
          ),
        ],
      ),
    );
  }

  Widget _endDrawer(
    MoyenDePaiementNotifier notifier,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    return provider_package.Consumer<DrawerProvider>(
      builder: (context, drawerProvider, _) {
        final state = drawerProvider.state;
        if (state is DrawerCreatePaiementMethode) {
          return _buildCreatePaiementMethodeDrawer(state.model);
        }
        if (state is DrawerUpdateMoyenDePaiement) {
          return UpdateAttributeDrawer(
            fieldType: _getFieldType(state.attributeName),
            label: state.attributeName,
            initialValue: state.currentValue,
            onSaved: (value) {
              final updated = _applyUpdatedValue(
                state.attributeName,
                state.model,
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

  Widget _buildCreatePaiementMethodeDrawer(MoyenDePaiementModel model) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0),
              child: Text(
                'Créer un nouveau moyen de paiement',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            _buildNomField(model),
            const SizedBox(height: 16),
            _buildDescriptionField(model),
            const SizedBox(height: 16),
            _buildIconeField(model),
            const SizedBox(height: 16),
            _buildCouleurField(model),
            const SizedBox(height: 16),
            _buildActifField(model),
            const SizedBox(height: 16),
            _buildTypeField(model),
            const SizedBox(height: 16),
            _buildCompteField(model),
            const SizedBox(height: 16),
            _buildTauxField(model),
            const SizedBox(height: 16),
            _buildOrdreField(model),
            const SizedBox(height: 16),
            _buildTvaField(model),
            const SizedBox(height: 16),
            _buildSalleField(model),
            const SizedBox(height: 32),
            _buildCreateButton(model),
          ],
        ),
      ),
    );
  }

  Widget _buildNomField(MoyenDePaiementModel model) {
    return CustomContainer(
      child: TextFormField(
        initialValue: model.nom,
        decoration: const InputDecoration(
          labelText: 'Nom',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          final updated = model.copyWith(nom: value);
          context.read<DrawerProvider>().openCreatePaiementMethodeDrawer(
            updated,
          );
        },
      ),
    );
  }

  Widget _buildDescriptionField(MoyenDePaiementModel model) {
    return CustomContainer(
      child: TextFormField(
        initialValue: model.description,
        decoration: const InputDecoration(
          labelText: 'Description',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          final updated = model.copyWith(description: value);
          context.read<DrawerProvider>().openCreatePaiementMethodeDrawer(
            updated,
          );
        },
      ),
    );
  }

  Widget _buildIconeField(MoyenDePaiementModel model) {
    return CustomContainer(
      child: TextFormField(
        initialValue: model.icone,
        decoration: const InputDecoration(
          labelText: 'Icône',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          final updated = model.copyWith(icone: value);
          context.read<DrawerProvider>().openCreatePaiementMethodeDrawer(
            updated,
          );
        },
      ),
    );
  }

  Widget _buildCouleurField(MoyenDePaiementModel model) {
    return CustomContainer(
      child: CustomListTile(
        leading: 'Couleur',
        title: null,
        trailing: null,
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Choisir une couleur'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: hexToColor(model.couleur ?? '#000000'),
                    onColorChanged: (Color color) {
                      final updated = model.copyWith(
                        couleur: '#${color.value.toRadixString(16)}',
                      );
                      context
                          .read<DrawerProvider>()
                          .openCreatePaiementMethodeDrawer(updated);
                    },
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        trailingwidget: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: hexToColor(model.couleur ?? '#000000'),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildActifField(MoyenDePaiementModel model) {
    return CustomContainer(
      child: DropdownButtonFormField<bool>(
        value: model.actif,
        decoration: const InputDecoration(
          labelText: 'Actif',
          border: InputBorder.none,
        ),
        items: const [
          DropdownMenuItem(value: true, child: Text('Oui')),
          DropdownMenuItem(value: false, child: Text('Non')),
        ],
        onChanged: (value) {
          if (value != null) {
            final updated = model.copyWith(actif: value);
            context.read<DrawerProvider>().openCreatePaiementMethodeDrawer(
              updated,
            );
          }
        },
      ),
    );
  }

  Widget _buildTypeField(MoyenDePaiementModel model) {
    return CustomContainer(
      child: TextFormField(
        initialValue: model.type,
        decoration: const InputDecoration(
          labelText: 'Type',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          final updated = model.copyWith(type: value);
          context.read<DrawerProvider>().openCreatePaiementMethodeDrawer(
            updated,
          );
        },
      ),
    );
  }

  Widget _buildCompteField(MoyenDePaiementModel model) {
    return CustomContainer(
      child: TextFormField(
        initialValue: model.compte,
        decoration: const InputDecoration(
          labelText: 'Compte',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          final updated = model.copyWith(compte: value);
          context.read<DrawerProvider>().openCreatePaiementMethodeDrawer(
            updated,
          );
        },
      ),
    );
  }

  Widget _buildTauxField(MoyenDePaiementModel model) {
    return CustomContainer(
      child: TextFormField(
        initialValue: model.taux?.toString(),
        decoration: const InputDecoration(
          labelText: 'Taux',
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          final taux = double.tryParse(value) ?? 0.0;
          final updated = model.copyWith(taux: taux);
          context.read<DrawerProvider>().openCreatePaiementMethodeDrawer(
            updated,
          );
        },
      ),
    );
  }

  Widget _buildOrdreField(MoyenDePaiementModel model) {
    return CustomContainer(
      child: TextFormField(
        initialValue: model.ordre?.toString(),
        decoration: const InputDecoration(
          labelText: 'Ordre',
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          final ordre = int.tryParse(value) ?? 0;
          final updated = model.copyWith(ordre: ordre);
          context.read<DrawerProvider>().openCreatePaiementMethodeDrawer(
            updated,
          );
        },
      ),
    );
  }

  Widget _buildTvaField(MoyenDePaiementModel model) {
    return CustomContainer(
      child: TextFormField(
        initialValue: model.tva?.toString(),
        decoration: const InputDecoration(
          labelText: 'TVA',
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          final tva = double.tryParse(value) ?? 0.0;
          final updated = model.copyWith(tva: tva);
          context.read<DrawerProvider>().openCreatePaiementMethodeDrawer(
            updated,
          );
        },
      ),
    );
  }

  Widget _buildSalleField(MoyenDePaiementModel model) {
    return CustomContainer(
      child: TextFormField(
        initialValue: model.salle,
        decoration: const InputDecoration(
          labelText: 'Salle',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          final updated = model.copyWith(salle: value);
          context.read<DrawerProvider>().openCreatePaiementMethodeDrawer(
            updated,
          );
        },
      ),
    );
  }

  Widget _buildCreateButton(MoyenDePaiementModel model) {
    return CreateButton(
      onPressed: () {
        final moyenDePaiementNotifier = ref.read(
          moyenDePaiementRiverpod.notifier,
        );
        moyenDePaiementNotifier.create(model);
        _scaffoldKey.currentState?.closeEndDrawer();
        context.read<DrawerProvider>().resetDrawer();
      },
      buttonText: 'Créer un nouveau moyen de paiement',
    );
  }

  FieldType _getFieldType(String attributeName) {
    switch (attributeName) {
      case 'nom':
      case 'description':
      case 'icone':
      case 'type':
      case 'compte':
      case 'salle':
        return FieldType.string;
      case 'couleur':
        return FieldType.color;
      case 'actif':
        return FieldType.boolean;
      case 'taux':
      case 'tva':
        return FieldType.number;
      case 'ordre':
        return FieldType.number;
      default:
        return FieldType.string;
    }
  }

  MoyenDePaiementModel _applyUpdatedValue(
    String attribute,
    MoyenDePaiementModel model,
    dynamic value,
  ) {
    switch (attribute) {
      case 'nom':
        return model.copyWith(nom: value as String);
      case 'description':
        return model.copyWith(description: value as String);
      case 'icone':
        return model.copyWith(icone: value as String);
      case 'couleur':
        return model.copyWith(couleur: value as String);
      case 'actif':
        return model.copyWith(actif: value as bool);
      case 'type':
        return model.copyWith(type: value as String);
      case 'compte':
        return model.copyWith(compte: value as String);
      case 'taux':
        return model.copyWith(taux: value as double);
      case 'ordre':
        return model.copyWith(ordre: value as int);
      case 'tva':
        return model.copyWith(tva: value as double);
      case 'salle':
        return model.copyWith(salle: value as String);
      default:
        return model;
    }
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

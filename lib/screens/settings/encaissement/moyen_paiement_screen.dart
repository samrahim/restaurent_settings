import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent/blocs/moyen_de_paiement/moyen_de_paiement_bloc.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/moyen_de_paiement_model.dart';

import '../../widgets/widgets.dart';

class MoyenPaiementScreen extends StatelessWidget {
  const MoyenPaiementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoyenDePaiementBloc(),
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width * .25,
        child: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Nom de la catégorie",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.indigo),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<MoyenDePaiementBloc>().add(
                  CreateMoyenDePaiementEvent(moyenDePaiementName: name.text),
                );
                name.clear();
                Navigator.pop(context);
              },
              child: Text("Ajouter"),
            ),
          ],
        ),
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
                              method.name ?? '',
                              style: AppTextStyle.indingosubHeading,
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            leading:
                                method.icon != null
                                    ? Image.asset(method.icon!)
                                    : const Icon(Icons.payment),
                            selected:
                                method.name ==
                                (context.read<MoyenDePaiementBloc>().state
                                        as MoyenDePaiementInitial)
                                    .selectedModel
                                    .name,
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
                    final method = state.selectedModel;
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
                                  CustomListTile(
                                    trailingwidget: Text(
                                      method.name!,
                                      style: AppTextStyle.indingosubHeading,
                                    ),
                                    title: Text(
                                      "Nom",
                                      style: AppTextStyle.greyHeading,
                                    ),
                                    leading: null,
                                    trailing: null,
                                  ),
                                  Divider(),
                                  CustomListTile(
                                    trailingwidget:
                                        method.icon != null
                                            ? Image.network(method.icon!)
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
                                  CustomListTile(
                                    leading: null,
                                    trailing: null,
                                    title: Text(
                                      'Mode d’encaissement',
                                      style: AppTextStyle.greyHeading,
                                    ),
                                    trailingwidget: DropdownButton<String>(
                                      style: AppTextStyle.indingosubHeading,
                                      underline: SizedBox(),
                                      value:
                                          MoyenDePaiementModel
                                                  .modeEncaissementList
                                                  .contains(
                                                    method.modeEncaissement,
                                                  )
                                              ? method.modeEncaissement
                                              : MoyenDePaiementModel
                                                  .modeEncaissementList
                                                  .first,
                                      items:
                                          MoyenDePaiementModel
                                              .modeEncaissementList
                                              .map(
                                                (value) => DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value),
                                                ),
                                              )
                                              .toList(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          context
                                              .read<MoyenDePaiementBloc>()
                                              .add(
                                                UpdateMoyenDePaiementEvent(
                                                  moyenDePaiement: method
                                                      .copyWith(
                                                        modeEncaissement: value,
                                                      ),
                                                ),
                                              );
                                        }
                                      },
                                    ),
                                  ),

                                  Divider(),
                                  CustomListTile(
                                    leading: null,
                                    trailing: null,
                                    title: Text(
                                      'Gestion du trop-perçu',
                                      style: AppTextStyle.greyHeading,
                                    ),
                                    trailingwidget: DropdownButton<String>(
                                      style: AppTextStyle.indingosubHeading,
                                      underline: SizedBox(),
                                      value:
                                          MoyenDePaiementModel
                                                  .gestionDuTropPercuList
                                                  .contains(
                                                    method.getsionDuTropPercu,
                                                  )
                                              ? method.getsionDuTropPercu
                                              : MoyenDePaiementModel
                                                  .gestionDuTropPercuList
                                                  .first,
                                      items:
                                          MoyenDePaiementModel
                                              .gestionDuTropPercuList
                                              .map(
                                                (value) => DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value),
                                                ),
                                              )
                                              .toList(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          context
                                              .read<MoyenDePaiementBloc>()
                                              .add(
                                                UpdateMoyenDePaiementEvent(
                                                  moyenDePaiement: method
                                                      .copyWith(
                                                        getsionDuTropPercu:
                                                            value,
                                                      ),
                                                ),
                                              );
                                        }
                                      },
                                    ),
                                  ),

                                  Divider(),
                                  SwitchListTile(
                                    activeColor: Colors.blue,
                                    title: Text(
                                      'Ouverture du tiroir caisse',
                                      style: AppTextStyle.greyHeading,
                                    ),
                                    value:
                                        method.ouvertureDeTiroirCaisse ?? false,
                                    onChanged: (value) {
                                      context.read<MoyenDePaiementBloc>().add(
                                        UpdateMoyenDePaiementEvent(
                                          moyenDePaiement: method.copyWith(
                                            ouvertureDeTiroirCaisse: value,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Divider(),
                                  SwitchListTile(
                                    activeColor: Colors.blue,
                                    title: Text(
                                      'Disponible en mode express',
                                      style: AppTextStyle.greyHeading,
                                    ),
                                    value:
                                        method.disponibleEnModeExpress ?? false,
                                    onChanged: (value) {
                                      context.read<MoyenDePaiementBloc>().add(
                                        UpdateMoyenDePaiementEvent(
                                          moyenDePaiement: method.copyWith(
                                            disponibleEnModeExpress: value,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
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
                                trailingwidget: DropdownButton<String>(
                                  style: AppTextStyle.indingosubHeading,
                                  underline: SizedBox(),
                                  value:
                                      MoyenDePaiementModel.variations.contains(
                                            method.variationDuMoyenDePaiement,
                                          )
                                          ? method.variationDuMoyenDePaiement
                                          : MoyenDePaiementModel
                                              .variations
                                              .first,
                                  items:
                                      MoyenDePaiementModel.variations
                                          .map(
                                            (value) => DropdownMenuItem(
                                              value: value,
                                              child: Text(value),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      context.read<MoyenDePaiementBloc>().add(
                                        UpdateMoyenDePaiementEvent(
                                          moyenDePaiement: method.copyWith(
                                            variationDuMoyenDePaiement: value,
                                          ),
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
                              ),
                              child: Column(
                                children: [
                                  SwitchListTile(
                                    activeColor: Colors.blue,
                                    title: Text(
                                      'Compter à la fin du service',
                                      style: AppTextStyle.greyHeading,
                                    ),
                                    value:
                                        method.compterAlaFinDuService ?? false,
                                    onChanged: (value) {
                                      context.read<MoyenDePaiementBloc>().add(
                                        UpdateMoyenDePaiementEvent(
                                          moyenDePaiement: method.copyWith(
                                            compterAlaFinDuService: value,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Divider(),
                                  SwitchListTile(
                                    activeColor: Colors.blue,
                                    title: Text(
                                      'Renseigner le fond de caisse',
                                      style: AppTextStyle.greyHeading,
                                    ),
                                    value:
                                        method.rensignerleFondDeCaisee ?? false,
                                    onChanged: (value) {
                                      context.read<MoyenDePaiementBloc>().add(
                                        UpdateMoyenDePaiementEvent(
                                          moyenDePaiement: method.copyWith(
                                            rensignerleFondDeCaisee: value,
                                          ),
                                        ),
                                      );
                                    },
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
                                  CustomListTile(
                                    leading: null,
                                    trailing: null,
                                    title: Text(
                                      'Disponible dans les salles',
                                      style: AppTextStyle.greyHeading,
                                    ),
                                    trailingwidget: DropdownButton<String>(
                                      style: AppTextStyle.indingosubHeading,
                                      underline: SizedBox(),
                                      value:
                                          salles.contains(
                                                method.typeDeSalleDisponible,
                                              )
                                              ? method.typeDeSalleDisponible
                                              : salles.first,
                                      items:
                                          salles
                                              .map(
                                                (value) => DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value),
                                                ),
                                              )
                                              .toList(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          context
                                              .read<MoyenDePaiementBloc>()
                                              .add(
                                                UpdateMoyenDePaiementEvent(
                                                  moyenDePaiement: method
                                                      .copyWith(
                                                        typeDeSalleDisponible:
                                                            value,
                                                      ),
                                                ),
                                              );
                                        }
                                      },
                                    ),
                                  ),

                                  Divider(),
                                  SwitchListTile(
                                    activeColor: Colors.blue,
                                    title: Text(
                                      'Actif',
                                      style: AppTextStyle.greyHeading,
                                    ),
                                    value: method.actif ?? false,
                                    onChanged: (value) {
                                      context.read<MoyenDePaiementBloc>().add(
                                        UpdateMoyenDePaiementEvent(
                                          moyenDePaiement: method.copyWith(
                                            actif: value,
                                          ),
                                        ),
                                      );
                                    },
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

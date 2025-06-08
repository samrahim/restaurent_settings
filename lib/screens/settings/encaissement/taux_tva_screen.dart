import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent/blocs/drawer/drawer_bloc.dart';
import 'package:restaurent/blocs/taux_tva_bloc/taux_et_tva_bloc.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/taux_tva_model.dart';
import 'package:restaurent/screens/widgets/widgets.dart';

class TauxTVAScreen extends StatelessWidget {
  const TauxTVAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TauxEtTvaBloc()),
        BlocProvider(create: (context) => DrawerBloc()),
      ],
      child: TauxTVAScreenView(),
    );
  }
}

class TauxTVAScreenView extends StatefulWidget {
  const TauxTVAScreenView({super.key});

  @override
  State<TauxTVAScreenView> createState() => _TauxTVAScreenViewState();
}

class _TauxTVAScreenViewState extends State<TauxTVAScreenView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final tauxTvaController = TextEditingController();

  final tauxTVAValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _buildDrawerWithBloc(context),
      appBar: AppBar(
        title: Text('Taux de TVA', style: AppTextStyle.largeindingotext),
        centerTitle: true,
        actions: [
          ActionButton(
            onPressed: () {
              context.read<DrawerBloc>().add(OpenCreateTauxTvaDrawer());
              _scaffoldKey.currentState?.openEndDrawer();
            },
            text: 'Nouveau',
          ),
        ],
      ),
      body: BlocBuilder<TauxEtTvaBloc, TauxEtTvaState>(
        builder: (context, state) {
          if (state is TauxEtTvaInitial) {
            return state.tauxTvas != null
                ? ListView.builder(
                  itemCount: state.tauxTvas!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                "TVA ${state.tauxTvas![index].tauxTva} %",
                                style: AppTextStyle.indingoHeading,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                '${state.selectedTauxTva?.elementsInclus} éléments',
                                style: AppTextStyle.greysubHeading,
                              ),
                            ),

                            Expanded(
                              flex: 2,
                              child: Container(
                                color: Colors.grey.shade300,
                                child: TextFormField(
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  initialValue: state.tauxTvas![index].tauxTva
                                      .toStringAsFixed(2),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ce champ est obligatoire';
                                    }
                                    try {
                                      double.parse(value);
                                      return null;
                                    } catch (e) {
                                      return 'Veuillez saisir un nombre valide';
                                    }
                                  },
                                  onChanged: (value) {
                                    try {
                                      final number = double.parse(value);
                                      context.read<TauxEtTvaBloc>().add(
                                        UpdateTauxTva(
                                          tauxTvaModel: TauxTvaModel(
                                            id: state.tauxTvas![index].id,
                                            tauxTva: number,
                                            elementsInclus:
                                                state
                                                    .tauxTvas![index]
                                                    .elementsInclus,
                                          ),
                                        ),
                                      );
                                    } catch (e) {
                                      // Invalid number, error will be shown by validator
                                    }
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
                : Center(child: Text("Aucun Taux de TVA trouvé"));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDrawerWithBloc(BuildContext context) {
    return BlocListener<DrawerBloc, DrawerState>(
      listener: (context, state) {
        if (state is DrawerCreateTauxTva && state.isOpen) {
          tauxTVAValue.clear();
        }
      },
      child: Drawer(
        width: MediaQuery.of(context).size.width * 0.3,
        child: BlocBuilder<DrawerBloc, DrawerState>(
          builder: (context, state) {
            return _buildDrawerContent(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildDrawerContent(BuildContext context, DrawerState state) {
    if (state is DrawerCreateTauxTva) {
      tauxTVAValue.clear();
      return _buildCreateTVADrawer(context);
    }
    return Container(); // Default empty drawer
  }

  Widget _buildCreateTVADrawer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Créer un nouvel Taux de TVA',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),

              TextField(
                controller: tauxTvaController,
                decoration: InputDecoration(
                  labelText: 'Taux de TVA',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
            ],
          ),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                context.read<TauxEtTvaBloc>().add(
                  CreatTauxTva(
                    tauxTva: int.parse(tauxTvaController.text).toDouble(),

                    elementsInclus: Random().nextInt(100),
                  ),
                );
                tauxTvaController.clear();
                _scaffoldKey.currentState?.closeEndDrawer();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Ajouter",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

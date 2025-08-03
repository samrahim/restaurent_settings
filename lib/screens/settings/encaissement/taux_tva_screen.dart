import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/taux_tva_model.dart';
import 'package:restaurent/riverpods/drawer_riverpod/drawer_state.dart';
import 'package:restaurent/screens/reglage_screen.dart';
import 'package:restaurent/widgets/widgets.dart';

class TauxTVAScreen extends ConsumerStatefulWidget {
  const TauxTVAScreen({super.key});

  @override
  ConsumerState<TauxTVAScreen> createState() => _TauxTVAScreenState();
}

class _TauxTVAScreenState extends ConsumerState<TauxTVAScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final tauxTvaController = TextEditingController();

  final tauxTVAValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tauxEtTvaState = ref.watch(tauxEtTvaRiverpod);
    final tauxEtTvaNotifier = ref.read(tauxEtTvaRiverpod.notifier);

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _buildDrawerWithBloc(context),
      appBar: AppBar(
        title: Text('Taux de TVA', style: AppTextStyle.largeindingotext),
        centerTitle: true,
        actions: [
          ActionButton(
            onPressed: () {
              final container = ProviderScope.containerOf(context);
              container.read(drawerRiverpod.notifier).openCreateTauxTvaDrawer();

              _scaffoldKey.currentState?.openEndDrawer();
              // context.read<DrawerProvider>().openCreateTauxTvaDrawer();
              // _scaffoldKey.currentState?.openEndDrawer();
            },
            text: 'Nouveau',
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final tauxList = tauxEtTvaState.tauxTvas;
          final selected = tauxEtTvaState.selected;

          if (tauxList.isEmpty) {
            return const Center(child: Text("Aucun Taux de TVA trouvé"));
          }

          return ListView.builder(
            itemCount: tauxList.length,
            itemBuilder: (context, index) {
              final tva = tauxList[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          "TVA ${tva.tauxTva} %",
                          style: AppTextStyle.indingoHeading,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          "${selected?.elementsInclus ?? 0} éléments",
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
                            initialValue: tva.tauxTva!.toStringAsFixed(2),
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
                                tauxEtTvaNotifier.updateTauxTva(
                                  TauxTvaModel(
                                    id: tva.id,
                                    tauxTva: number,
                                    elementsInclus: tva.elementsInclus,
                                  ),
                                );
                              } catch (_) {}
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
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
          );
        },
      ),
    );
  }

  Widget _buildDrawerWithBloc(BuildContext context) {
    return Consumer(
      builder: (context, drawerProvider, _) {
        final state = ref.watch(drawerRiverpod);

        return _buildDrawerContent(context, state);
      },
    );
  }

  Widget _buildDrawerContent(BuildContext context, DrawerState state) {
    if (state is DrawerCreateTauxTva) {
      tauxTVAValue.clear();
      return _buildCreateTVADrawer(context);
    }
    return Container();
  }

  Widget _buildCreateTVADrawer(BuildContext context) {
    final tauxEtTvaNotifier = ref.read(tauxEtTvaRiverpod.notifier);

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Padding(
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
                  tauxEtTvaNotifier.createTauxTva(
                    double.parse(tauxTvaController.text),
                    Random().nextInt(100),
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
      ),
    );
  }
}

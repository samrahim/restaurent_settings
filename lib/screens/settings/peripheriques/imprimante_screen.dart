import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurent/providers/providers.dart';

class ImprimanteScreen extends StatefulWidget {
  const ImprimanteScreen({super.key});

  @override
  State<ImprimanteScreen> createState() => _ImprimanteScreenState();
}

class _ImprimanteScreenState extends State<ImprimanteScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: _endDrawer(),

      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                context.read<DrawerProvider>().openCreateImprimantDrawer();
                scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ),
          Text("data"),
        ],
      ),
    );
  }

  Widget _endDrawer() {
    return Consumer2<DrawerProvider, ImprimanteDrawerProvider>(
      builder: (context, drawerProvider, imprimanteProvider, _) {
        final state = drawerProvider.state;
        if (state is DrawerCreateImprimant) {
          return Drawer(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  const Text(
                    "Type de connexion",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<ImprimanteType>(
                    value: imprimanteProvider.selectedType,
                    hint: const Text("Choisir un type"),
                    items:
                        ImprimanteType.values.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type.name.toUpperCase()),
                          );
                        }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        imprimanteProvider.selectType(value);
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  if (imprimanteProvider.selectedType ==
                      ImprimanteType.tcpip) ...[
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Adresse IP",
                      ),
                      onChanged: imprimanteProvider.updateIP,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: "Port"),
                      keyboardType: TextInputType.number,
                      onChanged: imprimanteProvider.updatePort,
                    ),
                    const SizedBox(height: 8),
                    if (imprimanteProvider.isValidConnection &&
                        context.mounted) ...[
                      TextField(
                        decoration: const InputDecoration(
                          labelText: "Nom de la machine",
                        ),
                        onChanged: imprimanteProvider.updateMachineName,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          await imprimanteProvider.printTestReceipt();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Test print sent!")),
                          );
                        },
                        child: const Text("Test Print"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Imprimante sauvegardée"),
                            ),
                          );
                        },
                        child: const Text("Enregistrer"),
                      ),
                    ],

                    if ([
                      ImprimanteType.bluetooth,
                      ImprimanteType.usb,
                      ImprimanteType.serie,
                    ].contains(imprimanteProvider.selectedType)) ...[
                      const SizedBox(height: 32),
                      const Text(
                        "La configuration pour ce type sera ajoutée plus tard.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

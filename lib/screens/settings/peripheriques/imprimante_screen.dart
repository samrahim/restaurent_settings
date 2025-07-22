import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/peripherique_model.dart.dart';
import 'package:restaurent/providers/providers.dart';
import 'package:restaurent/widgets/widgets.dart';

class ImprimanteScreen extends StatefulWidget {
  const ImprimanteScreen({super.key});

  @override
  State<ImprimanteScreen> createState() => _ImprimanteScreenState();
}

class _ImprimanteScreenState extends State<ImprimanteScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ImprimanteProvider>(
        context,
        listen: false,
      ).getAllImprimantes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ActionButton(
            onPressed: () {
              context.read<DrawerProvider>().openCreateImprimantDrawer();
              scaffoldKey.currentState?.openEndDrawer();
            },
            text: 'Nouveau',
          ),
        ],
      ),
      key: scaffoldKey,
      endDrawer: _endDrawer(),

      body: Consumer<ImprimanteProvider>(
        builder: (context, imprimantProvider, _) {
          return _buildTerminalStatusSection(imprimantProvider.peripherique);
        },
      ),
    );
  }

  final ipRegex = RegExp(
    r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$',
  );

  Widget _buildTerminalStatusSection(List<Peripherique> peripherique) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: peripherique.length,
          itemBuilder: (context, index) {
            final peripheriqueItem = peripherique[index];
            return _buildTerminalTile(peripheriqueItem);
          },
        ),
      ),
    );
  }

  Widget _buildTerminalTile(Peripherique peripherique) {
    return ListTile(
      leading: Icon(
        Icons.print,
        color:
            (peripherique.etat != null && peripherique.etat!)
                ? Colors.green
                : Colors.grey,
      ),
      title: Text(peripherique.model ?? ''),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(peripherique.nom ?? ''),
          Text(peripherique.typeConnection?.name ?? ''),
        ],
      ),
    );
  }

  Widget _endDrawer() {
    return Consumer2<DrawerProvider, ImprimanteProvider>(
      builder: (context, drawerProvider, imprimanteProvider, _) {
        final state = drawerProvider.state;
        if (state is DrawerCreateImprimant) {
          return Drawer(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Sauvgarder une imprimante',
                    style: AppTextStyle.indingoHeading,
                  ),
                  const SizedBox(height: 16),

                  // Dropdown for Type Connection
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade400),
                      color: Colors.grey[50],
                    ),
                    child: DropdownButtonFormField<TypeConnection>(
                      value: imprimanteProvider.selectedType,
                      decoration: const InputDecoration(
                        labelText: 'Type de selection',
                        border: InputBorder.none,
                      ),
                      items:
                          TypeConnection.values.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type.name.toUpperCase()),
                            );
                          }).toList(),
                      onChanged: (v) {
                        if (v != null) {
                          imprimanteProvider.selectType(v);
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // IP Address Field
                  if (imprimanteProvider.selectedType ==
                      TypeConnection.TCT_IP) ...[
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        return ipRegex.hasMatch(value ?? '')
                            ? null
                            : 'Invalid IP Address';
                      },
                      onChanged: (v) {
                        imprimanteProvider.updateIP(v);
                      },
                      decoration: InputDecoration(
                        labelText: 'Adresse IP',
                        labelStyle: AppTextStyle.indingosubHeading,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Port Field
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) {
                        final numberRegExp = RegExp(r'^\d+$');
                        if (!numberRegExp.hasMatch(v ?? '')) {
                          return 'Le port doit être un nombre';
                        } else if (int.tryParse(v ?? '') == null) {
                          return 'Numero de port invalide';
                        } else if (int.parse(v ?? '') < 1 ||
                            int.parse(v ?? '') > 65535) {
                          return 'il faut saisir un port entre 1 et 65535';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      onChanged: (v) {
                        imprimanteProvider.updatePort(v);
                      },
                      decoration: InputDecoration(
                        labelText: 'Port',
                        labelStyle: AppTextStyle.indingosubHeading,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Show Print and Save Buttons if IP and Port are Valid
                    if (ipRegex.hasMatch(imprimanteProvider.ip ?? '') &&
                        (imprimanteProvider.port.isNotEmpty &&
                            int.tryParse(imprimanteProvider.port) != null &&
                            int.parse(imprimanteProvider.port) > 0 &&
                            int.parse(imprimanteProvider.port) <= 65535)) ...[
                      TextField(
                        decoration: const InputDecoration(
                          labelText: "Nom de la machine",
                        ),
                        onChanged: imprimanteProvider.updateMachineName,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          // await imprimanteProvider.printTestReceipt();
                        },
                        child: const Text("Test Print"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Add logic for saving the printer
                        },
                        child: const Text("Enregistrer"),
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

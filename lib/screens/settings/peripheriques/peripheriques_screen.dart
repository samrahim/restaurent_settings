import 'package:flutter/material.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class PeripheriquesScreen extends StatefulWidget {
  const PeripheriquesScreen({super.key});

  @override
  State<PeripheriquesScreen> createState() => _PeripheriquesScreenState();
}

class _PeripheriquesScreenState extends State<PeripheriquesScreen> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  List<BluetoothDevice> devices = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getDevices();
  }

  Future<void> _getDevices() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<BluetoothDevice> devs = await bluetooth.getBondedDevices();
      setState(() {
        devices = devs;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        devices = [];
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la détection des périphériques : $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Périphériques')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Imprimantes Bluetooth détectées :',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : devices.isEmpty
                      ? const Center(child: Text('Aucune imprimante trouvée.'))
                      : ListView(
                        children:
                            devices.map((device) {
                              return Card(
                                child: ListTile(
                                  leading: const Icon(Icons.print),
                                  title: Text(device.name ?? 'Inconnu'),
                                  subtitle: Text(device.address ?? ''),
                                  trailing: ElevatedButton(
                                    onPressed: () {
                                      // Ici tu pourras ajouter la connexion ou l'impression
                                    },
                                    child: const Text('Connecter'),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getDevices,
        tooltip: 'Rafraîchir',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

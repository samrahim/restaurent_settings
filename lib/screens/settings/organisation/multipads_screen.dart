import 'package:flutter/material.dart';

class MultipadsScreen extends StatelessWidget {
  const MultipadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Multipads',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildDeviceGroup('Salle principale', [
                    _buildDeviceCard(
                      'Pad 1',
                      'Samsung Galaxy Tab S7',
                      true,
                      'Dernière synchro: 14:30',
                      '98%',
                    ),
                    _buildDeviceCard(
                      'Pad 2',
                      'Samsung Galaxy Tab S7',
                      true,
                      'Dernière synchro: 14:28',
                      '75%',
                    ),
                  ]),
                  _buildDeviceGroup('Terrasse', [
                    _buildDeviceCard(
                      'Pad 3',
                      'Samsung Galaxy Tab S7',
                      true,
                      'Dernière synchro: 14:25',
                      '45%',
                    ),
                    _buildDeviceCard(
                      'Pad 4',
                      'Samsung Galaxy Tab S7',
                      false,
                      'Hors ligne depuis 10:15',
                      '20%',
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new device
        },
        tooltip: 'Ajouter un multipad',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDeviceGroup(String title, List<Widget> devices) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ...devices,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDeviceCard(
    String name,
    String model,
    bool isOnline,
    String lastSync,
    String battery,
  ) {
    final batteryLevel = int.parse(battery.replaceAll('%', ''));
    final batteryColor =
        batteryLevel > 60
            ? Colors.green
            : batteryLevel > 20
            ? Colors.orange
            : Colors.red;

    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          ListTile(
            leading: Stack(
              children: [
                const Icon(Icons.tablet_android, size: 32),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: isOnline ? Colors.green : Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            title: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(model),
            trailing: PopupMenuButton(
              itemBuilder:
                  (context) => [
                    const PopupMenuItem(
                      value: 'sync',
                      child: Text('Synchroniser'),
                    ),
                    const PopupMenuItem(
                      value: 'reset',
                      child: Text('Réinitialiser'),
                    ),
                    const PopupMenuItem(
                      value: 'remove',
                      child: Text('Supprimer'),
                    ),
                  ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.sync, size: 20),
                    const SizedBox(width: 8),
                    Text(lastSync),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      batteryLevel > 90
                          ? Icons.battery_full
                          : batteryLevel > 60
                          ? Icons.battery_6_bar
                          : batteryLevel > 30
                          ? Icons.battery_4_bar
                          : Icons.battery_2_bar,
                      color: batteryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      battery,
                      style: TextStyle(
                        color: batteryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          OverflowBar(
            children: [
              TextButton.icon(
                onPressed: () {
                  // Configure device
                },
                icon: const Icon(Icons.settings),
                label: const Text('Configurer'),
              ),
              TextButton.icon(
                onPressed: () {
                  // Send message
                },
                icon: const Icon(Icons.message),
                label: const Text('Message'),
              ),
              TextButton.icon(
                onPressed: () {
                  // Lock device
                },
                icon: const Icon(Icons.lock),
                label: const Text('Verrouiller'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

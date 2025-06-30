import 'package:flutter/material.dart';

class ComptoirsScreen extends StatelessWidget {
  const ComptoirsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Comptoirs',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildCounterCard(
                    'Bar principal',
                    'Bar central avec service complet',
                    true,
                    Icons.local_bar,
                    ['Boissons', 'Cocktails', 'Snacks'],
                  ),
                  _buildCounterCard(
                    'Comptoir cuisine',
                    'Point de service des plats chauds',
                    true,
                    Icons.restaurant,
                    ['Plats chauds', 'Entrées', 'Desserts'],
                  ),
                  _buildCounterCard(
                    'Bar terrasse',
                    'Service extérieur (été uniquement)',
                    false,
                    Icons.deck,
                    ['Boissons fraîches', 'Glaces', 'Snacks légers'],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new counter
        },
        tooltip: 'Ajouter un comptoir',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCounterCard(
    String name,
    String description,
    bool isActive,
    IconData icon,
    List<String> services,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon, size: 32),
            title: Row(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isActive ? 'Actif' : 'Inactif',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(description),
            ),
            trailing: PopupMenuButton(
              itemBuilder:
                  (context) => [
                    const PopupMenuItem(value: 'edit', child: Text('Modifier')),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Supprimer'),
                    ),
                  ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Services proposés :',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                ...services.map(
                  (service) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle_outline, size: 20),
                        const SizedBox(width: 8),
                        Text(service),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          OverflowBar(
            children: [
              TextButton.icon(
                onPressed: () {
                  // Configure printer
                },
                icon: const Icon(Icons.print),
                label: const Text('Imprimante'),
              ),
              TextButton.icon(
                onPressed: () {
                  // Configure payment terminal
                },
                icon: const Icon(Icons.payment),
                label: const Text('Terminal'),
              ),
              TextButton.icon(
                onPressed: () {
                  // Configure display
                },
                icon: const Icon(Icons.display_settings),
                label: const Text('Affichage'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MenusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gestion des Menus',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildMenuCard('Menu du Jour', '25.90 €', [
                    'Entrée + Plat + Dessert',
                    'Du lundi au vendredi midi',
                    '3 choix par service',
                  ], true),
                  _buildMenuCard('Menu Découverte', '45.00 €', [
                    'Entrée + Plat + Fromage + Dessert',
                    'Tous les soirs',
                    'Accord mets et vins possible',
                  ], true),
                  _buildMenuCard('Menu Dégustation', '75.00 €', [
                    '6 services',
                    'Sur réservation uniquement',
                    'Menu surprise du chef',
                  ], false),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new menu
        },
        child: const Icon(Icons.add),
        tooltip: 'Ajouter un menu',
      ),
    );
  }

  Widget _buildMenuCard(
    String name,
    String price,
    List<String> details,
    bool isActive,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isActive ? 'Actif' : 'Inactif',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            subtitle: Text(
              price,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: PopupMenuButton(
              itemBuilder:
                  (context) => [
                    const PopupMenuItem(value: 'edit', child: Text('Modifier')),
                    const PopupMenuItem(
                      value: 'duplicate',
                      child: Text('Dupliquer'),
                    ),
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
              children:
                  details
                      .map(
                        (detail) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle_outline, size: 20),
                              const SizedBox(width: 8),
                              Text(detail),
                            ],
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
          ButtonBar(
            children: [
              TextButton.icon(
                onPressed: () {
                  // View menu items
                },
                icon: const Icon(Icons.restaurant_menu),
                label: const Text('Voir les plats'),
              ),
              TextButton.icon(
                onPressed: () {
                  // Edit menu items
                },
                icon: const Icon(Icons.edit),
                label: const Text('Modifier'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

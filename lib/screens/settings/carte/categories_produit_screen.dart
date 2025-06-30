import 'package:flutter/material.dart';

class CategoriesProduitScreen extends StatelessWidget {
  const CategoriesProduitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Catégories de Produit',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            _buildSearchField(),
            const SizedBox(height: 16),
            Expanded(
              child: ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  // Handle reordering
                },
                children: [
                  _buildCategoryCard(
                    'Entrées',
                    'Entrées et apéritifs',
                    Icons.tapas,
                    15,
                    key: const Key('entrees'),
                  ),
                  _buildCategoryCard(
                    'Plats principaux',
                    'Plats du menu principal',
                    Icons.restaurant_menu,
                    25,
                    key: const Key('plats'),
                  ),
                  _buildCategoryCard(
                    'Desserts',
                    'Desserts et pâtisseries',
                    Icons.cake,
                    12,
                    key: const Key('desserts'),
                  ),
                  _buildCategoryCard(
                    'Boissons',
                    'Boissons et cocktails',
                    Icons.local_bar,
                    30,
                    key: const Key('boissons'),
                  ),
                  _buildCategoryCard(
                    'Vins',
                    'Carte des vins',
                    Icons.wine_bar,
                    40,
                    key: const Key('vins'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new category
        },
        tooltip: 'Ajouter une catégorie',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Rechercher une catégorie...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildCategoryCard(
    String title,
    String description,
    IconData icon,
    int itemCount, {
    required Key key,
  }) {
    return Card(
      key: key,
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon, size: 32),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$itemCount produits',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.drag_handle),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton('Voir les produits', Icons.visibility, () {
                  // View products
                }),
                _buildActionButton('Modifier', Icons.edit, () {
                  // Edit category
                }),
                _buildActionButton('Supprimer', Icons.delete_outline, () {
                  // Delete category
                }, color: Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    VoidCallback onPressed, {
    Color color = Colors.blue,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color, size: 20),
      label: Text(label, style: TextStyle(color: color)),
    );
  }
}

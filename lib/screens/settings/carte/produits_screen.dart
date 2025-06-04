import 'package:flutter/material.dart';

class ProduitsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Produits', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildProductCard(
                    'Plats principaux',
                    'Gestion des plats du menu principal',
                    Icons.restaurant_menu,
                  ),
                  _buildProductCard(
                    'Boissons',
                    'Gestion des boissons et cocktails',
                    Icons.local_drink,
                  ),
                  _buildProductCard(
                    'Desserts',
                    'Gestion des desserts et pâtisseries',
                    Icons.cake,
                  ),
                  _buildProductCard(
                    'Entrées',
                    'Gestion des entrées et apéritifs',
                    Icons.tapas,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        tooltip: 'Ajouter un produit',
      ),
    );
  }

  Widget _buildProductCard(String title, String subtitle, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: PopupMenuButton(
          itemBuilder:
              (context) => [
                const PopupMenuItem(value: 'edit', child: Text('Modifier')),
                const PopupMenuItem(value: 'delete', child: Text('Supprimer')),
              ],
        ),
      ),
    );
  }
}

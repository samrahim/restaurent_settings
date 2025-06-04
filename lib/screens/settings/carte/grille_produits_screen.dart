import 'package:flutter/material.dart';

class GrilleProduitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Grille des Produits'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Plats'),
              Tab(text: 'Boissons'),
              Tab(text: 'Desserts'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildProductGrid('Plats'),
            _buildProductGrid('Boissons'),
            _buildProductGrid('Desserts'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add new product
          },
          child: const Icon(Icons.add),
          tooltip: 'Ajouter un produit',
        ),
      ),
    );
  }

  Widget _buildProductGrid(String category) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildSearchAndFilter(),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 10, // Example count
              itemBuilder: (context, index) {
                return _buildProductCard(
                  'Produit ${index + 1}',
                  '${(index + 1) * 10}.90 €',
                  'Description du produit ${index + 1}',
                  'assets/images/product_${index + 1}.jpg',
                  category == 'Plats'
                      ? Icons.restaurant
                      : category == 'Boissons'
                      ? Icons.local_bar
                      : Icons.cake,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Rechercher un produit...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        PopupMenuButton(
          icon: const Icon(Icons.filter_list),
          itemBuilder:
              (context) => [
                const PopupMenuItem(
                  value: 'price_asc',
                  child: Text('Prix croissant'),
                ),
                const PopupMenuItem(
                  value: 'price_desc',
                  child: Text('Prix décroissant'),
                ),
                const PopupMenuItem(value: 'name_asc', child: Text('Nom A-Z')),
                const PopupMenuItem(value: 'name_desc', child: Text('Nom Z-A')),
              ],
        ),
      ],
    );
  }

  Widget _buildProductCard(
    String name,
    String price,
    String description,
    String imagePath,
    IconData icon,
  ) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                color: Colors.grey[200],
                child: Center(
                  child: Icon(icon, size: 48, color: Colors.grey[400]),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    price,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Spacer(),
          ButtonBar(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: () {
                  // Edit product
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20),
                onPressed: () {
                  // Delete product
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

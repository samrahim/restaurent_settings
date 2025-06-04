import 'package:flutter/material.dart';

class GestionStocksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gestion des Stocks',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            _buildSearchAndFilter(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildInventorySection(),
                  const SizedBox(height: 16),
                  _buildAlertSection(),
                  const SizedBox(height: 16),
                  _buildOrderSection(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new inventory item
        },
        child: const Icon(Icons.add),
        tooltip: 'Ajouter un produit',
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
        DropdownButton<String>(
          value: 'all',
          items: [
            DropdownMenuItem(value: 'all', child: Text('Toutes catégories')),
            DropdownMenuItem(value: 'fresh', child: Text('Produits frais')),
            DropdownMenuItem(value: 'frozen', child: Text('Surgelés')),
            DropdownMenuItem(value: 'dry', child: Text('Épicerie')),
          ],
          onChanged: (String? value) {
            // Handle category filter
          },
        ),
      ],
    );
  }

  Widget _buildInventorySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Inventaire actuel',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildInventoryItem(
                  name: 'Produit ${index + 1}',
                  category: index % 2 == 0 ? 'Produits frais' : 'Épicerie',
                  quantity: (10 - index).toString(),
                  unit: index % 2 == 0 ? 'kg' : 'unités',
                  minStock: '5',
                  expiryDate:
                      '2024-${(index + 4).toString().padLeft(2, '0')}-01',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Alertes stock',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildAlertItem('Tomates', 'Stock bas', 2, 5, Colors.orange),
            _buildAlertItem('Farine', 'Rupture de stock', 0, 10, Colors.red),
            _buildAlertItem('Œufs', 'Proche péremption', 15, 20, Colors.amber),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Commandes en cours',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: () {
                    // Create new order
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Nouvelle commande'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildOrderItem(
              'CMD-001',
              'Fournisseur A',
              '2024-03-15',
              'En attente',
            ),
            _buildOrderItem(
              'CMD-002',
              'Fournisseur B',
              '2024-03-16',
              'Validée',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInventoryItem({
    required String name,
    required String category,
    required String quantity,
    required String unit,
    required String minStock,
    required String expiryDate,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        title: Text(name),
        subtitle: Text(category),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$quantity $unit',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Min: $minStock $unit',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            const SizedBox(width: 16),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Edit inventory item
              },
            ),
          ],
        ),
        onTap: () {
          // View details
        },
      ),
    );
  }

  Widget _buildAlertItem(
    String name,
    String alert,
    int current,
    int required,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Icon(Icons.warning, color: color),
        title: Text(name),
        subtitle: Text(alert),
        trailing: TextButton(
          onPressed: () {
            // Handle alert action
          },
          child: const Text('Commander'),
        ),
      ),
    );
  }

  Widget _buildOrderItem(
    String orderNumber,
    String supplier,
    String deliveryDate,
    String status,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        title: Text(orderNumber),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(supplier), Text('Livraison prévue: $deliveryDate')],
        ),
        trailing: Chip(
          label: Text(status),
          backgroundColor:
              status == 'Validée' ? Colors.green[100] : Colors.grey[100],
        ),
        onTap: () {
          // View order details
        },
      ),
    );
  }
}

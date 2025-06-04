import 'package:flutter/material.dart';

class SuiviCommandesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Suivi des Commandes',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            _buildFilterBar(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildActiveOrdersSection(),
                  const SizedBox(height: 16),
                  _buildCompletedOrdersSection(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Refresh orders
        },
        child: const Icon(Icons.refresh),
        tooltip: 'Rafraîchir les commandes',
      ),
    );
  }

  Widget _buildFilterBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Rechercher une commande...',
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
            DropdownMenuItem(value: 'all', child: Text('Tous')),
            DropdownMenuItem(value: 'pending', child: Text('En attente')),
            DropdownMenuItem(value: 'preparing', child: Text('En préparation')),
            DropdownMenuItem(value: 'ready', child: Text('Prêt')),
          ],
          onChanged: (String? value) {
            // Handle filter change
          },
        ),
      ],
    );
  }

  Widget _buildActiveOrdersSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Commandes actives',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildOrderCard(
                  orderNumber: 'CMD-${1001 + index}',
                  table: 'Table ${index + 1}',
                  items: ['Plat 1', 'Plat 2', 'Dessert'],
                  status: index == 0 ? 'En attente' : 'En préparation',
                  time: '${15 + index} min',
                  isUrgent: index == 0,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedOrdersSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Commandes terminées',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return _buildOrderCard(
                  orderNumber: 'CMD-${999 - index}',
                  table: 'Table ${index + 4}',
                  items: ['Plat 3', 'Plat 4'],
                  status: 'Terminé',
                  time: '${index + 1} min',
                  isUrgent: false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard({
    required String orderNumber,
    required String table,
    required List<String> items,
    required String status,
    required String time,
    required bool isUrgent,
  }) {
    Color statusColor;
    switch (status) {
      case 'En attente':
        statusColor = Colors.orange;
        break;
      case 'En préparation':
        statusColor = Colors.blue;
        break;
      case 'Terminé':
        statusColor = Colors.green;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Text(
                  orderNumber,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                if (isUrgent)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'URGENT',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
              ],
            ),
            subtitle: Text(table),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: statusColor),
              ),
              child: Text(status, style: TextStyle(color: statusColor)),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ...items.map(
                  (item) => ListTile(
                    dense: true,
                    leading: const Icon(Icons.restaurant_menu),
                    title: Text(item),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Temps écoulé: $time'),
                    if (status != 'Terminé')
                      TextButton.icon(
                        onPressed: () {
                          // Mark as ready
                        },
                        icon: const Icon(Icons.check_circle),
                        label: const Text('Marquer comme prêt'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

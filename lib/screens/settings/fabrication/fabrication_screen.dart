import 'package:flutter/material.dart';

class FabricationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fabrication',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildSection('Points de fabrication actifs', [
                      _buildKitchenCard(
                        'Cuisine principale',
                        'En service',
                        4,
                        12,
                      ),
                      _buildKitchenCard('Bar', 'En service', 2, 5),
                      _buildKitchenCard('Pâtisserie', 'Hors service', 0, 0),
                    ]),
                    const SizedBox(height: 16),
                    _buildSection('Statistiques de production', [
                      _buildStatCard(
                        'Temps moyen de préparation',
                        '12 min',
                        Icons.timer,
                      ),
                      _buildStatCard(
                        'Commandes en attente',
                        '8',
                        Icons.pending_actions,
                      ),
                      _buildStatCard(
                        'Commandes complétées aujourd\'hui',
                        '45',
                        Icons.done_all,
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        tooltip: 'Ajouter un point de fabrication',
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildKitchenCard(
    String name,
    String status,
    int pendingOrders,
    int completedOrders,
  ) {
    final isActive = status == 'En service';
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Icon(
          Icons.restaurant,
          color: isActive ? Colors.green : Colors.red,
          size: 32,
        ),
        title: Text(name),
        subtitle: Text(status),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('En attente: $pendingOrders'),
            Text('Complétées: $completedOrders'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

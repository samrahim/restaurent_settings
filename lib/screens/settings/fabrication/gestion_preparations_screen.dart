import 'package:flutter/material.dart';

class GestionPreparationsScreen extends StatelessWidget {
  const GestionPreparationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gestion des Préparations',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildPreparationSection(),
                  const SizedBox(height: 16),
                  _buildTimingSection(),
                  const SizedBox(height: 16),
                  _buildStockSection(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Save configuration
        },
        tooltip: 'Enregistrer les modifications',
        child: const Icon(Icons.save),
      ),
    );
  }

  Widget _buildPreparationSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fiches de préparation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildPreparationCard(
                  'Préparation ${index + 1}',
                  'Description de la préparation ${index + 1}',
                  '30 min',
                  4,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimingSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Timing de production',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildTimingSlot('Matin', '6:00 - 10:00', [
              'Mise en place petit-déjeuner',
              'Préparation des viennoiseries',
            ]),
            _buildTimingSlot('Midi', '10:00 - 14:00', [
              'Mise en place déjeuner',
              'Préparation des entrées',
            ]),
            _buildTimingSlot('Soir', '16:00 - 22:00', [
              'Mise en place dîner',
              'Préparation des desserts',
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildStockSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'État des stocks préparations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildStockItem('Sauces', 80, 100),
            _buildStockItem('Garnitures', 60, 100),
            _buildStockItem('Desserts', 40, 50),
          ],
        ),
      ),
    );
  }

  Widget _buildPreparationCard(
    String title,
    String description,
    String duration,
    int portions,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const Icon(Icons.timer, size: 16), Text(duration)],
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.restaurant, size: 16),
                Text('$portions p'),
              ],
            ),
          ],
        ),
        onTap: () {
          // Open preparation details
        },
      ),
    );
  }

  Widget _buildTimingSlot(String title, String hours, List<String> tasks) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ExpansionTile(
        title: Text(title),
        subtitle: Text(hours),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children:
                  tasks
                      .map(
                        (task) => ListTile(
                          leading: const Icon(Icons.check_circle_outline),
                          title: Text(task),
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockItem(String name, int current, int total) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: current / total,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              current / total > 0.25 ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(height: 4),
          Text('$current / $total unités'),
        ],
      ),
    );
  }
}

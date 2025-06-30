import 'package:flutter/material.dart';

class PlanningProductionScreen extends StatelessWidget {
  const PlanningProductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Planning de Production',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            _buildDateSelector(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildMorningSection(),
                  const SizedBox(height: 16),
                  _buildAfternoonSection(),
                  const SizedBox(height: 16),
                  _buildEveningSection(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new task
        },
        tooltip: 'Ajouter une tâche',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            // Previous day
          },
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: () {
              // Select date
            },
            icon: const Icon(Icons.calendar_today),
            label: const Text('Lundi 15 Mars 2024'),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () {
            // Next day
          },
        ),
      ],
    );
  }

  Widget _buildMorningSection() {
    return _buildTimeSection('Matin (6:00 - 11:00)', [
      _buildTaskCard(
        'Mise en place petit-déjeuner',
        '6:00 - 7:30',
        'En cours',
        'Chef John',
        ['Viennoiseries', 'Fruits frais', 'Œufs'],
      ),
      _buildTaskCard(
        'Préparation des entrées',
        '8:00 - 10:00',
        'À faire',
        'Sous-chef Marie',
        ['Salades', 'Soupes', 'Terrines'],
      ),
    ]);
  }

  Widget _buildAfternoonSection() {
    return _buildTimeSection('Après-midi (11:00 - 17:00)', [
      _buildTaskCard(
        'Mise en place déjeuner',
        '11:00 - 13:00',
        'À faire',
        'Chef Paul',
        ['Plats chauds', 'Garnitures', 'Sauces'],
      ),
      _buildTaskCard(
        'Préparation du soir',
        '14:00 - 16:00',
        'À faire',
        'Chef Sarah',
        ['Marinades', 'Cuissons lentes', 'Pâtisseries'],
      ),
    ]);
  }

  Widget _buildEveningSection() {
    return _buildTimeSection('Soir (17:00 - 23:00)', [
      _buildTaskCard(
        'Service du soir',
        '18:00 - 22:00',
        'À faire',
        'Chef Marc',
        ['Plats à la carte', 'Desserts', 'Finitions'],
      ),
      _buildTaskCard(
        'Nettoyage et mise en place',
        '22:00 - 23:00',
        'À faire',
        'Équipe du soir',
        ['Rangement', 'Inventaire', 'Préparation lendemain'],
      ),
    ]);
  }

  Widget _buildTimeSection(String title, List<Widget> tasks) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    // Add task to this time section
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Ajouter'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...tasks,
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(
    String title,
    String time,
    String status,
    String assignedTo,
    List<String> items,
  ) {
    Color statusColor;
    switch (status) {
      case 'En cours':
        statusColor = Colors.blue;
        break;
      case 'Terminé':
        statusColor = Colors.green;
        break;
      case 'En retard':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          ListTile(
            title: Text(title),
            subtitle: Text(time),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person, size: 16),
                    const SizedBox(width: 8),
                    Text(assignedTo),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tâches :',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                ...items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle_outline, size: 16),
                        const SizedBox(width: 8),
                        Text(item),
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
                  // Edit task
                },
                icon: const Icon(Icons.edit),
                label: const Text('Modifier'),
              ),
              TextButton.icon(
                onPressed: () {
                  // Mark as complete
                },
                icon: const Icon(Icons.check_circle),
                label: const Text('Terminer'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

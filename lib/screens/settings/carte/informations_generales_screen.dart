import 'package:flutter/material.dart';

class InformationsGeneralesScreen extends StatelessWidget {
  const InformationsGeneralesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informations Générales',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildInfoCard('Informations du restaurant', [
                      _buildTextField('Nom du restaurant', 'Le Gourmet'),
                      _buildTextField('Type de cuisine', 'Française'),
                      _buildTextField('Capacité', '120 couverts'),
                    ]),
                    const SizedBox(height: 16),
                    _buildInfoCard('Horaires d\'ouverture', [
                      _buildTimeRow(
                        'Lundi - Vendredi',
                        '11:30 - 14:30',
                        '19:00 - 23:00',
                      ),
                      _buildTimeRow('Samedi', '11:30 - 15:00', '19:00 - 23:30'),
                      _buildTimeRow('Dimanche', '11:30 - 15:00', 'Fermé'),
                    ]),
                    const SizedBox(height: 16),
                    _buildInfoCard('Paramètres de la carte', [
                      _buildSwitchTile(
                        'Afficher les allergènes',
                        'Indiquer les allergènes sur la carte',
                        true,
                      ),
                      _buildSwitchTile(
                        'Prix TTC',
                        'Afficher les prix TTC',
                        true,
                      ),
                      _buildSwitchTile(
                        'Plats du jour',
                        'Activer la section plats du jour',
                        true,
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
        onPressed: () {
          // Save changes
        },
        tooltip: 'Enregistrer les modifications',
        child: const Icon(Icons.save),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
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

  Widget _buildTextField(String label, String initialValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildTimeRow(String day, String lunch, String dinner) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              day,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(flex: 1, child: Text(lunch, textAlign: TextAlign.center)),
          Expanded(flex: 1, child: Text(dinner, textAlign: TextAlign.center)),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool initialValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: initialValue,
      onChanged: (bool value) {
        // Handle switch change
      },
    );
  }
}

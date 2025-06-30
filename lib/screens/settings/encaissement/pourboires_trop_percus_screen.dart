import 'package:flutter/material.dart';

class PourboiresTropPercusScreen extends StatelessWidget {
  const PourboiresTropPercusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pourboires et trop-perçus',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildTipsSection(),
                  const SizedBox(height: 16),
                  _buildOverpaymentSection(),
                  const SizedBox(height: 16),
                  _buildDistributionSection(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Save settings
        },
        tooltip: 'Enregistrer les modifications',
        child: const Icon(Icons.save),
      ),
    );
  }

  Widget _buildTipsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gestion des pourboires',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSwitchSetting(
              'Pourboires par carte',
              'Autoriser les pourboires par carte bancaire',
              true,
            ),
            _buildSwitchSetting(
              'Suggestion de pourboire',
              'Afficher des suggestions de montant',
              true,
            ),
            _buildPercentageField('Suggestion 1', '5'),
            _buildPercentageField('Suggestion 2', '10'),
            _buildPercentageField('Suggestion 3', '15'),
            _buildSwitchSetting(
              'Montant personnalisé',
              'Permettre la saisie d\'un montant personnalisé',
              true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverpaymentSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gestion des trop-perçus',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDropdownSetting(
              'Traitement par défaut',
              'Rendre la monnaie',
              [
                'Rendre la monnaie',
                'Convertir en pourboire',
                'Demander au client',
              ],
            ),
            _buildTextField('Seuil de tolérance', '0.10', Icons.euro),
            _buildSwitchSetting(
              'Arrondi automatique',
              'Arrondir automatiquement les montants',
              true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDistributionSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Distribution des pourboires',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDropdownSetting('Mode de distribution', 'Équitable', [
              'Équitable',
              'Par service',
              'Personnalisé',
            ]),
            _buildStaffShare('Serveurs', '40'),
            _buildStaffShare('Cuisine', '30'),
            _buildStaffShare('Bar', '20'),
            _buildStaffShare('Autres', '10'),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                // Configure distribution rules
              },
              icon: const Icon(Icons.rule),
              label: const Text('Configurer les règles de distribution'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPercentageField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          SizedBox(
            width: 100,
            child: TextFormField(
              initialValue: value,
              decoration: const InputDecoration(
                suffixText: '%',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffShare(String role, String percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: Text(role)),
          SizedBox(
            width: 100,
            child: TextFormField(
              initialValue: percentage,
              decoration: const InputDecoration(
                suffixText: '%',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchSetting(String title, String subtitle, bool value) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (bool newValue) {
        // Handle switch change
      },
    );
  }

  Widget _buildDropdownSetting(String title, String value, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: value,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            items:
                items
                    .map(
                      (item) =>
                          DropdownMenuItem(value: item, child: Text(item)),
                    )
                    .toList(),
            onChanged: (String? newValue) {
              // Handle dropdown change
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

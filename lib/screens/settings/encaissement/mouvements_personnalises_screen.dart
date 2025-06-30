import 'package:flutter/material.dart';

class MouvementsPersonnalisesScreen extends StatelessWidget {
  const MouvementsPersonnalisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mouvements personnalisés',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildCustomMovementsSection(),
                  const SizedBox(height: 16),
                  _buildCategoriesSection(),
                  const SizedBox(height: 16),
                  _buildPermissionsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new custom movement
        },
        tooltip: 'Ajouter un mouvement',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCustomMovementsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mouvements configurés',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildMovementCard(
              'Fond de caisse',
              'Entrée',
              'Ajout du fond de caisse',
              Icons.arrow_downward,
              Colors.green,
              true,
            ),
            _buildMovementCard(
              'Retrait espèces',
              'Sortie',
              'Retrait pour dépôt bancaire',
              Icons.arrow_upward,
              Colors.red,
              true,
            ),
            _buildMovementCard(
              'Achat fournitures',
              'Sortie',
              'Achat de fournitures diverses',
              Icons.arrow_upward,
              Colors.red,
              true,
            ),
            _buildMovementCard(
              'Remboursement client',
              'Sortie',
              'Remboursement exceptionnel',
              Icons.arrow_upward,
              Colors.red,
              true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Catégories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildCategoryCard('Opérations courantes', [
              'Fond de caisse',
              'Retrait espèces',
            ], true),
            _buildCategoryCard('Achats', [
              'Fournitures',
              'Matériel',
              'Services',
            ], true),
            _buildCategoryCard('Remboursements', [
              'Client',
              'Fournisseur',
            ], true),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                // Add new category
              },
              icon: const Icon(Icons.add),
              label: const Text('Ajouter une catégorie'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Autorisations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSwitchSetting(
              'Validation manager',
              'Demander validation pour les mouvements > 100€',
              true,
            ),
            _buildSwitchSetting(
              'Justificatif obligatoire',
              'Exiger un justificatif pour les sorties de caisse',
              true,
            ),
            _buildTextField(
              'Montant maximum sans validation',
              '100',
              Icons.euro,
            ),
            _buildDropdownSetting('Niveau d\'autorisation requis', 'Manager', [
              'Employé',
              'Superviseur',
              'Manager',
              'Administrateur',
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildMovementCard(
    String title,
    String type,
    String description,
    IconData icon,
    Color color,
    bool isActive,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Row(
          children: [
            Text(title),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(type, style: TextStyle(color: color, fontSize: 12)),
            ),
          ],
        ),
        subtitle: Text(description),
        trailing: Switch(
          value: isActive,
          onChanged: (bool value) {
            // Toggle movement
          },
        ),
        onTap: () {
          // Edit movement
        },
      ),
    );
  }

  Widget _buildCategoryCard(String title, List<String> items, bool isActive) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          ListTile(
            title: Text(title),
            trailing: Switch(
              value: isActive,
              onChanged: (bool value) {
                // Toggle category
              },
            ),
          ),
          if (isActive)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children:
                    items
                        .map(
                          (item) => ListTile(
                            dense: true,
                            leading: const Icon(Icons.label),
                            title: Text(item),
                          ),
                        )
                        .toList(),
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

import 'package:flutter/material.dart';

class RemisesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Remises', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildDiscountTypesSection(),
                  const SizedBox(height: 16),
                  _buildAutomaticDiscountsSection(),
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
          // Add new discount
        },
        child: const Icon(Icons.add),
        tooltip: 'Ajouter une remise',
      ),
    );
  }

  Widget _buildDiscountTypesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Types de remises',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDiscountCard(
              'Remise pourcentage',
              'Réduction en pourcentage sur le total',
              Icons.percent,
              true,
            ),
            _buildDiscountCard(
              'Remise montant fixe',
              'Réduction d\'un montant fixe',
              Icons.euro,
              true,
            ),
            _buildDiscountCard(
              'Remise article offert',
              'Article gratuit sur conditions',
              Icons.card_giftcard,
              true,
            ),
            _buildDiscountCard(
              'Remise fidélité',
              'Réduction pour clients fidèles',
              Icons.loyalty,
              false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAutomaticDiscountsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Remises automatiques',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildAutomaticDiscountCard(
              'Happy Hour',
              '17:00 - 19:00',
              '-20% sur les boissons',
              true,
            ),
            _buildAutomaticDiscountCard(
              'Menu du jour',
              '12:00 - 14:00',
              'Dessert offert',
              true,
            ),
            _buildAutomaticDiscountCard(
              'Étudiant',
              'Sur présentation carte',
              '-15% sur l\'addition',
              true,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                // Configure automatic discounts
              },
              icon: const Icon(Icons.schedule),
              label: const Text('Configurer les horaires'),
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
              'Demander validation pour les remises > 20%',
              true,
            ),
            _buildSwitchSetting(
              'Cumul des remises',
              'Autoriser le cumul des remises',
              false,
            ),
            _buildTextField('Remise maximum', '50', Icons.percent),
            _buildDropdownSetting('Application remise', 'Avant TVA', [
              'Avant TVA',
              'Après TVA',
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscountCard(
    String title,
    String subtitle,
    IconData icon,
    bool isActive,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Switch(
          value: isActive,
          onChanged: (bool value) {
            // Toggle discount type
          },
        ),
        onTap: () {
          // Configure discount type
        },
      ),
    );
  }

  Widget _buildAutomaticDiscountCard(
    String title,
    String period,
    String description,
    bool isActive,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(period), Text(description)],
        ),
        trailing: Switch(
          value: isActive,
          onChanged: (bool value) {
            // Toggle automatic discount
          },
        ),
        onTap: () {
          // Configure automatic discount
        },
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

import 'package:flutter/material.dart';

class TauxTVAScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Taux de TVA',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildVATRatesSection(),
                  const SizedBox(height: 16),
                  _buildDefaultRatesSection(),
                  const SizedBox(height: 16),
                  _buildDisplaySection(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new VAT rate
        },
        child: const Icon(Icons.add),
        tooltip: 'Ajouter un taux de TVA',
      ),
    );
  }

  Widget _buildVATRatesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Taux configurés',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildVATRateCard(
              'TVA standard',
              20.0,
              'Taux standard pour la plupart des produits',
              true,
            ),
            _buildVATRateCard(
              'TVA réduite',
              10.0,
              'Taux réduit pour certains produits alimentaires',
              true,
            ),
            _buildVATRateCard(
              'TVA super réduite',
              5.5,
              'Taux super réduit pour produits de première nécessité',
              true,
            ),
            _buildVATRateCard(
              'Exonéré',
              0.0,
              'Produits exonérés de TVA',
              false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultRatesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Taux par défaut',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDropdownSetting('Sur place', 'TVA standard (20.0%)', [
              'TVA standard (20.0%)',
              'TVA réduite (10.0%)',
              'TVA super réduite (5.5%)',
            ]),
            _buildDropdownSetting('À emporter', 'TVA réduite (10.0%)', [
              'TVA standard (20.0%)',
              'TVA réduite (10.0%)',
              'TVA super réduite (5.5%)',
            ]),
            _buildDropdownSetting('Livraison', 'TVA réduite (10.0%)', [
              'TVA standard (20.0%)',
              'TVA réduite (10.0%)',
              'TVA super réduite (5.5%)',
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplaySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Affichage',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSwitchSetting(
              'Prix TTC',
              'Afficher les prix TTC par défaut',
              true,
            ),
            _buildSwitchSetting(
              'Détail TVA',
              'Afficher le détail de la TVA sur les tickets',
              true,
            ),
            _buildSwitchSetting(
              'Base HT',
              'Afficher la base HT sur les tickets',
              true,
            ),
            _buildSwitchSetting(
              'Montant TVA',
              'Afficher le montant de la TVA sur les tickets',
              true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVATRateCard(
    String name,
    double rate,
    String description,
    bool isActive,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        title: Row(
          children: [
            Text(name),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${rate.toStringAsFixed(1)}%',
                style: TextStyle(color: Colors.blue[900]),
              ),
            ),
          ],
        ),
        subtitle: Text(description),
        trailing: Switch(
          value: isActive,
          onChanged: (bool value) {
            // Toggle VAT rate
          },
        ),
        onTap: () {
          // Edit VAT rate
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
}

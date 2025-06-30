import 'package:flutter/material.dart';

class ConfigurationCommandeScreen extends StatelessWidget {
  const ConfigurationCommandeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Configuration des commandes',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildSettingsCard('Comportement général', [
                    _buildSwitchSetting(
                      'Confirmation de commande',
                      'Demander confirmation avant envoi',
                      true,
                    ),
                    _buildSwitchSetting(
                      'Mode rapide',
                      'Envoi automatique après sélection',
                      false,
                    ),
                    _buildSwitchSetting(
                      'Notes obligatoires',
                      'Exiger des notes pour certains produits',
                      true,
                    ),
                  ]),
                  _buildSettingsCard('Affichage', [
                    _buildDropdownSetting('Vue par défaut', 'Grille', [
                      'Liste',
                      'Grille',
                      'Compact',
                    ]),
                    _buildDropdownSetting('Tri des produits', 'Alphabétique', [
                      'Alphabétique',
                      'Catégorie',
                      'Popularité',
                    ]),
                    _buildSwitchSetting(
                      'Images des produits',
                      'Afficher les images dans la liste',
                      true,
                    ),
                  ]),
                  _buildSettingsCard('Impression', [
                    _buildSwitchSetting(
                      'Impression automatique',
                      'Imprimer après validation',
                      true,
                    ),
                    _buildDropdownSetting('Format du ticket', 'Standard', [
                      'Compact',
                      'Standard',
                      'Détaillé',
                    ]),
                    _buildSwitchSetting(
                      'Double impression',
                      'Imprimer une copie pour la cuisine',
                      true,
                    ),
                  ]),
                  _buildSettingsCard('Notifications', [
                    _buildSwitchSetting(
                      'Sons',
                      'Jouer un son à la validation',
                      true,
                    ),
                    _buildSwitchSetting(
                      'Vibrations',
                      'Vibrer à la validation',
                      false,
                    ),
                    _buildSwitchSetting(
                      'Alertes cuisine',
                      'Notifier quand la commande est prête',
                      true,
                    ),
                  ]),
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

  Widget _buildSettingsCard(String title, List<Widget> settings) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
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
            ...settings,
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchSetting(String title, String subtitle, bool value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: (bool newValue) {
          // Handle switch change
        },
      ),
    );
  }

  Widget _buildDropdownSetting(String title, String value, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
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

import 'package:flutter/material.dart';

class MesPreferencesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mes Préférences',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildInterfaceSection(),
                  const SizedBox(height: 16),
                  _buildNotificationsSection(),
                  const SizedBox(height: 16),
                  _buildWorkflowSection(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Save preferences
        },
        child: const Icon(Icons.save),
        tooltip: 'Enregistrer les préférences',
      ),
    );
  }

  Widget _buildInterfaceSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interface',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDropdownSetting('Thème', 'Clair', [
              'Clair',
              'Sombre',
              'Système',
            ]),
            _buildDropdownSetting('Taille du texte', 'Normal', [
              'Petit',
              'Normal',
              'Grand',
              'Très grand',
            ]),
            _buildDropdownSetting('Langue', 'Français', [
              'Français',
              'English',
              'Español',
              'Deutsch',
            ]),
            _buildSwitchSetting(
              'Mode compact',
              'Afficher plus d\'informations à l\'écran',
              false,
            ),
            _buildSwitchSetting(
              'Animations',
              'Activer les animations de l\'interface',
              true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notifications',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSwitchSetting(
              'Sons',
              'Activer les sons de notification',
              true,
            ),
            _buildSwitchSetting('Vibrations', 'Activer les vibrations', true),
            _buildSwitchSetting(
              'Notifications commandes',
              'Recevoir les notifications de nouvelles commandes',
              true,
            ),
            _buildSwitchSetting(
              'Notifications messages',
              'Recevoir les notifications de messages',
              true,
            ),
            _buildDropdownSetting('Mode silencieux', 'Jamais', [
              'Jamais',
              'Pendant le service',
              'Horaires personnalisés',
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkflowSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Flux de travail',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDropdownSetting('Vue par défaut', 'Tables', [
              'Tables',
              'Commandes',
              'Cuisine',
            ]),
            _buildSwitchSetting(
              'Confirmation de commande',
              'Demander confirmation avant envoi',
              true,
            ),
            _buildSwitchSetting(
              'Mode rapide',
              'Activer le mode de saisie rapide',
              false,
            ),
            _buildSwitchSetting(
              'Impression automatique',
              'Imprimer automatiquement les commandes',
              true,
            ),
            _buildDropdownSetting('Tri des commandes', 'Chronologique', [
              'Chronologique',
              'Par table',
              'Par statut',
              'Par serveur',
            ]),
          ],
        ),
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

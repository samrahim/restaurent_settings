import 'package:flutter/material.dart';

class VerrouillageScreen extends StatelessWidget {
  const VerrouillageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verrouillage',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildLockSettingsSection(),
                  const SizedBox(height: 16),
                  _buildAutoLockSection(),
                  const SizedBox(height: 16),
                  _buildSecuritySection(),
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

  Widget _buildLockSettingsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Paramètres de verrouillage',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSwitchSetting(
              'Verrouillage par code PIN',
              'Utiliser un code PIN pour déverrouiller',
              true,
            ),
            _buildSwitchSetting(
              'Verrouillage biométrique',
              'Utiliser l\'empreinte digitale',
              false,
            ),
            _buildSwitchSetting(
              'Verrouillage automatique à la fermeture',
              'Verrouiller lors de la fermeture de l\'application',
              true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAutoLockSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verrouillage automatique',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDropdownSetting('Délai de verrouillage', '5 minutes', [
              'Immédiatement',
              '1 minute',
              '5 minutes',
              '15 minutes',
              '30 minutes',
              '1 heure',
            ]),
            _buildSwitchSetting(
              'Verrouillage en pause',
              'Verrouiller pendant les pauses',
              true,
            ),
            _buildSwitchSetting(
              'Verrouillage en fin de service',
              'Verrouiller automatiquement en fin de service',
              true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecuritySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sécurité',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.lock_reset),
              title: const Text('Changer le code PIN'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Change PIN
              },
            ),
            ListTile(
              leading: const Icon(Icons.fingerprint),
              title: const Text('Configurer la biométrie'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Configure biometrics
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Historique des connexions'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // View login history
              },
            ),
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

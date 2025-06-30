import 'package:flutter/material.dart';

class ConfigurationReservationsScreen extends StatelessWidget {
  const ConfigurationReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Configuration des réservations',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildGeneralSection(),
                  const SizedBox(height: 16),
                  _buildCapacitySection(),
                  const SizedBox(height: 16),
                  _buildOnlineSection(),
                  const SizedBox(height: 16),
                  _buildNotificationsSection(),
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

  Widget _buildGeneralSection() {
    return _buildSettingsCard('Paramètres généraux', [
      _buildDropdownSetting('Durée par défaut', '2 heures', [
        '1 heure',
        '1.5 heures',
        '2 heures',
        '2.5 heures',
        '3 heures',
      ]),
      _buildDropdownSetting('Intervalle de réservation', '15 minutes', [
        '15 minutes',
        '30 minutes',
        '1 heure',
      ]),
      _buildSwitchSetting(
        'Réservations simultanées',
        'Autoriser plusieurs réservations au même horaire',
        true,
      ),
      _buildSwitchSetting(
        'Liste d\'attente',
        'Activer la liste d\'attente',
        true,
      ),
      _buildTimeRangeSetting(
        'Horaires de réservation',
        TimeOfDay(hour: 11, minute: 30),
        TimeOfDay(hour: 22, minute: 0),
      ),
    ]);
  }

  Widget _buildCapacitySection() {
    return _buildSettingsCard('Gestion de la capacité', [
      _buildCapacityTile('Déjeuner', '11:30 - 14:30', 80, 120),
      _buildCapacityTile('Dîner', '19:00 - 22:00', 100, 120),
      const SizedBox(height: 16),
      _buildSwitchSetting(
        'Limite automatique',
        'Ajuster automatiquement selon le personnel',
        true,
      ),
      _buildSwitchSetting('Surbooking', 'Autoriser le surbooking', false),
    ]);
  }

  Widget _buildOnlineSection() {
    return _buildSettingsCard('Réservations en ligne', [
      _buildSwitchSetting(
        'Réservation en ligne',
        'Activer les réservations en ligne',
        true,
      ),
      _buildDropdownSetting('Délai minimum', '2 heures', [
        '1 heure',
        '2 heures',
        '4 heures',
        '24 heures',
      ]),
      _buildDropdownSetting('Délai maximum', '30 jours', [
        '7 jours',
        '14 jours',
        '30 jours',
        '60 jours',
      ]),
      _buildSwitchSetting(
        'Acompte',
        'Demander un acompte pour les groupes',
        true,
      ),
      _buildTextField('Montant de l\'acompte', '30%', Icons.euro),
    ]);
  }

  Widget _buildNotificationsSection() {
    return _buildSettingsCard('Notifications', [
      _buildSwitchSetting(
        'Confirmation par email',
        'Envoyer un email de confirmation',
        true,
      ),
      _buildSwitchSetting('SMS de rappel', 'Envoyer un SMS la veille', true),
      _buildDropdownSetting('Rappel client', '24 heures avant', [
        '12 heures avant',
        '24 heures avant',
        '48 heures avant',
      ]),
      _buildSwitchSetting(
        'Notifications équipe',
        'Notifier l\'équipe des nouvelles réservations',
        true,
      ),
    ]);
  }

  Widget _buildSettingsCard(String title, List<Widget> settings) {
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
            ...settings,
          ],
        ),
      ),
    );
  }

  Widget _buildCapacityTile(
    String title,
    String hours,
    int current,
    int maximum,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(hours),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: current / maximum,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                current / maximum > 0.9 ? Colors.red : Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text('$current / $maximum couverts'),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeRangeSetting(String title, TimeOfDay start, TimeOfDay end) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Select start time
                  },
                  icon: const Icon(Icons.access_time),
                  label: Text(
                    '${start.hour}:${start.minute.toString().padLeft(2, '0')}',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('à'),
              ),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Select end time
                  },
                  icon: const Icon(Icons.access_time),
                  label: Text(
                    '${end.hour}:${end.minute.toString().padLeft(2, '0')}',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
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

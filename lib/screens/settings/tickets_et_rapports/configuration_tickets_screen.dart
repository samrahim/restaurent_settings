import 'package:flutter/material.dart';

class ConfigurationTicketsScreen extends StatelessWidget {
  const ConfigurationTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Configuration des tickets',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildHeaderSection(),
                  const SizedBox(height: 16),
                  _buildContentSection(),
                  const SizedBox(height: 16),
                  _buildFooterSection(),
                  const SizedBox(height: 16),
                  _buildPrinterSection(),
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

  Widget _buildHeaderSection() {
    return _buildSettingsCard('En-tête du ticket', [
      _buildTextField('Nom du restaurant', 'Le Gourmet', Icons.business),
      _buildTextField(
        'Adresse',
        '123 rue de la Gastronomie',
        Icons.location_on,
      ),
      _buildTextField('Téléphone', '+33 1 23 45 67 89', Icons.phone),
      _buildTextField('SIRET', '123 456 789 00012', Icons.numbers),
      _buildSwitchSetting('Logo', 'Afficher le logo sur le ticket', true),
    ]);
  }

  Widget _buildContentSection() {
    return _buildSettingsCard('Contenu du ticket', [
      _buildSwitchSetting(
        'Numéro de commande',
        'Afficher le numéro de commande',
        true,
      ),
      _buildSwitchSetting(
        'Date et heure',
        'Afficher la date et l\'heure',
        true,
      ),
      _buildSwitchSetting('Nom du serveur', 'Afficher le nom du serveur', true),
      _buildSwitchSetting(
        'Numéro de table',
        'Afficher le numéro de table',
        true,
      ),
      _buildDropdownSetting('Format des prix', 'TTC', [
        'HT',
        'TTC',
        'HT et TTC',
      ]),
      _buildDropdownSetting('Détail TVA', 'Détaillé', [
        'Aucun',
        'Simple',
        'Détaillé',
      ]),
    ]);
  }

  Widget _buildFooterSection() {
    return _buildSettingsCard('Pied de ticket', [
      _buildTextField(
        'Message de remerciement',
        'Merci de votre visite !',
        Icons.message,
      ),
      _buildTextField('Site web', 'www.legourmet.fr', Icons.language),
      _buildSwitchSetting(
        'QR Code',
        'Ajouter un QR code pour le site web',
        true,
      ),
      _buildSwitchSetting(
        'Réseaux sociaux',
        'Afficher les liens sociaux',
        true,
      ),
      _buildTextField(
        'Mentions légales',
        'TVA intracommunautaire : FR12345678900',
        Icons.gavel,
      ),
    ]);
  }

  Widget _buildPrinterSection() {
    return _buildSettingsCard('Paramètres d\'impression', [
      _buildDropdownSetting('Format du papier', '80mm', ['58mm', '80mm', 'A4']),
      _buildDropdownSetting('Police', 'Standard', [
        'Compact',
        'Standard',
        'Large',
      ]),
      _buildSwitchSetting(
        'Impression automatique',
        'Imprimer automatiquement après paiement',
        true,
      ),
      _buildSwitchSetting(
        'Double copie',
        'Imprimer une copie pour le restaurant',
        true,
      ),
      _buildDropdownSetting('Imprimante par défaut', 'Caisse principale', [
        'Caisse principale',
        'Caisse secondaire',
        'Bureau',
      ]),
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

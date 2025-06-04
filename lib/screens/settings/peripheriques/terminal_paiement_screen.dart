import 'package:flutter/material.dart';

class TerminalPaiementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terminal de paiement',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildTerminalStatusSection(),
                  const SizedBox(height: 16),
                  _buildConnectionSection(),
                  const SizedBox(height: 16),
                  _buildConfigurationSection(),
                  const SizedBox(height: 16),
                  _buildTransactionSection(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Test connection
        },
        child: const Icon(Icons.sync),
        tooltip: 'Tester la connexion',
      ),
    );
  }

  Widget _buildTerminalStatusSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'État des terminaux',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildTerminalTile(
              'Terminal principal',
              'Ingenico iCT250',
              'Connecté - Port COM4',
              Icons.point_of_sale,
              true,
            ),
            _buildTerminalTile(
              'Terminal mobile',
              'Ingenico iWL250',
              'Non connecté',
              Icons.point_of_sale_outlined,
              false,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                // Search for terminals
              },
              icon: const Icon(Icons.search),
              label: const Text('Rechercher des terminaux'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Connexion',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDropdownSetting('Type de connexion', 'TCP/IP', [
              'TCP/IP',
              'Série',
              'Bluetooth',
              'USB',
            ]),
            _buildTextField('Adresse IP', '192.168.1.100', Icons.router),
            _buildTextField('Port', '8080', Icons.settings_ethernet),
            _buildSwitchSetting(
              'Reconnexion automatique',
              'Tenter de se reconnecter en cas de déconnexion',
              true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigurationSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Configuration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildTextField('Identifiant commerçant', '123456789', Icons.store),
            _buildTextField('Numéro de terminal', 'TID00001', Icons.pin),
            _buildDropdownSetting('Langue', 'Français', [
              'Français',
              'English',
              'Deutsch',
              'Español',
            ]),
            _buildSwitchSetting(
              'Mode test',
              'Utiliser l\'environnement de test',
              false,
            ),
            _buildSwitchSetting(
              'Impression ticket',
              'Imprimer automatiquement le ticket',
              true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSwitchSetting(
              'Paiement sans contact',
              'Activer le paiement sans contact',
              true,
            ),
            _buildSwitchSetting(
              'Paiement mobile',
              'Accepter les paiements mobiles (NFC)',
              true,
            ),
            _buildTextField('Montant minimum sans contact', '50', Icons.euro),
            _buildDropdownSetting('Mode de remboursement', 'Sur la carte', [
              'Sur la carte',
              'En espèces',
              'Au choix',
            ]),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                // Show transaction history
              },
              icon: const Icon(Icons.history),
              label: const Text('Historique des transactions'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTerminalTile(
    String name,
    String model,
    String status,
    IconData icon,
    bool isConnected,
  ) {
    return ListTile(
      leading: Icon(icon, color: isConnected ? Colors.green : Colors.grey),
      title: Text(name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(model), Text(status)],
      ),
      trailing: PopupMenuButton(
        itemBuilder:
            (context) => [
              const PopupMenuItem(
                value: 'configure',
                child: Text('Configurer'),
              ),
              const PopupMenuItem(
                value: 'update',
                child: Text('Mettre à jour'),
              ),
              const PopupMenuItem(value: 'reset', child: Text('Réinitialiser')),
            ],
        onSelected: (value) {
          // Handle menu selection
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
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Scanner', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildScannerStatusSection(),
                  const SizedBox(height: 16),
                  _buildConfigurationSection(),
                  const SizedBox(height: 16),
                  _buildBarcodeTypesSection(),
                  const SizedBox(height: 16),
                  _buildAdvancedSection(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Test scanner
        },
        tooltip: 'Tester le scanner',
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }

  Widget _buildScannerStatusSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'État du scanner',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildScannerTile(
              'Scanner principal',
              'Zebra DS2208',
              'Connecté - Port USB',
              Icons.qr_code_scanner,
              true,
            ),
            _buildScannerTile(
              'Scanner mobile',
              'Zebra DS9908',
              'Non connecté',
              Icons.qr_code_scanner_outlined,
              false,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                // Search for scanners
              },
              icon: const Icon(Icons.search),
              label: const Text('Rechercher des scanners'),
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
            _buildDropdownSetting('Mode de lecture', 'Manuel', [
              'Manuel',
              'Continu',
              'Présentation',
            ]),
            _buildDropdownSetting('Format de données', 'Code produit', [
              'Code produit',
              'URL',
              'Texte',
              'Personnalisé',
            ]),
            _buildSwitchSetting(
              'Son de confirmation',
              'Émettre un bip lors du scan',
              true,
            ),
            _buildSwitchSetting('Vibration', 'Vibrer lors du scan', true),
            _buildSwitchSetting(
              'Lecture automatique',
              'Scanner automatiquement lors de la détection',
              false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarcodeTypesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Types de codes-barres',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildBarcodeTypeTile('Code 128', 'Code-barres 1D standard', true),
            _buildBarcodeTypeTile('QR Code', 'Code-barres 2D matriciel', true),
            _buildBarcodeTypeTile(
              'EAN-13',
              'Code-barres produit international',
              true,
            ),
            _buildBarcodeTypeTile(
              'Code 39',
              'Code-barres alphanumérique',
              false,
            ),
            _buildBarcodeTypeTile(
              'DataMatrix',
              'Code-barres 2D industriel',
              false,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                // Configure barcode types
              },
              icon: const Icon(Icons.settings),
              label: const Text('Configurer les types de codes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Paramètres avancés',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildTextField('Préfixe', '', Icons.text_fields),
            _buildTextField('Suffixe', '\n', Icons.text_fields),
            _buildDropdownSetting('Timeout de lecture', '5 secondes', [
              '2 secondes',
              '5 secondes',
              '10 secondes',
              'Illimité',
            ]),
            _buildSwitchSetting(
              'Mode debug',
              'Afficher les informations de débogage',
              false,
            ),
            _buildSwitchSetting(
              'Mise en cache',
              'Mettre en cache les codes scannés',
              true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScannerTile(
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

  Widget _buildBarcodeTypeTile(
    String name,
    String description,
    bool isEnabled,
  ) {
    return ListTile(
      title: Text(name),
      subtitle: Text(description),
      trailing: Switch(
        value: isEnabled,
        onChanged: (bool value) {
          // Toggle barcode type
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

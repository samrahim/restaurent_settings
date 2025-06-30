import 'package:flutter/material.dart';

class ImpressionTicketScreen extends StatelessWidget {
  const ImpressionTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Impression du ticket de caisse',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildPrinterStatusSection(),
                  const SizedBox(height: 16),
                  _buildPrintingOptionsSection(),
                  const SizedBox(height: 16),
                  _buildAutomaticPrintingSection(),
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
          // Print test ticket
        },
        tooltip: 'Imprimer un ticket test',
        child: const Icon(Icons.print),
      ),
    );
  }

  Widget _buildPrinterStatusSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'État des imprimantes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildPrinterTile(
              'Imprimante principale',
              'Epson TM-T88VI',
              'Connectée - Port USB',
              Icons.print,
              true,
            ),
            _buildPrinterTile(
              'Imprimante cuisine',
              'Epson TM-T20III',
              'Connectée - Réseau',
              Icons.print_outlined,
              true,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                // Configure printers
              },
              icon: const Icon(Icons.settings),
              label: const Text('Configurer les imprimantes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrintingOptionsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Options d\'impression',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDropdownSetting('Format du papier', '80mm', [
              '58mm',
              '80mm',
              'A4',
            ]),
            _buildDropdownSetting('Qualité d\'impression', 'Normal', [
              'Brouillon',
              'Normal',
              'Haute qualité',
            ]),
            _buildSwitchSetting(
              'Impression recto-verso',
              'Imprimer sur les deux faces du papier',
              false,
            ),
            _buildSwitchSetting(
              'Mode économique',
              'Réduire la consommation d\'encre',
              false,
            ),
            _buildTextField('Nombre de copies', '1', Icons.copy),
          ],
        ),
      ),
    );
  }

  Widget _buildAutomaticPrintingSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Impression automatique',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSwitchSetting(
              'Ticket client',
              'Imprimer automatiquement le ticket client',
              true,
            ),
            _buildSwitchSetting(
              'Ticket cuisine',
              'Imprimer automatiquement en cuisine',
              true,
            ),
            _buildSwitchSetting(
              'Ticket bar',
              'Imprimer automatiquement au bar',
              true,
            ),
            _buildSwitchSetting(
              'Facture',
              'Imprimer automatiquement la facture',
              false,
            ),
            _buildSwitchSetting(
              'Duplicata',
              'Imprimer automatiquement un duplicata',
              false,
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
            _buildDropdownSetting('Police de caractères', 'Standard', [
              'Standard',
              'Condensé',
              'Large',
            ]),
            _buildDropdownSetting('Codage des caractères', 'UTF-8', [
              'UTF-8',
              'ISO-8859-1',
              'Windows-1252',
            ]),
            _buildSwitchSetting(
              'Mode silencieux',
              'Réduire le bruit d\'impression',
              false,
            ),
            _buildSwitchSetting(
              'Coupe automatique',
              'Couper automatiquement le papier',
              true,
            ),
            _buildSwitchSetting(
              'Mode debug',
              'Imprimer les informations de débogage',
              false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrinterTile(
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
              const PopupMenuItem(value: 'test', child: Text('Imprimer test')),
              const PopupMenuItem(
                value: 'configure',
                child: Text('Configurer'),
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
        keyboardType: TextInputType.number,
      ),
    );
  }
}

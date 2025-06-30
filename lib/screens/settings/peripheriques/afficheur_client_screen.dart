import 'package:flutter/material.dart';

class AfficheurClientScreen extends StatelessWidget {
  const AfficheurClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Afficheur client',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildDisplayStatusSection(),
                  const SizedBox(height: 16),
                  _buildContentSection(),
                  const SizedBox(height: 16),
                  _buildLayoutSection(),
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
          // Test display
        },
        tooltip: 'Tester l\'affichage',
        child: const Icon(Icons.preview),
      ),
    );
  }

  Widget _buildDisplayStatusSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'État de l\'afficheur',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildStatusTile(
              'Afficheur principal',
              'Connecté - Port COM3',
              Icons.display_settings,
              true,
            ),
            _buildStatusTile(
              'Afficheur secondaire',
              'Non connecté',
              Icons.display_settings_outlined,
              false,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                // Detect displays
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Détecter les afficheurs'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contenu affiché',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSwitchSetting(
              'Prix unitaire',
              'Afficher le prix unitaire des articles',
              true,
            ),
            _buildSwitchSetting(
              'Quantité',
              'Afficher la quantité des articles',
              true,
            ),
            _buildSwitchSetting(
              'Sous-total',
              'Afficher le sous-total en temps réel',
              true,
            ),
            _buildSwitchSetting(
              'Remises',
              'Afficher les remises appliquées',
              true,
            ),
            _buildSwitchSetting(
              'Messages personnalisés',
              'Afficher les messages de bienvenue/au revoir',
              true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLayoutSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mise en page',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDropdownSetting('Mode d\'affichage', 'Défilement', [
              'Statique',
              'Défilement',
              'Alterné',
            ]),
            _buildDropdownSetting('Orientation', 'Paysage', [
              'Portrait',
              'Paysage',
            ]),
            _buildDropdownSetting('Taille du texte', 'Normal', [
              'Petit',
              'Normal',
              'Grand',
            ]),
            const SizedBox(height: 16),
            _buildColorPicker('Couleur du texte', Colors.white),
            const SizedBox(height: 8),
            _buildColorPicker('Couleur de fond', Colors.black),
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
            _buildTextField('Vitesse de défilement (ms)', '1000', Icons.speed),
            _buildTextField('Délai d\'inactivité (s)', '30', Icons.timer),
            _buildSwitchSetting(
              'Mode économie d\'énergie',
              'Éteindre l\'écran après inactivité',
              true,
            ),
            _buildSwitchSetting(
              'Mode debug',
              'Afficher les informations de débogage',
              false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTile(
    String name,
    String status,
    IconData icon,
    bool isConnected,
  ) {
    return ListTile(
      leading: Icon(icon, color: isConnected ? Colors.green : Colors.grey),
      title: Text(name),
      subtitle: Text(status),
      trailing: IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          // Configure display
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

  Widget _buildColorPicker(String label, Color color) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.color_lens),
          onPressed: () {
            // Open color picker
          },
        ),
      ],
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

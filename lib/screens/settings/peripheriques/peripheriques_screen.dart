import 'package:flutter/material.dart';

class PeripheriquesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Périphériques',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildDeviceCard(
                    'Imprimante thermique',
                    'EPSON TM-T88VI',
                    'Connecté',
                    Icons.print,
                    Colors.green,
                  ),
                  _buildDeviceCard(
                    'Terminal de paiement',
                    'Ingenico iCT250',
                    'Connecté',
                    Icons.payment,
                    Colors.green,
                  ),
                  _buildDeviceCard(
                    'Scanner code-barres',
                    'Zebra DS2208',
                    'Non connecté',
                    Icons.qr_code_scanner,
                    Colors.red,
                  ),
                  _buildDeviceCard(
                    'Afficheur client',
                    'Customer Display VFD-202',
                    'En attente',
                    Icons.desktop_windows,
                    Colors.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_circle_outline),
        tooltip: 'Ajouter un périphérique',
      ),
    );
  }

  Widget _buildDeviceCard(
    String name,
    String model,
    String status,
    IconData icon,
    Color statusColor,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ExpansionTile(
        leading: Icon(icon, size: 32),
        title: Text(name),
        subtitle: Text(model),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(status),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildActionButton('Configurer', Icons.settings, () {}),
                const SizedBox(height: 8),
                _buildActionButton('Tester la connexion', Icons.refresh, () {}),
                const SizedBox(height: 8),
                _buildActionButton(
                  'Supprimer',
                  Icons.delete_outline,
                  () {},
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    VoidCallback onPressed, {
    Color color = Colors.blue,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}

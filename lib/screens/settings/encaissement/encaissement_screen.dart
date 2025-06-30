import 'package:flutter/material.dart';

class EncaissementScreen extends StatelessWidget {
  const EncaissementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Encaissement',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildSection('Caisse actuelle', [
                      _buildInfoTile('Montant en caisse', '1250.00 €'),
                      _buildInfoTile('Transactions du jour', '45'),
                      _buildInfoTile('Dernier encaissement', '14:30'),
                    ]),
                    const SizedBox(height: 16),
                    _buildSection('Actions rapides', [
                      _buildActionTile(
                        'Ouvrir la caisse',
                        Icons.lock_open,
                        () {},
                      ),
                      _buildActionTile(
                        'Fermer la caisse',
                        Icons.lock_outline,
                        () {},
                      ),
                      _buildActionTile(
                        'Imprimer le rapport',
                        Icons.print,
                        () {},
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
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
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildActionTile(String label, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

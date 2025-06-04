import 'package:flutter/material.dart';

class DepannageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dépannage',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildTroubleshootingCard(
                    'Problèmes de connexion',
                    'Résolution des problèmes de connexion réseau',
                    Icons.wifi_off,
                    [
                      'Vérifier la connexion WiFi',
                      'Redémarrer le routeur',
                      'Vérifier les paramètres réseau',
                    ],
                  ),
                  _buildTroubleshootingCard(
                    'Problèmes d\'impression',
                    'Résolution des problèmes d\'imprimante',
                    Icons.print,
                    [
                      'Vérifier le niveau d\'encre',
                      'Vérifier la connexion de l\'imprimante',
                      'Redémarrer l\'imprimante',
                    ],
                  ),
                  _buildTroubleshootingCard(
                    'Problèmes de paiement',
                    'Résolution des problèmes de terminal de paiement',
                    Icons.payment,
                    [
                      'Vérifier la connexion du terminal',
                      'Redémarrer le terminal',
                      'Contacter le support technique',
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Contact support
        },
        child: const Icon(Icons.support_agent),
        tooltip: 'Contacter le support',
      ),
    );
  }

  Widget _buildTroubleshootingCard(
    String title,
    String subtitle,
    IconData icon,
    List<String> steps,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ExpansionTile(
        leading: Icon(icon, size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Étapes de résolution :',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                ...steps.map(
                  (step) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_right, size: 20),
                        const SizedBox(width: 8),
                        Expanded(child: Text(step)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        // View detailed guide
                      },
                      icon: const Icon(Icons.book),
                      label: const Text('Guide détaillé'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Start diagnostic
                      },
                      icon: const Icon(Icons.build),
                      label: const Text('Lancer le diagnostic'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AideEnLigneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Aide en ligne',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            _buildSearchField(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildHelpSection('Guides rapides', [
                    _buildHelpCard(
                      'Prise en main',
                      'Guide de démarrage rapide',
                      Icons.rocket_launch,
                    ),
                    _buildHelpCard(
                      'Configuration initiale',
                      'Paramétrage de base du système',
                      Icons.settings,
                    ),
                    _buildHelpCard(
                      'Gestion des commandes',
                      'Processus de prise de commande',
                      Icons.receipt_long,
                    ),
                  ]),
                  _buildHelpSection('Tutoriels vidéo', [
                    _buildVideoCard(
                      'Configuration de la caisse',
                      '5:30',
                      'Tutoriel complet sur la configuration',
                    ),
                    _buildVideoCard(
                      'Gestion des stocks',
                      '8:45',
                      'Apprendre à gérer vos stocks',
                    ),
                    _buildVideoCard(
                      'Rapports et statistiques',
                      '6:15',
                      'Analyse des données de vente',
                    ),
                  ]),
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
        child: const Icon(Icons.chat),
        tooltip: 'Chat avec le support',
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Rechercher dans l\'aide...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildHelpSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ...items,
      ],
    );
  }

  Widget _buildHelpCard(String title, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to help article
        },
      ),
    );
  }

  Widget _buildVideoCard(String title, String duration, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          Container(
            height: 160,
            color: Colors.grey[200],
            child: Center(
              child: Icon(
                Icons.play_circle_outline,
                size: 48,
                color: Colors.grey[400],
              ),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(child: Text(title)),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    duration,
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  ),
                ),
              ],
            ),
            subtitle: Text(description),
            trailing: PopupMenuButton(
              itemBuilder:
                  (context) => [
                    const PopupMenuItem(
                      value: 'download',
                      child: Text('Télécharger'),
                    ),
                    const PopupMenuItem(
                      value: 'share',
                      child: Text('Partager'),
                    ),
                  ],
            ),
          ),
        ],
      ),
    );
  }
}

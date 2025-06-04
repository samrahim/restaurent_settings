import 'package:flutter/material.dart';

class PermissionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Permissions',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            _buildSearchField(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildPermissionGroup('Gestion des commandes', [
                    _buildPermissionItem(
                      'Prendre une commande',
                      'Permet de créer et modifier des commandes',
                      true,
                    ),
                    _buildPermissionItem(
                      'Annuler une commande',
                      'Permet d\'annuler des commandes en cours',
                      false,
                    ),
                    _buildPermissionItem(
                      'Appliquer des remises',
                      'Permet d\'appliquer des réductions',
                      false,
                    ),
                  ]),
                  _buildPermissionGroup('Gestion de la caisse', [
                    _buildPermissionItem(
                      'Encaisser un paiement',
                      'Permet de procéder aux encaissements',
                      true,
                    ),
                    _buildPermissionItem(
                      'Accéder au fond de caisse',
                      'Permet de gérer le fond de caisse',
                      false,
                    ),
                    _buildPermissionItem(
                      'Voir les rapports',
                      'Permet de consulter les rapports de caisse',
                      false,
                    ),
                  ]),
                  _buildPermissionGroup('Administration', [
                    _buildPermissionItem(
                      'Gérer les utilisateurs',
                      'Permet de créer et modifier les utilisateurs',
                      false,
                    ),
                    _buildPermissionItem(
                      'Configurer le système',
                      'Permet de modifier les paramètres système',
                      false,
                    ),
                    _buildPermissionItem(
                      'Gérer les produits',
                      'Permet de modifier le catalogue',
                      false,
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
          // Save permissions
        },
        child: const Icon(Icons.save),
        tooltip: 'Enregistrer les modifications',
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Rechercher une permission...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildPermissionGroup(String title, List<Widget> permissions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {
                  // Toggle all permissions in group
                },
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Tout sélectionner'),
              ),
            ],
          ),
        ),
        ...permissions,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPermissionItem(
    String title,
    String description,
    bool isGranted,
  ) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: Switch(
          value: isGranted,
          onChanged: (bool value) {
            // Toggle permission
          },
        ),
        onTap: () {
          // Show detailed permission settings
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/widgets/button_supprimer.dart';

class DepannageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SYNCHRONISATION DES DONNÉES AVEC LE WEB',
                style: AppTextStyle.greysubHeading,
              ),
              const SizedBox(height: 8),
              ButtonSupprimer(
                style: null,
                onTap: () {},
                text: 'Synchroniser la configuration',
              ),
              const SizedBox(height: 24),
              Text(
                'information de dépannage'.toUpperCase(),
                style: AppTextStyle.greysubHeading,
              ),
              const SizedBox(height: 8),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      tileColor: Colors.white,
                      title: Text(
                        'Version de l\'application',
                        style: AppTextStyle.greysubHeading,
                      ),
                      trailing: Text(
                        style: AppTextStyle.greysubHeading,
                        '5.4.0 (110.154.100359,testflight, 100359-g)',
                      ),
                    ),
                    Divider(),
                    ListTile(
                      tileColor: Colors.white,
                      title: Text(
                        'Compte active',
                        style: AppTextStyle.greysubHeading,
                      ),
                      trailing: Text(
                        style: AppTextStyle.greysubHeading,
                        'add-demo_lne_swift_3036',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'SUR DEMANDE DU SUPPORT',
                style: AppTextStyle.greysubHeading,
              ),
              const SizedBox(height: 8),

              Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ButtonSupprimer(
                      style: null,
                      onTap: () {},
                      text: "Envoyer les bases pour depanage",
                    ),
                    Divider(height: 0),
                    ButtonSupprimer(
                      style: null,
                      onTap: () {},
                      text: "Activer le mode hors-ligne",
                    ),
                    Divider(height: 0),
                    ButtonSupprimer(
                      style: AppTextStyle.redsubHeading.copyWith(
                        color: AppColors.greyaccent,
                        fontWeight: FontWeight.bold,
                      ),
                      onTap: () {},
                      text:
                          "Deactiver le mode hors-ligne (revenir en MultiPads)",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ButtonSupprimer(
                      style: null,
                      onTap: () {},
                      text: "Forcer la clôture en local",
                    ),
                    Divider(height: 0),
                    ButtonSupprimer(
                      style: null,
                      onTap: () {},
                      text: "forcer la clôture en local sur le serveur",
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),
              ButtonSupprimer(
                style: AppTextStyle.redsubHeading.copyWith(
                  color: AppColors.greyaccent,
                  fontWeight: FontWeight.bold,
                ),
                onTap: () {},
                text: "Corriger les problèmes de base de données",
              ),
            ],
          ),
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

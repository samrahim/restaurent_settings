import 'package:flutter/material.dart';
import 'screens/reglage_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Settings',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const ReglageScreen(),
    );
  }
}

List<Map<String, Map<String, dynamic>>> reglages = [
  {
    'aide': {'option-1': 'depannage', 'option-2': 'aide-en-ligne'},
    'organisation': {
      'option-1': 'plan-de-salle',
      'option-2': 'comptoirs',
      'option-3': 'multipads',
      'option-4': 'enseigne',
      'option-5': 'cet-appareil',
    },
    'utilisateur': {
      'option-1': 'gestion-des-utilisateur',
      'option-2': 'permissions',
      'option-3': 'groupes-utilisateurs',
      'option-4': 'verrouillage',
      'option-5': 'mes-preferences',
    },
    'carte': {
      'option-1': 'produits',
      'option-2': 'informations-generales-1',
      'option-3': 'gestion-des-quantites-1',
      'option-4': 'modificateurs-supplements',
      'option-5': 'informations-generales-2',
      'option-6': 'menus',
      'option-7': 'informations-generales-3',
      'option-8': 'grille-de-produits',
      'option-9': 'categories-de-produit',
      'option-10': 'informations-generales-4',
      'option-11': 'grille-des-produits',
      'option-12': 'categories-de-prix',
      'option-13': 'informations-generales-5',
      'option-14': 'produits-2',
      'option-15': 'gestion-des-quantites-2',
      'option-16': 'laddition-menu',
    },
    'encaissement': {
      'option-1': 'encaissement',
      'option-2': 'moyen-de-paiement',
      'option-3': 'pourboires-et-trop-percus',
      'option-4': 'taux-de-tva',
      'option-5': 'remises',
      'option-6': 'mouvements-personnalises',
    },
    'prise-de-commande': {'option-1': 'prise-de-commande'},
    'peripheriques': {
      'option-1': 'liste-des-peripheriques',
      'option-2': 'reseaux-wifi',
      'option-3': 'afficheur-client',
      'option-4': 'terminal-de-paiement',
      'option-5': 'scanner',
    },
    'tickets-de-caisse-et-rapports': {
      'option-1': 'impression-du-ticket-de-caisse',
      'option-2': 'format-et-contenu-du-ticket-de-caisse',
      'option-3': 'entete-et-pied-de-page-du-ticket',
      'option-4': 'rapports-x-et-z',
      'option-5': 'tags-de-commande',
    },
    'fabrication': {
      'option-1': 'impression-en-cuisine',
      'option-2': 'points-de-fabrication',
      'option-3': 'groupes-de-fabrication',
      'option-4': 'bon-de-fabrication',
      'option-5': 'bon-dassemblage',
      'option-6': 'restauration-rapide',
    },
    'reservations': {'option-1': 'reservations'},
  },
];

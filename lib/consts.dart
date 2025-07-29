import 'package:flutter/material.dart';
import 'package:restaurent/screens/settings/aide/aide.dart';
import 'package:restaurent/screens/settings/carte/carte.dart';
import 'package:restaurent/screens/settings/fabrication/fabrication_screen.dart';
import 'package:restaurent/screens/settings/organisation/organisation.dart';
import 'package:restaurent/screens/settings/reservations/configuration_reservations_screen.dart';
import 'package:restaurent/screens/settings/tickets/impression_ticket_screen.dart';
import 'package:restaurent/screens/settings/tickets/rapport_screen.dart';
import 'package:restaurent/screens/settings/utilisateur/utilisateur.dart';

import 'screens/settings/encaissement/encaissemenet.dart';
import 'screens/settings/peripheriques/perepheriques.dart';

Map<String, Map<String, dynamic>> routes = {
  'Aide': {
    'option-1': {'label': 'Dépannage', 'content': DepannageScreen()},
    'option-2': {'label': 'Aide en ligne', 'content': AideEnLigneScreen()},
  },
  'Organisation': {
    'option-1': {'label': 'Plan de salle', 'content': PlanDeSalleScreen()},
    'option-2': {'label': 'Comptoirs', 'content': ComptoirsScreen()},
    'option-3': {'label': 'Multipads', 'content': MultipadsScreen()},
    'option-4': {'label': 'Enseigne', 'content': EnseigneScreen()},
    'option-5': {'label': 'Cet appareil', 'content': CetAppreil()},
  },
  'Utilisateur': {
    'option-1': {
      'label': 'Gestion des utilisateurs',
      'content': GestionUtilisareurScreen(),
    },
    'option-2': {'label': 'Permissions', 'content': PermissionsScreen()},
    'option-3': {
      'label': 'Groupes utilisateurs',
      'content': GroupesUtilisateursScreen(),
    },
    'option-4': {'label': 'Verrouillage', 'content': VerrouillageScreen()},
    'option-5': {'label': 'Mes préférences', 'content': MesPreferencesScreen()},
  },
  'Carte': {
    'option-1': {'label': 'Produits', 'content': ProduitsScreen()},
    'option-2': {
      'label': 'Informations générales',
      'content': InformationsGeneralesScreen(),
    },
    'option-3': {
      'label': 'Gestion des quantités',
      'content': GestionQuantitesScreen(),
    },
    'option-4': {
      'label': 'Modificateurs & suppléments',
      'content': ModificateursSupplementsScreen(),
    },
    'option-5': {
      'label': 'Informations générales',
      'content': InformationsGeneralesScreen(),
    },
    'option-6': {'label': 'Menus', 'content': MenusScreen()},

    'option-7': {
      'label': 'Grille de produits',
      'content': GrilleProduitScreen(),
    },
    'option-8': {
      'label': 'Catégories de produit',
      'content': CategoriesProduitScreen(),
    },

    'option-9': {
      'label': 'Grille des produits',
      'content': GrilleProduitScreen(),
    },
    'option-10': {
      'label': 'Catégories de prix',
      'content': CategoriesPrixScreen(),
    },
  },
  'Encaissement': {
    'option-1': {'label': 'Encaissement', 'content': EncaissementScreen()},
    'option-2': {
      'label': 'Moyen de paiement',
      'content': MoyenPaiementScreen(),
    },
    'option-3': {
      'label': 'Pourboires et trop-perçus',
      'content': PourboiresTropPercusScreen(),
    },
    'option-4': {'label': 'Taux de TVA', 'content': TauxTVAScreen()},
    'option-5': {'label': 'Remises', 'content': RemisesScreen()},
    'option-6': {
      'label': 'Mouvements personnalisés',
      'content': MouvementsPersonnalisesScreen(),
    },
  },
  'Prise de commande': {
    'option-1': {'label': 'Prise de commande', 'content': DepannageScreen()},
  },
  'Peripheriques': {
    'option-1': {
      'label': 'Liste des périphériques',
      'content': PeripheriquesScreen(),
    },
    'option-2': {
      'label': 'Liste des imprimante',
      'content': ImprimanteScreen(),
    },
    'option-3': {'label': 'Réseaux WiFi', 'content': ReseauxWiFiScreen()},
    'option-4': {
      'label': 'Afficheur client',
      'content': AfficheurClientScreen(),
    },
    'option-5': {
      'label': 'Terminal de paiement',
      'content': TerminalPaiementScreen(),
    },
    'option-6': {'label': 'Scanner', 'content': ScannerScreen()},
  },
  'Tickets de caisse et rapports': {
    'option-1': {
      'label': 'Impression du ticket de caisse',
      'content': ImpressionTicketScreen(),
    },
    'option-2': {
      'label': 'Format et contenu du ticket de caisse',
      'content': DepannageScreen(),
    },
    'option-3': {
      'label': 'En-tête et pied de page du ticket',
      'content': DepannageScreen(),
    },
    'option-4': {'label': 'Rapports X et Z', 'content': RapportScreen()},
    'option-5': {'label': 'Tags de commande', 'content': DepannageScreen()},
  },
  'Fabrication': {
    'option-1': {
      'label': 'Impression en cuisine',
      'content': FabricationScreen(),
    },
    'option-2': {
      'label': 'Points de fabrication',
      'content': DepannageScreen(),
    },
    'option-3': {
      'label': 'Groupes de fabrication',
      'content': DepannageScreen(),
    },
    'option-4': {'label': 'Bon de fabrication', 'content': DepannageScreen()},
    'option-5': {'label': "Bon d'assemblage", 'content': DepannageScreen()},
    'option-6': {'label': 'Restauration rapide', 'content': DepannageScreen()},
  },
  'Reservations': {
    'option-1': {
      'label': 'Réservations',
      'content': ConfigurationReservationsScreen(),
    },
  },
};

List<String> roleList = ['Administrateur', 'Serveur', 'Responsable de salle'];
const String baseUrl = 'http://51.15.211.239:8444/api/v1/';

class AppTextStyle {
  static TextStyle? indingoHeading = TextStyle(
    fontSize: 22,
    color: Colors.indigo.shade400,
    fontWeight: FontWeight.w600,
  );
  static TextStyle? largeindingotext = TextStyle(
    fontSize: 28,
    color: Colors.indigo.shade400,
  );
  static TextStyle indingosubHeading = TextStyle(
    fontSize: 20,
    color: Colors.indigo.shade400,
  );

  static TextStyle greyHeading = TextStyle(fontSize: 22, color: Colors.grey);

  static const TextStyle greysubHeading = TextStyle(
    fontSize: 20,
    color: Colors.grey,
  );
  static const TextStyle redsubHeading = TextStyle(
    fontSize: 20,
    color: Colors.red,
  );
}

class AppColors {
  static const Color primary = Colors.blue;
  static final grey = Colors.grey[50];
  static final greyaccentmeduid = Colors.grey[300];
  static final greyaccent = Colors.grey[500];

  static Color? indingo200 = Colors.indigo[200];
  static Color? indingo400 = Colors.indigo[400];
  static const Color quaternary = Color(0xFF000000);
  static const Color quinary = Color(0xFF000000);
  static const Color senary = Color(0xFF000000);
  static const Color septenary = Color(0xFF000000);
}

const moyenDePaiementList = [
  'Aucune',
  'Carte bancaire',
  "Espèces",
  'Ticket Restaurant',
];

enum FieldType { string, boolean, dropdown, color, pattern, choice }

const List<String> gestionDuTropPercuList = [
  'Gestion du trop perçu',
  'Rendre la monnaie',
  'Générer un avoir',
  'Transformer en pourboir',
];

const List<String> modeEncaissementList = [
  'Calculatrice classique',
  'Terminal de paiement - TPE',
  'Calculatrice Ticket Restaurant',
  'Scanner de Ticket Restaurant',
];

enum AffectationMode {
  POUR_TOUT,
  POUR_SEULEMENT,
  POUR_TOUT_SAUF,
  AJOUTER_A_LIST_EXSISTANTE,
}

enum TypeDeSelection { SINGLE, MULTIPLE_QUANTITE }

const List<String> joursSemaine = [
  'Lundi',
  'Mardi',
  'Mercredi',
  'Jeudi',
  'Vendredi',
  'Samedi',
  'Dimanche',
];

Color hexToColor(String? hexString) {
  if (hexString == null || hexString.isEmpty) {
    // Fallback to white if the string is null or empty
    return const Color(0xFFFFFFFF);
  }

  final buffer = StringBuffer();
  if (hexString.startsWith('#')) {
    hexString = hexString.substring(1);
  }
  if (hexString.length == 6) {
    buffer.write('ff'); // Add alpha value if not provided
  }
  buffer.write(hexString);

  try {
    return Color(int.parse(buffer.toString(), radix: 16));
  } catch (e) {
    // Fallback to white if parsing fails
    return const Color(0xFFFFFFFF);
  }
}

extension ColorExtension on Color {
  String toHex({bool leadingHashSign = true}) {
    return '${leadingHashSign ? '#' : ''}'
        '${alpha.toRadixString(16).padLeft(2, '0')}'
        '${red.toRadixString(16).padLeft(2, '0')}'
        '${green.toRadixString(16).padLeft(2, '0')}'
        '${blue.toRadixString(16).padLeft(2, '0')}';
  }
}

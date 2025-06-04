import 'package:flutter/material.dart';

class ReseauxWiFiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Réseaux WiFi',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            _buildWiFiSwitch(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildSavedNetworksSection(),
                  const SizedBox(height: 16),
                  _buildAvailableNetworksSection(),
                  const SizedBox(height: 16),
                  _buildAdvancedSettingsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Scan for networks
        },
        child: const Icon(Icons.refresh),
        tooltip: 'Actualiser les réseaux',
      ),
    );
  }

  Widget _buildWiFiSwitch() {
    return Card(
      child: SwitchListTile(
        title: const Text('WiFi'),
        subtitle: const Text('Activé - Connecté à "Restaurant_Staff"'),
        value: true,
        secondary: const Icon(Icons.wifi),
        onChanged: (bool value) {
          // Toggle WiFi
        },
      ),
    );
  }

  Widget _buildSavedNetworksSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Réseaux enregistrés',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSavedNetworkTile(
              'Restaurant_Staff',
              true,
              Icons.business,
              'Connecté',
              4,
            ),
            _buildSavedNetworkTile(
              'Restaurant_Guest',
              false,
              Icons.people,
              'Disponible',
              3,
            ),
            _buildSavedNetworkTile(
              'Backup_Network',
              false,
              Icons.backup,
              'Hors de portée',
              0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableNetworksSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Réseaux disponibles',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildAvailableNetworkTile('Restaurant_Kitchen', false, 4, true),
            _buildAvailableNetworkTile('Restaurant_Bar', false, 3, true),
            _buildAvailableNetworkTile('Public_WiFi', false, 2, false),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedSettingsSection() {
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
            _buildSwitchSetting(
              'Connexion automatique',
              'Se connecter automatiquement aux réseaux connus',
              true,
            ),
            _buildSwitchSetting(
              'Point d\'accès',
              'Activer le point d\'accès WiFi',
              false,
            ),
            _buildSwitchSetting(
              'Mode économie d\'énergie',
              'Désactiver le WiFi en veille',
              false,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                // Configure hotspot
              },
              icon: const Icon(Icons.wifi_tethering),
              label: const Text('Configurer le point d\'accès'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedNetworkTile(
    String name,
    bool isConnected,
    IconData icon,
    String status,
    int signalStrength,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      subtitle: Row(
        children: [
          Text(status),
          if (signalStrength > 0) ...[
            const SizedBox(width: 8),
            ...List.generate(
              4,
              (index) => Icon(
                Icons.signal_wifi_4_bar,
                size: 14,
                color:
                    index < signalStrength
                        ? Colors.blue
                        : Colors.grey.withOpacity(0.3),
              ),
            ),
          ],
        ],
      ),
      trailing: PopupMenuButton(
        itemBuilder:
            (context) => [
              const PopupMenuItem(
                value: 'forget',
                child: Text('Oublier ce réseau'),
              ),
              const PopupMenuItem(
                value: 'properties',
                child: Text('Propriétés'),
              ),
            ],
        onSelected: (value) {
          // Handle menu selection
        },
      ),
      onTap: () {
        // Connect/disconnect from network
      },
    );
  }

  Widget _buildAvailableNetworkTile(
    String name,
    bool isSecured,
    int signalStrength,
    bool isSaved,
  ) {
    return ListTile(
      leading: Icon(
        isSecured ? Icons.lock_outline : Icons.wifi,
        color: Colors.grey,
      ),
      title: Text(name),
      subtitle: Row(
        children: [
          if (isSaved) const Text('Réseau enregistré'),
          if (signalStrength > 0) ...[
            const SizedBox(width: 8),
            ...List.generate(
              4,
              (index) => Icon(
                Icons.signal_wifi_4_bar,
                size: 14,
                color:
                    index < signalStrength
                        ? Colors.blue
                        : Colors.grey.withOpacity(0.3),
              ),
            ),
          ],
        ],
      ),
      onTap: () {
        // Connect to network
      },
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
}

import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:ping_discover_network_plus/ping_discover_network_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class PeripheriquesScreen extends StatefulWidget {
  const PeripheriquesScreen({super.key});

  @override
  State<PeripheriquesScreen> createState() => _PeripheriquesScreenState();
}

class _PeripheriquesScreenState extends State<PeripheriquesScreen> {
  List<Map<String, String>> devices = [];
  bool isLoading = false;
  String? currentSubnet;
  String? currentDeviceIP;
  String? routerIP;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    // Request location permission for network scanning
    if (Platform.isAndroid) {
      await Permission.location.request();
    }
    _scanNetwork();
  }

  Future<void> _scanNetwork() async {
    setState(() {
      isLoading = true;
      devices = [];
    });

    try {
      final info = NetworkInfo();

      // Get current device IP
      String? ip = await info.getWifiIP();
      String? wifiName = await info.getWifiName();
      String? gateway = await info.getWifiGatewayIP();

      if (ip == null) {
        _showError(
          'Impossible de récupérer l\'adresse IP. Vérifiez votre connexion WiFi.',
        );
        setState(() {
          isLoading = false;
        });
        return;
      }

      // Extract subnet (e.g., 192.168.1.x)
      String subnet = ip.substring(0, ip.lastIndexOf('.'));

      setState(() {
        currentSubnet = subnet;
        currentDeviceIP = ip;
        routerIP = gateway;
      });

      // Add current device first
      devices.add({
        'ip': ip,
        'name': 'Cet appareil${wifiName != null ? ' ($wifiName)' : ''}',
        'status': 'Connecté',
        'type': 'mobile',
      });

      // Add router/gateway if found
      if (gateway != null && gateway != ip) {
        devices.add({
          'ip': gateway,
          'name': 'Routeur/Gateway',
          'status': 'Actif',
          'type': 'router',
        });
      }

      // Perform network scan
      await _performNetworkScan(subnet, ip, gateway);
    } catch (e) {
      _showError('Erreur lors du scan: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _performNetworkScan(
    String subnet,
    String currentIP,
    String? routerIP,
  ) async {
    Set<String> foundIPs = {currentIP};
    if (routerIP != null) foundIPs.add(routerIP);

    // Method 1: Port scan with multiple ports
    await _scanMultiplePorts(subnet, foundIPs);

    // Method 2: Try ping scan (if available)
    if (Platform.isAndroid) {
      await _tryPingScan(subnet, foundIPs);
    }
  }

  Future<void> _scanMultiplePorts(String subnet, Set<String> foundIPs) async {
    // Common ports to check
    List<int> commonPorts = [
      22,
      23,
      53,
      80,
      135,
      139,
      443,
      445,
      993,
      995,
      8080,
      8443,
      9000,
    ];

    for (int port in commonPorts) {
      try {
        final stream = NetworkAnalyzer.i.discover2(
          subnet,
          port,
          timeout: const Duration(milliseconds: 2000),
        );

        await for (final NetworkAddress addr in stream) {
          if (addr.exists && !foundIPs.contains(addr.ip)) {
            foundIPs.add(addr.ip);

            String deviceName = await _getDeviceName(addr.ip);
            String deviceType = _getDeviceType(addr.ip);

            setState(() {
              devices.add({
                'ip': addr.ip,
                'name': deviceName,
                'type': deviceType,
                'status': 'Actif',
              });
            });
          }
        }
      } catch (e) {
        // Port scan failed, continue with next port
        continue;
      }
    }
  }

  Future<void> _tryPingScan(String subnet, Set<String> foundIPs) async {
    // Try ping scan for Android devices
    for (int i = 1; i <= 254; i++) {
      String targetIP = '$subnet.$i';
      if (foundIPs.contains(targetIP)) continue;

      await _pingHost(targetIP, foundIPs);
    }
  }

  Future<void> _pingHost(String ip, Set<String> foundIPs) async {
    try {
      // Try to connect to common ports to check if device is alive
      final socket = await Socket.connect(
        ip,
        80,
        timeout: const Duration(seconds: 1),
      );
      socket.destroy();

      if (!foundIPs.contains(ip)) {
        foundIPs.add(ip);
        String deviceName = await _getDeviceName(ip);
        String deviceType = _getDeviceType(ip);

        setState(() {
          devices.add({
            'ip': ip,
            'name': deviceName,
            'type': deviceType,
            'status': 'Actif',
          });
        });
      }
    } catch (e) {
      // Connection failed, device not reachable
    }
  }

  Future<String> _getDeviceName(String ip) async {
    try {
      // Try to get hostname
      final result = await InternetAddress(ip).reverse();
      if (result.host != ip) {
        return result.host;
      }
    } catch (e) {
      // Ignore errors, use default name
    }

    return _getDefaultDeviceName(ip);
  }

  String _getDefaultDeviceName(String ip) {
    // Try to guess device type based on IP patterns
    String lastOctet = ip.substring(ip.lastIndexOf('.') + 1);
    int deviceNum = int.tryParse(lastOctet) ?? 0;

    if (deviceNum == 1) return 'Routeur / Gateway';
    if (deviceNum >= 2 && deviceNum <= 10) return 'Équipement réseau';
    if (deviceNum >= 100 && deviceNum <= 199) return 'Appareil mobile';
    if (deviceNum >= 200 && deviceNum <= 250) return 'Appareil IoT';

    return 'Appareil ($ip)';
  }

  String _getDeviceType(String ip) {
    String lastOctet = ip.substring(ip.lastIndexOf('.') + 1);
    int deviceNum = int.tryParse(lastOctet) ?? 0;

    if (deviceNum == 1) return 'router';
    if (deviceNum >= 2 && deviceNum <= 10) return 'network';
    if (deviceNum >= 100 && deviceNum <= 199) return 'mobile';
    if (deviceNum >= 200 && deviceNum <= 250) return 'iot';

    return 'device';
  }

  IconData _getDeviceIcon(String type) {
    switch (type) {
      case 'router':
        return Icons.router;
      case 'network':
        return Icons.settings_ethernet;
      case 'mobile':
        return Icons.phone_android;
      case 'iot':
        return Icons.devices_other;
      default:
        return Icons.devices;
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showInfo(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void _showDeviceDetails(Map<String, String> device) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(device['name'] ?? 'Appareil inconnu'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Adresse IP: ${device['ip']}'),
                Text('Statut: ${device['status']}'),
                if (device['type'] != null) Text('Type: ${device['type']}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Fermer'),
              ),
            ],
          ),
    );
  }

  Future<void> _tryRouterAdminAccess() async {
    if (routerIP == null) return;

    // Common router admin ports
    List<int> adminPorts = [80, 443, 8080, 8443];

    for (int port in adminPorts) {
      try {
        final socket = await Socket.connect(
          routerIP!,
          port,
          timeout: const Duration(seconds: 2),
        );
        socket.destroy();

        _showInfo(
          'Routeur détecté à $routerIP:$port\n'
          'Ouvrez votre navigateur et allez à:\n'
          'http://$routerIP${port != 80 ? ':$port' : ''}',
        );
        return;
      } catch (e) {
        // Port not open, continue
      }
    }

    _showInfo(
      'Impossible d\'accéder au routeur.\n'
      'Essayez d\'ouvrir votre navigateur et d\'aller à:\n'
      'http://$routerIP',
    );
  }

  void _showRouterAccessDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Accès au routeur'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Pour voir tous les appareils connectés :'),
                const SizedBox(height: 10),
                const Text('1. Ouvrez votre navigateur'),
                Text('2. Allez à: http://${routerIP ?? 'IP_ROUTEUR'}'),
                const Text('3. Connectez-vous (admin/admin ou admin/password)'),
                const Text(
                  '4. Cherchez "Appareils connectés" ou "DHCP clients"',
                ),
                const SizedBox(height: 10),
                const Text(
                  'Note: Certains routeurs bloquent la découverte entre appareils pour la sécurité.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Compris'),
              ),
              if (routerIP != null)
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _tryRouterAdminAccess();
                  },
                  child: const Text('Tester'),
                ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Périphériques sur le réseau'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.router),
            onPressed: _showRouterAccessDialog,
            tooltip: 'Accéder au routeur',
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => _tryRouterAdminAccess(),
            tooltip: 'Détecter le routeur',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Network info card
            if (currentSubnet != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.wifi),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Réseau: $currentSubnet.x'),
                            Text('Votre IP: $currentDeviceIP'),
                            if (routerIP != null) Text('Routeur: $routerIP'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 16),

            // Device count
            if (!isLoading)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${devices.length} appareil${devices.length > 1 ? 's' : ''} trouvé${devices.length > 1 ? 's' : ''}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (devices.length < 3)
                      TextButton(
                        onPressed: _showRouterAccessDialog,
                        child: const Text('Voir plus'),
                      ),
                  ],
                ),
              ),
            const SizedBox(height: 8),

            // Device list
            Expanded(
              child:
                  isLoading
                      ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Scan du réseau en cours...'),
                            SizedBox(height: 8),
                            Text(
                              'Cela peut prendre quelques secondes',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                      : devices.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.devices_other,
                              size: 64,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            const Text('Aucun périphérique trouvé.'),
                            const SizedBox(height: 8),
                            const Text(
                              'Vérifiez votre connexion WiFi.',
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _showRouterAccessDialog,
                              child: const Text('Accéder au routeur'),
                            ),
                          ],
                        ),
                      )
                      : ListView.builder(
                        itemCount: devices.length,
                        itemBuilder: (context, index) {
                          final device = devices[index];
                          final isCurrentDevice =
                              device['ip'] == currentDeviceIP;

                          return Card(
                            color: isCurrentDevice ? Colors.blue.shade50 : null,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    isCurrentDevice ? Colors.blue : null,
                                child: Icon(
                                  _getDeviceIcon(device['type'] ?? 'device'),
                                  color: isCurrentDevice ? Colors.white : null,
                                ),
                              ),
                              title: Text(
                                device['name'] ?? 'Inconnu',
                                style: TextStyle(
                                  fontWeight:
                                      isCurrentDevice ? FontWeight.bold : null,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(device['ip'] ?? ''),
                                  if (device['status'] != null)
                                    Text(
                                      device['status']!,
                                      style: TextStyle(
                                        color:
                                            device['status'] == 'Connecté'
                                                ? Colors.blue
                                                : Colors.green,
                                        fontSize: 12,
                                      ),
                                    ),
                                ],
                              ),
                              trailing: Icon(
                                Icons.circle,
                                color:
                                    isCurrentDevice
                                        ? Colors.blue
                                        : Colors.green,
                                size: 12,
                              ),
                              onTap: () => _showDeviceDetails(device),
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isLoading ? null : _scanNetwork,
        tooltip: 'Rafraîchir le scan',
        child:
            isLoading
                ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                : const Icon(Icons.refresh),
      ),
    );
  }
}

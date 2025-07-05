import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:network_tools_flutter/network_tools_flutter.dart';

class PeripheriquesScreen extends StatefulWidget {
  const PeripheriquesScreen({super.key});

  @override
  State<PeripheriquesScreen> createState() => _PeripheriquesScreenState();
}

class _PeripheriquesScreenState extends State<PeripheriquesScreen> {
  List<ActiveHost> foundHosts = [];
  Future<void> scanWifiDevices() async {
    final localIP = await NetworkInfo().getWifiIP();
    final subnet = localIP!.substring(0, localIP.lastIndexOf('.'));

    HostScannerService.instance
        .getAllPingableDevices(
          subnet,
          firstHostId: 1,
          lastHostId: 254,
          progressCallback:
              (p) => print('Scanning: ${(p * 100).toStringAsFixed(1)}%'),
        )
        .listen((host) async {
          final name = await host.deviceName;
          setState(() {
            foundHosts.add(host);
          });
        }, onDone: () => print('Scan terminé.'));
  }

  @override
  void initState() {
    scanWifiDevices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children:
            foundHosts.map((h) {
              return ListTile(
                title: Text(h.address),
                subtitle: FutureBuilder<String>(
                  future: h.deviceName,
                  builder: (context, snapshot) {
                    final name = snapshot.data ?? 'Inconnu';
                    return Text(name == '_gateway' ? 'router' : name);
                  },
                ),
              );
            }).toList(),
      ),
    );
  }
}

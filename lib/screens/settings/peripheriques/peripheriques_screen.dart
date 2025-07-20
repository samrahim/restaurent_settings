import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:network_tools_flutter/network_tools_flutter.dart';
import 'package:http/http.dart' as http;

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
          progressCallback: (p) => {},
        )
        .listen((host) async {
          final name = await host.deviceName;
          setState(() {
            foundHosts.add(host);
          });
        }, onDone: () => {});
  }

  Future<http.Client> loginRouter() async {
    final client = http.Client();

    final uri = Uri.parse(
      'http://192.168.1.1/login.cgi'
      '?username=rahim'
      '&password=rahim_0_admin'
      '&apply=Save', // selon le paramètre « submit »
    );
    final resp = await client.get(uri);
    if (resp.statusCode != 200) {
      throw Exception('Login failed: ${resp.body}');
    }
    return client; // garde automatiquement les cookies
  }

  @override
  void initState() {
    loginRouter();
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

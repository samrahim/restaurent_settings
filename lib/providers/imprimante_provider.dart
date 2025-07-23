import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent/models/peripherique_model.dart.dart';

enum ConnectionResult { notStarted, success, failed }

class ImprimanteProvider with ChangeNotifier {
  final http.Client client;
  List<Peripherique> _peripheriques = [];
  List<Peripherique> get peripherique => _peripheriques;
  TypeConnection? selectedType;
  String ip = '';
  int port = 0;
  bool etat = false;
  ConnectionResult? isValidConnection;
  String machineName = '';
  String emaplacemt = '';

  ImprimanteProvider({required this.client});

  void selectType(TypeConnection type) {
    selectedType = type;
    ip = '';
    port = 0;
    isValidConnection = ConnectionResult.notStarted;
    machineName = '';
    notifyListeners();
  }

  void updateetat() {
    etat = !etat;
    notifyListeners();
  }

  void updateIP(String value) {
    ip = value;
    notifyListeners();
  }

  void updateemaplacemt(String value) {
    emaplacemt = value;
    notifyListeners();
  }

  void updatePort(int value) {
    port = value;
    // _checkTCPConnection();
    notifyListeners();
  }

  void updateMachineName(String value) {
    machineName = value;
    notifyListeners();
  }

  // Future<void> _checkTCPConnection() async {
  //   if (ip.isNotEmpty && port.isNotEmpty) {
  //     try {
  //       final parsedPort = int.tryParse(port);
  //       if (parsedPort == null) return;

  //       final profile = await CapabilityProfile.load();
  //       final printer = NetworkPrinter(PaperSize.mm80, profile);

  //       final result = await printer.connect(
  //         ip,
  //         port: parsedPort,
  //         timeout: const Duration(seconds: 3),
  //       );

  //       if (result == PosPrintResult.success) {
  //         isValidConnection = ConnectionResult.success;
  //       } else {
  //         isValidConnection = ConnectionResult.failed;
  //       }

  //       if (isValidConnection == ConnectionResult.success) {
  //         printer.disconnect();
  //       }
  //     } catch (e) {
  //       isValidConnection = ConnectionResult.failed;
  //     }

  //     notifyListeners();
  //   }
  // }

  // Future<void> printTestReceipt() async {
  //   if (isValidConnection == null ||
  //       isValidConnection == ConnectionResult.failed)
  //     return;

  //   final profile = await CapabilityProfile.load();
  //   final printer = NetworkPrinter(PaperSize.mm80, profile);

  //   final result = await printer.connect(ip, port: int.tryParse(port) ?? 9100);

  //   if (result == PosPrintResult.success) {
  //     printer.text(
  //       'Test from ${machineName.isNotEmpty ? machineName : 'Flutter App'}',
  //       styles: const PosStyles(align: PosAlign.center),
  //     );
  //     printer.feed(2);
  //     printer.cut();
  //     printer.disconnect();
  //   }
  // }

  Future<void> getAllImprimantes() async {
    final response = await client.get(
      Uri.parse(
        "http://51.15.211.239:8444/api/imprimantes?TypePeripherique=IMPRIMANTE",
      ),
    );
    List data = json.decode(response.body);
    print("res ${response.body}");
    _peripheriques = data.map((e) => Peripherique.fromJson(e)).toList();
    notifyListeners();
  }

  Future<void> createImprimant() async {
    print(ip);
    final p = Peripherique(
      nom: emaplacemt,
      ip: ip,
      port: port,
      typeConnection: selectedType,
      etat: etat,
      model: machineName,
    );
    final response = await client.post(
      Uri.parse(
        'http://51.15.211.239:8444/api/imprimantes?TypePeripherique=IMPRIMANTE',
      ),
      body: json.encode(p.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    _peripheriques.add(Peripherique.fromJson(json.decode(response.body)));
    print(
      "Request Body: ${json.encode(Peripherique(nom: emaplacemt, ip: ip, port: port, typeConnection: selectedType, etat: etat, model: machineName).toJson())}",
    );
    machineName = '';
    ip = '';
    port = 0;
    selectedType = null;
    etat = false;
    notifyListeners();
    // print("res ${response.body}");
  }
}

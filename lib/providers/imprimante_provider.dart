import 'package:flutter/material.dart';
import 'package:esc_pos_printer_plus/esc_pos_printer_plus.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

enum ImprimanteType { tcpip, serie, bluetooth, usb }

class ImprimanteDrawerProvider with ChangeNotifier {
  ImprimanteType? selectedType;
  String ip = '';
  String port = '';
  bool isValidConnection = false;
  String machineName = '';

  void selectType(ImprimanteType type) {
    selectedType = type;
    ip = '';
    port = '';
    isValidConnection = false;
    machineName = '';
    notifyListeners();
  }

  void updateIP(String value) {
    ip = value;
    _checkTCPConnection();
  }

  void updatePort(String value) {
    port = value;
    _checkTCPConnection();
  }

  void updateMachineName(String value) {
    machineName = value;
    notifyListeners();
  }

  Future<void> _checkTCPConnection() async {
    print('checking TCP connection is started');
    if (ip.isNotEmpty && port.isNotEmpty) {
      try {
        final parsedPort = int.tryParse(port);
        if (parsedPort == null) return;

        // Test connection using esc_pos_printer_plus
        final profile = await CapabilityProfile.load();
        final printer = NetworkPrinter(PaperSize.mm80, profile);

        final result = await printer.connect(
          ip,
          port: parsedPort,
          timeout: const Duration(seconds: 3),
        );

        isValidConnection = (result == PosPrintResult.success);

        if (isValidConnection) {
          printer.disconnect();
        }
      } catch (e) {
        isValidConnection = false;
      }
      print('checking TCP connection is end with $isValidConnection');
      notifyListeners();
    }
  }

  Future<void> printTestReceipt() async {
    if (!isValidConnection) return;

    final profile = await CapabilityProfile.load();
    final printer = NetworkPrinter(PaperSize.mm80, profile);

    final result = await printer.connect(ip, port: int.tryParse(port) ?? 9100);

    if (result == PosPrintResult.success) {
      printer.text(
        'Test from ${machineName.isNotEmpty ? machineName : 'Flutter App'}',
        styles: const PosStyles(align: PosAlign.center),
      );
      printer.feed(2);
      printer.cut();
      printer.disconnect();
    }
  }
}

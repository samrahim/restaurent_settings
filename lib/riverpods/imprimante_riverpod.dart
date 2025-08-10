import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent/models/peripherique_model.dart.dart';

enum ConnectionResult { notStarted, success, failed }

class ImprimanteState {
  final List<Peripherique> peripheriques;
  final TypeConnection? selectedType;
  final String ip;
  final int port;
  final bool etat;
  final ConnectionResult? isValidConnection;
  final String machineName;
  final String emaplacemt;

  const ImprimanteState({
    required this.peripheriques,
    this.selectedType,
    required this.ip,
    required this.port,
    required this.etat,
    this.isValidConnection,
    required this.machineName,
    required this.emaplacemt,
  });

  ImprimanteState copyWith({
    List<Peripherique>? peripheriques,
    TypeConnection? selectedType,
    String? ip,
    int? port,
    bool? etat,
    ConnectionResult? isValidConnection,
    String? machineName,
    String? emaplacemt,
  }) {
    return ImprimanteState(
      peripheriques: peripheriques ?? this.peripheriques,
      selectedType: selectedType ?? this.selectedType,
      ip: ip ?? this.ip,
      port: port ?? this.port,
      etat: etat ?? this.etat,
      isValidConnection: isValidConnection ?? this.isValidConnection,
      machineName: machineName ?? this.machineName,
      emaplacemt: emaplacemt ?? this.emaplacemt,
    );
  }
}

class ImprimanteNotifier extends StateNotifier<ImprimanteState> {
  final http.Client client;

  ImprimanteNotifier({required this.client})
    : super(
        const ImprimanteState(
          peripheriques: [],
          ip: '',
          port: 0,
          etat: false,
          machineName: '',
          emaplacemt: '',
        ),
      );

  void selectType(TypeConnection type) {
    state = state.copyWith(
      selectedType: type,
      ip: '',
      port: 0,
      isValidConnection: ConnectionResult.notStarted,
      machineName: '',
    );
  }

  void updateetat() {
    state = state.copyWith(etat: !state.etat);
  }

  void updateIP(String value) {
    state = state.copyWith(ip: value);
  }

  void updateemaplacemt(String value) {
    state = state.copyWith(emaplacemt: value);
  }

  void updatePort(int value) {
    state = state.copyWith(port: value);
  }

  void updateMachineName(String value) {
    state = state.copyWith(machineName: value);
  }

  Future<void> getAllImprimantes() async {
    final response = await client.get(
      Uri.parse(
        "http://51.15.211.239:8444/api/imprimantes?TypePeripherique=IMPRIMANTE",
      ),
    );
    List data = json.decode(response.body);

    final peripheriques = data.map((e) => Peripherique.fromJson(e)).toList();
    state = state.copyWith(peripheriques: peripheriques);
  }

  Future<void> createImprimant() async {
    final p = Peripherique(
      nom: state.emaplacemt,
      ip: state.ip,
      port: state.port,
      typeConnection: state.selectedType,
      etat: state.etat,
      model: state.machineName,
    );
    final response = await client.post(
      Uri.parse(
        'http://51.15.211.239:8444/api/imprimantes?TypePeripherique=IMPRIMANTE',
      ),
      body: json.encode(p.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    final newPeripherique = Peripherique.fromJson(json.decode(response.body));
    state = state.copyWith(
      peripheriques: [...state.peripheriques, newPeripherique],
      machineName: '',
      ip: '',
      port: 0,
      selectedType: null,
      etat: false,
    );
    print(
      "Request Body: ${json.encode(Peripherique(nom: state.emaplacemt, ip: state.ip, port: state.port, typeConnection: state.selectedType, etat: state.etat, model: state.machineName).toJson())}",
    );
  }
}

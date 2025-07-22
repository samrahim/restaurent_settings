import 'package:equatable/equatable.dart';

enum TypeConnection { BLUETOOTH, TCT_IP, SERIE, USB }

class Peripherique extends Equatable {
  final int? id;
  final String? nom;
  final String? ip;
  final String? model;
  final int? port;
  final TypeConnection? typeConnection;
  final bool? etat;

  const Peripherique({
    required this.id,
    required this.nom,
    required this.ip,
    required this.port,

    required this.typeConnection,
    required this.etat,
    required this.model,
  });

  Peripherique copyWith({
    int? id,
    String? nom,
    String? ip,
    int? port,

    TypeConnection? typeConnection,
    bool? etat,
    String? model,
  }) {
    return Peripherique(
      model: model ?? this.model,
      id: id ?? this.id,
      nom: nom ?? this.nom,
      ip: ip ?? this.ip,
      port: port ?? this.port,

      typeConnection: typeConnection ?? this.typeConnection,
      etat: etat ?? this.etat,
    );
  }

  @override
  List<Object?> get props => [id, nom, ip, port, typeConnection, etat, model];

  factory Peripherique.fromJson(Map<String, dynamic> json) {
    return Peripherique(
      id: json['id'] as int?,
      nom: json['nom'] as String?,
      ip: json['ip'] as String?,
      port: json['port'] as int?,
      typeConnection: _mapTypeConnection(json['typeConnection'] as String?),
      model: json['imprimante'] as String?,
      etat: json['etat'] as bool?,
    );
  }

  // Helper function to map JSON values to TypeConnection enum
  static TypeConnection _mapTypeConnection(String? type) {
    switch (type) {
      case 'TCP_IP':
        return TypeConnection.TCT_IP;
      case 'BLUETOOTH':
        return TypeConnection.BLUETOOTH;
      case 'SERIE':
        return TypeConnection.SERIE;
      case 'USB':
        return TypeConnection.USB;
      default:
        return TypeConnection.BLUETOOTH; // Default fallback
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'ip': ip,
      'port': port,

      'typeConnection': typeConnection
          .toString()
          .split('.')
          .last
          .replaceAll("/", "_"),
      'etat': etat,
      'imprimante': model,
    };
  }
}

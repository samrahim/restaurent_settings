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
    this.id,
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
  static TypeConnection? _mapTypeConnectionFromString(String? type) {
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
        return null; // Return null if the string doesn't match any enum value
    }
  }

  factory Peripherique.fromJson(Map<String, dynamic> json) {
    return Peripherique(
      id: json['id'] as int?,
      nom: json['nom'] as String? ?? '', // Default to an empty string if null
      ip: json['ip'] as String? ?? '', // Default to an empty string if null
      port: json['port'] as int? ?? 0, // Default to 0 if null
      typeConnection: _mapTypeConnectionFromString(
        json['typeConnection'] as String?,
      ),
      model:
          json['imprimante'] as String? ??
          '', // Default to an empty string if null
      etat: json['etat'] as bool? ?? false, // Default to false if null
    );
  }

  // Helper function to map JSON values to TypeConnection enum
  String? _mapTypeConnection(TypeConnection? type) {
    switch (type) {
      case TypeConnection.TCT_IP:
        return 'TCP_IP';
      case TypeConnection.BLUETOOTH:
        return 'BLUETOOTH';
      case TypeConnection.SERIE:
        return 'SERIE';
      case TypeConnection.USB:
        return 'USB';
      default:
        return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'ip': ip,
      'port': port,
      'typeConnection': _mapTypeConnection(typeConnection),
      'etat': etat,
      'imprimante': model,
    };
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProduitsModel extends Equatable {
  final String? id;
  final String? nom;
  final Color? color;
  final String? prix;

  const ProduitsModel({
    required this.color,
    required this.id,
    required this.nom,
    required this.prix,
  });
  ProduitsModel copyWith({
    String? id,
    Color? color,
    String? nom,
    String? prix,
    String? image,
  }) {
    return ProduitsModel(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prix: prix ?? this.prix,
      color: color ?? this.color,
    );
  }

  @override
  List<Object?> get props => [id, nom, prix, color];
}

List<ProduitsModel> prod = [
  ProduitsModel(color: Colors.red, id: '1', nom: 'Tarte de ', prix: '1'),
];

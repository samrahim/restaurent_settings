import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProduitsModel extends Equatable {
  final String? id;
  final String? name;
  final Color? color;
  final double? pricebuy;

  const ProduitsModel({
    required this.color,
    required this.id,
    required this.name,
    required this.pricebuy,
  });
  ProduitsModel copyWith({
    String? id,
    Color? color,
    String? name,
    double? pricebuy,
    String? image,
  }) {
    return ProduitsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      pricebuy: pricebuy ?? this.pricebuy,
      color: color ?? this.color,
    );
  }

  factory ProduitsModel.fromJson(Map<String, dynamic> json) {
    return ProduitsModel(
      id: json['id'],
      name: json['name'],
      pricebuy: json['pricebuy'].toDouble(),
      color: Colors.red,
    );
  }

  @override
  List<Object?> get props => [id, name, pricebuy, color];
}

List<ProduitsModel> prod = [
  ProduitsModel(color: Colors.red, id: '1', name: 'Tarte de ', pricebuy: 1),
];

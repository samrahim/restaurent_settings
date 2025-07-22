import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/salle_model.dart';

class SalleProvider extends ChangeNotifier {
  final http.Client client;
  List<SalleModel> _salles = [];

  SalleProvider({required this.client}) {
    getSalles();
  }

  List<SalleModel> get salles => _salles;
  Future<void> getSalles() async {
    final response = await client.get(
      Uri.parse(
        '${baseUrl}dashboard/seller/shop-sections?page=1&perPage=50&lang=en',
      ),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      _salles = data.map((e) => SalleModel.fromJson(e)).toList();
      notifyListeners();
    }
  }

  List<SalleModel>? getSalleById(List<int> ids) {
    print('i called ${ids}');
    List<SalleModel> salles = [];
    for (int salleId in ids) {
      for (SalleModel salle in _salles) {
        if (salle.id == salleId) {
          print('Salle found: ${salle.name}');
          salles.add(salle);
        }
      }
    }
    return salles;
  }
}

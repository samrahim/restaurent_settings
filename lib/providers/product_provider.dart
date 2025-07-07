import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/produits_model.dart';

class ProductProvider extends ChangeNotifier {
  final http.Client client;
  List<ProduitsModel> _prod = [];

  ProductProvider({required this.client}) {
    getProds();
  }
  List<ProduitsModel> get prod => _prod;
  Future<void> getProds() async {
    try {
      final response = await client.get(Uri.parse('${baseUrl}product/allp'));
      List data = json.decode(response.body);

      _prod = data.map((e) => ProduitsModel.fromJson(e)).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  List<ProduitsModel>? getProductById(String id) {
    List<ProduitsModel> prods = [];
    for (ProduitsModel pr in _prod) {
      if (pr.id == id) {
        prods.add(pr);
      }
    }
    return prods.isNotEmpty ? prods : null;
  }
}

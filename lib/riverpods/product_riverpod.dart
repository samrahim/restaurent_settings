import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/produits_model.dart';

class ProductState {
  final List<ProduitsModel> prod;
  final List<ProduitsModel> searchResults;

  ProductState({required this.prod, required this.searchResults});

  ProductState copyWith({
    List<ProduitsModel>? prod,
    List<ProduitsModel>? searchResults,
  }) {
    return ProductState(
      prod: prod ?? this.prod,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}

class ProductNotifier extends StateNotifier<ProductState> {
  final http.Client client;

  ProductNotifier({required this.client})
    : super(ProductState(prod: [], searchResults: [])) {
    getProds();
  }

  Future<void> getProds() async {
    try {
      final response = await client.get(Uri.parse('${baseUrl}product/allp'));
      final List data = json.decode(response.body);

      final produits = data.map((e) => ProduitsModel.fromJson(e)).toList();
      state = state.copyWith(prod: produits);
    } catch (e) {
      throw 'Error fetching products: $e';
    }
  }

  Future<void> searchProds(String query) async {
    try {
      final uri = Uri.parse('${baseUrl}product/search/$query');
      final response = await client.get(uri);

      if (response.statusCode != 200) {
        throw 'Search failed (${response.statusCode})';
      }

      final List data = json.decode(response.body);
      final results = data.map((e) => ProduitsModel.fromJson(e)).toList();
      state = state.copyWith(searchResults: results);
    } catch (e) {
      throw 'Error searching products: $e';
    }
  }

  ProduitsModel? getProductById(String id) {
    for (ProduitsModel pr in state.prod) {
      if (pr.id == id) {
        return pr;
      }
    }
    return null;
  }
}

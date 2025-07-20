import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/categorie_de_modificateur.dart';

class CategorieModificateurProvider extends ChangeNotifier {
  final http.Client client;
  List<CategorieDeModificateur> _allcategories = [];
  CategorieDeModificateur? _selected;

  CategorieModificateurProvider({required this.client}) {
    loadAll();
  }

  List<CategorieDeModificateur> get allcategories => _allcategories;
  CategorieDeModificateur? get selectedCategorie => _selected;

  void select(CategorieDeModificateur modificateur) {
    _selected = modificateur;
    notifyListeners();
  }

  void loadAll() async {
    final response = await client.get(
      Uri.parse('${baseUrl}modificateurs/categories'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to load categories');
    }

    final List<dynamic> categoriesJson = json.decode(response.body);
    final List<CategorieDeModificateur> categoriesdemodificateursList =
        categoriesJson
            .map((json) => CategorieDeModificateur.fromJson(json))
            .toList();

    _allcategories = categoriesdemodificateursList;
    _selected = null;
    notifyListeners();
  }

  void deselect() {
    _selected = null;
    notifyListeners();
  }

  void create(CategorieDeModificateur newModificateur) {
    print(newModificateur.nom);
    print(newModificateur.color);
    print(newModificateur.sallesIDS);
    print(newModificateur.affectationMode);
    print(newModificateur.typeSelection);

    _allcategories = [..._allcategories, newModificateur];
    notifyListeners();
  }

  void update(CategorieDeModificateur updated) {
    _allcategories =
        _allcategories.map((cat) {
          return cat.id == updated.id ? updated : cat;
        }).toList();

    _selected = updated;
    notifyListeners();
  }
}

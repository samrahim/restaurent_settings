import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/categorie_de_modificateur.dart';

class CategorieModificateurProvider extends ChangeNotifier {
  bool loadingall = true;
  bool loadingselected = true;

  CategorieDeModificateur createmodificateur = CategorieDeModificateur(
    couleur: '',
    icone: '',
    nom: '',
    obligatoire: true,
    sallesIDS: [],
    typeSelection: optiontypeDeSelection[0],
    modificateurs: [],
    produitsIds: [],
    salleMode: SalleMode.POUR_TOUT,
    produitMode: SalleMode.POUR_TOUT,
  );

  bool _attachemntProductScreen = false;
  bool get attachemntProductScreen => _attachemntProductScreen;
  set attachemntProductScreen(bool value) {
    _attachemntProductScreen = value;
    print('attachemntProductScreen updated to: $value');
    notifyListeners();
  }

  void openattachemtScreen() {
    print('we get called');
    attachemntProductScreen = true;
    notifyListeners();
  }

  final http.Client client;
  List<CategorieDeModificateur> _allcategories = [];
  CategorieDeModificateur? _selected;

  CategorieModificateurProvider({required this.client}) {
    loadAll();
  }

  List<CategorieDeModificateur> get allcategories => _allcategories;
  CategorieDeModificateur? get selectedCategorie => _selected;

  void select(CategorieDeModificateur modificateur) async {
    loadingselected = true;
    _selected = modificateur;
    await Future.delayed(Duration(milliseconds: 300));
    loadingselected = false;
    notifyListeners();
  }

  void loadAll() async {
    loadingall = true;
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
    loadingall = false;
    _selected = null;
    notifyListeners();
  }

  void deselect() {
    _selected = null;
    notifyListeners();
  }

  void create(CategorieDeModificateur createmodificateur) async {
    // final response = await client.post(
    //   Uri.parse("${baseUrl}modificateurs/categories/createOrUpdate"),
    //   body: json.encode(createmodificateur.toJson()),
    //   headers: {
    //     'Content-type': 'application/json',
    //     'Accept': 'application/json',
    //   },
    // );

    // if (response.statusCode == 200) {
    //   Map<String, dynamic> data = json.decode(response.body);
    //   CategorieDeModificateur mod = CategorieDeModificateur.fromJson(data);
    //   _allcategories = [..._allcategories, mod];
    //   notifyListeners();
    // } else {
    //   throw '${response.body}';
    // }
    print(createmodificateur.toJson());
  }

  void update(CategorieDeModificateur updated) async {
    String mo = json.encode(updated.toJson());
    Response response = await http.post(
      Uri.parse('${baseUrl}modificateurs/categories/createOrUpdate'),
      headers: {'Content-Type': 'application/json'},
      body: mo,
    );
    print("response.body ${response.body}");
    final Map<String, dynamic> responseJson = json.decode(response.body);
    if (response.statusCode != 200) {
      final CategorieDeModificateur res = CategorieDeModificateur.fromJson(
        responseJson,
      );
      print(res.nom);
    }
    _allcategories =
        _allcategories.map((e) {
          if (e.id == updated.id) {
            e = updated;
            return e;
          }
          return e;
        }).toList();

    _selected = updated;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent/models/categorie_de_prix_model.dart';

class CategorieDePrixProvider extends ChangeNotifier {
  final http.Client client;
  List<CategorieDePrixModel>? _categories = [];
  CategorieDePrixModel? _selected;

  List<CategorieDePrixModel> get categories => _categories ?? [];
  CategorieDePrixModel? get selected => _selected;
  CategorieDePrixProvider({required this.client}) {
    loadAll();
  }

  void select(CategorieDePrixModel model) {
    _selected = model;
    notifyListeners();
  }

  void clearSelection() {
    _selected = null;
    notifyListeners();
  }

  void create(CategorieDePrixModel model) {
    _categories = [..._categories!, model];
    notifyListeners();
  }

  void update(CategorieDePrixModel updatedModel) {
    _categories =
        _categories!.map((cat) {
          return cat.id == updatedModel.id ? updatedModel : cat;
        }).toList();
    _selected = updatedModel;
    notifyListeners();
  }

  void loadAll() async {
    // final response = await client.get(Uri.parse(baseUrl + '/'));
    // if (response.statusCode == 200) {
    //   List data = json.decode(response.body);
    //   _categories = data.map((e) => CategorieDePrixModel.fromJson(e)).toList();
    //   notifyListeners();
    // } else {
    //   //err section
    // }
    _categories = categoriesPrixList;
    _selected = null;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:restaurent/models/categorie_de_prix_model.dart';

class CategorieDePrixProvider extends ChangeNotifier {
  List<CategorieDePrixModel>? _categories = [];
  CategorieDePrixModel? _selected;

  List<CategorieDePrixModel> get categories => _categories ?? [];
  CategorieDePrixModel? get selected => _selected;
  CategorieDePrixProvider() {
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
    notifyListeners();
  }

  void loadAll() {
    //FIXME: call API
    _categories = categoriesPrixList;
    _selected =
        (_categories != null && _categories!.isNotEmpty)
            ? _categories!.first
            : null;
    notifyListeners();
  }
}

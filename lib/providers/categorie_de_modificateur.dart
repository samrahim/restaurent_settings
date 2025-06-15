import 'package:flutter/material.dart';
import 'package:restaurent/models/categorie_de_modificateur.dart';

class CategorieModificateurProvider extends ChangeNotifier {
  List<CategorieDeModificateur> _allcategories = categoriesdemodificateursList;
  CategorieDeModificateur? _selected;

  List<CategorieDeModificateur> get allcategories => _allcategories;
  CategorieDeModificateur? get selectedCategorie => _selected;

  void select(CategorieDeModificateur modificateur) {
    _selected = modificateur;
    notifyListeners();
  }

  void deselect() {
    _selected = null;
    notifyListeners();
  }

  void create(CategorieDeModificateur newModificateur) {
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

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent/models/taux_tva_model.dart';

class TauxEtTvaProvider extends ChangeNotifier {
  final http.Client client;
  List<TauxTvaModel> _tauxTvas = [];
  TauxTvaModel? _selectedTauxTva;

  TauxEtTvaProvider({required this.client}) {
    loadall();
  }

  void loadall() {
    _tauxTvas = tauxTvaList;
    _selectedTauxTva = tauxTvaList.isNotEmpty ? tauxTvaList.first : null;
  }

  List<TauxTvaModel> get tauxTvas => _tauxTvas;
  TauxTvaModel? get selectedTauxTva => _selectedTauxTva;

  void createTauxTva(double tauxTva, int elementsInclus) {
    final newTaux = TauxTvaModel(
      id: '${_tauxTvas.length + 1}',
      tauxTva: tauxTva,
      elementsInclus: elementsInclus,
    );
    _tauxTvas.add(newTaux);
    _selectedTauxTva = newTaux;
    notifyListeners();
  }

  void updateTauxTva(TauxTvaModel updated) {
    _tauxTvas =
        _tauxTvas.map((t) {
          return t.id == updated.id ? updated : t;
        }).toList();
    _selectedTauxTva = updated;
    notifyListeners();
  }

  void setSelectedTauxTva(TauxTvaModel selected) {
    _selectedTauxTva = selected;
    notifyListeners();
  }
}

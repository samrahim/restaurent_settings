import 'package:flutter/material.dart';
import 'package:restaurent/models/moyen_de_paiement_model.dart';

class MoyenDePaiementProvider extends ChangeNotifier {
  List<MoyenDePaiementModel>? _moyens = [];
  MoyenDePaiementModel? _selected;

  List<MoyenDePaiementModel> get moyens => _moyens ?? [];
  MoyenDePaiementModel? get selected => _selected;

  MoyenDePaiementProvider() {
    getMoyensDePaiement();
  }

  Future<void> getMoyensDePaiement() async {
    _moyens = moyenPaiementList;
    _selected =
        (_moyens != null && _moyens!.isNotEmpty) ? _moyens!.first : null;
    notifyListeners();
  }

  void select(MoyenDePaiementModel moyen) {
    _selected = moyen;
    notifyListeners();
  }

  void update({required MoyenDePaiementModel updated}) {
    int index = _moyens!.indexWhere((e) => e.id == updated.id);
    if (index != -1) {
      _moyens![index] = updated;
      _selected = updated;
      notifyListeners();
    }
  }

  void create({required MoyenDePaiementModel model}) {
    final newModel = model.copyWith(
      id: _moyens == null ? '1' : _moyens!.length.toString(),
    );
    _moyens!.add(newModel);
    _selected = newModel;
    notifyListeners();
  }
}

import 'package:restaurent/models/moyen_de_paiement_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class MoyenDePaiementState {
  final List<MoyenDePaiementModel> moyens;
  final MoyenDePaiementModel? selected;

  const MoyenDePaiementState({required this.moyens, required this.selected});

  MoyenDePaiementState copyWith({
    List<MoyenDePaiementModel>? moyens,
    MoyenDePaiementModel? selected,
  }) {
    return MoyenDePaiementState(
      moyens: moyens ?? this.moyens,
      selected: selected ?? this.selected,
    );
  }
}

class MoyenDePaiementNotifier extends StateNotifier<MoyenDePaiementState> {
  final http.Client client;

  MoyenDePaiementNotifier({required this.client})
    : super(const MoyenDePaiementState(moyens: [], selected: null)) {
    getMoyensDePaiement();
  }

  Future<void> getMoyensDePaiement() async {
    final List<MoyenDePaiementModel> moyens = moyenPaiementList;
    final selected = moyens.isNotEmpty ? moyens.first : null;
    state = state.copyWith(moyens: moyens, selected: selected);
  }

  void select(MoyenDePaiementModel moyen) {
    state = state.copyWith(selected: moyen);
  }

  void update({required MoyenDePaiementModel updated}) {
    final updatedList =
        state.moyens.map((e) {
          return e.id == updated.id ? updated : e;
        }).toList();
    state = state.copyWith(moyens: updatedList, selected: updated);
  }

  void create({required MoyenDePaiementModel model}) {
    final newId = state.moyens.length.toString();
    final newModel = model.copyWith(id: newId);
    final updatedList = [...state.moyens, newModel];
    state = state.copyWith(moyens: updatedList, selected: newModel);
  }
}

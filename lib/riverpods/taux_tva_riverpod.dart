import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/models/taux_tva_model.dart';

class TauxEtTvaState {
  final List<TauxTvaModel> tauxTvas;
  final TauxTvaModel? selected;

  const TauxEtTvaState({required this.tauxTvas, required this.selected});

  TauxEtTvaState copyWith({
    List<TauxTvaModel>? tauxTvas,
    TauxTvaModel? selected,
  }) {
    return TauxEtTvaState(
      tauxTvas: tauxTvas ?? this.tauxTvas,
      selected: selected ?? this.selected,
    );
  }
}

class TauxEtTvaNotifier extends StateNotifier<TauxEtTvaState> {
  TauxEtTvaNotifier()
    : super(
        TauxEtTvaState(
          tauxTvas: tauxTvaList,
          selected: tauxTvaList.isNotEmpty ? tauxTvaList.first : null,
        ),
      );

  void loadAll() {
    state = state.copyWith(
      tauxTvas: tauxTvaList,
      selected: tauxTvaList.isNotEmpty ? tauxTvaList.first : null,
    );
  }

  void createTauxTva(double tauxTva, int elementsInclus) {
    final newTaux = TauxTvaModel(
      id: '${state.tauxTvas.length + 1}',
      tauxTva: tauxTva,
      elementsInclus: elementsInclus,
    );
    final updated = [...state.tauxTvas, newTaux];
    state = state.copyWith(tauxTvas: updated, selected: newTaux);
  }

  void updateTauxTva(TauxTvaModel updatedModel) {
    final updatedList =
        state.tauxTvas
            .map((t) => t.id == updatedModel.id ? updatedModel : t)
            .toList();
    state = state.copyWith(tauxTvas: updatedList, selected: updatedModel);
  }

  void setSelectedTauxTva(TauxTvaModel selected) {
    state = state.copyWith(selected: selected);
  }
}

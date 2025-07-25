import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent/models/categorie_de_prix_model.dart';

class CategorieDePrixState {
  final List<CategorieDePrixModel> categories;
  final CategorieDePrixModel? selected;

  const CategorieDePrixState({
    required this.categories,
    required this.selected,
  });

  CategorieDePrixState copyWith({
    List<CategorieDePrixModel>? categories,
    CategorieDePrixModel? selected,
  }) {
    return CategorieDePrixState(
      categories: categories ?? this.categories,
      selected: selected ?? this.selected,
    );
  }
}

class CategorieDePrixNotifier extends StateNotifier<CategorieDePrixState> {
  final http.Client client;

  CategorieDePrixNotifier({required this.client})
    : super(const CategorieDePrixState(categories: [], selected: null)) {
    loadAll();
  }

  void select(CategorieDePrixModel model) {
    state = state.copyWith(selected: model);
  }

  void clearSelection() {
    state = state.copyWith(selected: null);
  }

  void create(CategorieDePrixModel model) {
    final updatedList = [...state.categories, model];
    state = state.copyWith(categories: updatedList);
  }

  void update(CategorieDePrixModel updatedModel) {
    final updatedList =
        state.categories.map((cat) {
          return cat.id == updatedModel.id ? updatedModel : cat;
        }).toList();

    state = state.copyWith(categories: updatedList, selected: updatedModel);
  }

  void loadAll() async {
    // Replace this with actual API call if needed
    // final response = await client.get(Uri.parse(baseUrl + '/'));
    // if (response.statusCode == 200) {
    //   final List data = json.decode(response.body);
    //   final categories = data.map((e) => CategorieDePrixModel.fromJson(e)).toList();
    //   state = state.copyWith(categories: categories, selected: null);
    // } else {
    //   // handle error
    // }

    state = state.copyWith(categories: categoriesPrixList, selected: null);
  }
}

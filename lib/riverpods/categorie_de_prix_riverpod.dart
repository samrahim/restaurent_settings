import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent/models/categorie_de_prix_model.dart';

class CategorieDePrixState {
  final List<CategorieDePrixModel> categories;
  final CategorieDePrixModel? selected;
  final bool isLoading;
  final bool attachmentProductScreen;

  const CategorieDePrixState({
    required this.categories,
    required this.selected,
    required this.isLoading,
    required this.attachmentProductScreen,
  });

  CategorieDePrixState copyWith({
    List<CategorieDePrixModel>? categories,
    CategorieDePrixModel? selected,
    bool? isLoading,
    bool? attachmentProductScreen,
  }) {
    return CategorieDePrixState(
      categories: categories ?? this.categories,
      selected: selected,
      isLoading: isLoading ?? this.isLoading,
      attachmentProductScreen:
          attachmentProductScreen ?? this.attachmentProductScreen,
    );
  }
}

class CategorieDePrixNotifier extends StateNotifier<CategorieDePrixState> {
  final http.Client client;

  CategorieDePrixNotifier({required this.client})
    : super(
        const CategorieDePrixState(
          categories: [],
          selected: null,
          isLoading: true,
          attachmentProductScreen: false,
        ),
      ) {
    loadAll();
  }

  void select(CategorieDePrixModel model) {
    state = state.copyWith(selected: model);
  }

  void clearSelection() {
    state = state.copyWith(selected: null);
  }

  void create(CategorieDePrixModel model) async {
    print(model.toJson());
    final response = await client.post(
      Uri.parse("http://51.15.211.239:8444/api/categorie-prix"),
      body: json.encode(model.toJson()),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'X-User': 'admin',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      CategorieDePrixModel mod = CategorieDePrixModel.fromJson(data);
      state = state.copyWith(categories: [...state.categories, mod]);
    } else {
      throw response.body;
    }
  }

  void setAttachmentProductScreen(bool value) {
    state = state.copyWith(attachmentProductScreen: value);
  }

  void openAttachmentScreen() {
    setAttachmentProductScreen(true);
  }

  void update(CategorieDePrixModel updatedModel) {
    final updatedList =
        state.categories.map((cat) {
          return cat.id == updatedModel.id ? updatedModel : cat;
        }).toList();

    state = state.copyWith(categories: updatedList, selected: updatedModel);
  }

  void loadAll() async {
    state = state.copyWith(isLoading: true);
    final response = await client.get(
      Uri.parse('http://51.15.211.239:8444/api/categorie-prix'),
    );
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      try {
        final categories =
            data.map((e) => CategorieDePrixModel.fromJson(e)).toList();
        state = state.copyWith(categories: categories, selected: null);

        state = state.copyWith(isLoading: false);
      } catch (e) {
        print(e.toString());
      }
    } else {
      print("errro");
    }
  }
}

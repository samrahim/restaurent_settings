import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent/models/categorie_de_modificateur.dart';
import 'package:restaurent/consts.dart';

class CategorieModificateurState {
  final bool loadingAll;
  final bool loadingSelected;
  final List<CategorieDeModificateur> allCategories;
  final CategorieDeModificateur? selected;
  final bool attachmentProductScreen;
  final CategorieDeModificateur createmodificateur;

  const CategorieModificateurState({
    required this.loadingAll,
    required this.loadingSelected,
    required this.allCategories,
    required this.selected,
    required this.attachmentProductScreen,
    required this.createmodificateur,
  });

  CategorieModificateurState copyWith({
    bool? loadingAll,
    bool? loadingSelected,
    List<CategorieDeModificateur>? allCategories,
    CategorieDeModificateur? selected,
    bool? attachmentProductScreen,
    CategorieDeModificateur? createmodificateur,
  }) {
    return CategorieModificateurState(
      loadingAll: loadingAll ?? this.loadingAll,
      loadingSelected: loadingSelected ?? this.loadingSelected,
      allCategories: allCategories ?? this.allCategories,
      selected: selected ?? this.selected,
      attachmentProductScreen:
          attachmentProductScreen ?? this.attachmentProductScreen,
      createmodificateur: createmodificateur ?? this.createmodificateur,
    );
  }
}

class CategorieModificateurNotifier
    extends StateNotifier<CategorieModificateurState> {
  final http.Client client;

  CategorieModificateurNotifier({required this.client})
    : super(
        CategorieModificateurState(
          loadingAll: true,
          loadingSelected: true,
          allCategories: [],
          selected: null,
          attachmentProductScreen: false,
          createmodificateur: CategorieDeModificateur(
            couleur: '',
            icone: '',
            nom: '',
            obligatoire: true,
            sallesIDS: [],
            typeSelection: TypeDeSelection.SINGLE,
            modificateurs: [],
            produitsIds: [],
            salleMode: AffectationMode.POUR_TOUT,
            produitMode: AffectationMode.POUR_TOUT,
          ),
        ),
      ) {
    loadAll();
  }

  Future<void> loadAll() async {
    state = state.copyWith(loadingAll: true);
    final response = await client.get(
      Uri.parse('${baseUrl}modificateurs/categories'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load categories');
    }

    final List<dynamic> categoriesJson = json.decode(response.body);
    final List<CategorieDeModificateur> categoriesList =
        categoriesJson
            .map((json) => CategorieDeModificateur.fromJson(json))
            .toList();

    state = state.copyWith(
      allCategories: categoriesList,
      selected: null,
      loadingAll: false,
    );
  }

  void select(CategorieDeModificateur modificateur) async {
    state = state.copyWith(loadingSelected: true, selected: modificateur);
    await Future.delayed(const Duration(milliseconds: 300));
    state = state.copyWith(loadingSelected: false);
  }

  void deselect() {
    state = state.copyWith(selected: null);
  }

  void setAttachmentProductScreen(bool value) {
    state = state.copyWith(attachmentProductScreen: value);
  }

  void openAttachmentScreen() {
    setAttachmentProductScreen(true);
  }

  Future<void> create(CategorieDeModificateur newCategorie) async {
    final response = await client.post(
      Uri.parse("${baseUrl}modificateurs/categories/createOrUpdate"),
      body: json.encode(newCategorie.toJson()),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      CategorieDeModificateur mod = CategorieDeModificateur.fromJson(data);
      state = state.copyWith(allCategories: [...state.allCategories, mod]);
    } else {
      throw '${response.body}';
    }
  }

  Future<void> update(CategorieDeModificateur updated) async {
    final response = await client.post(
      Uri.parse('${baseUrl}modificateurs/categories/createOrUpdate'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updated.toJson()),
    );

    final Map<String, dynamic> responseJson = json.decode(response.body);
    if (response.statusCode != 200) {
      final CategorieDeModificateur res = CategorieDeModificateur.fromJson(
        responseJson,
      );
      return;
    } else {
      final updatedList =
          state.allCategories.map((e) {
            return e.id == updated.id ? updated : e;
          }).toList();

      state = state.copyWith(allCategories: updatedList, selected: updated);
    }

    print(hexToColor(updated.couleur));
  }
}

final categorieModificateurProvider = StateNotifierProvider<
  CategorieModificateurNotifier,
  CategorieModificateurState
>((ref) => CategorieModificateurNotifier(client: http.Client()));

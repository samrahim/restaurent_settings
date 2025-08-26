import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/utilisateur_model.dart';

class UtilisateurState {
  final List<UtilisateurModel> utilisateurs;
  final UtilisateurModel? selectedUtilisateur;

  const UtilisateurState({
    required this.utilisateurs,
    required this.selectedUtilisateur,
  });

  UtilisateurState copyWith({
    List<UtilisateurModel>? utilisateurs,
    UtilisateurModel? selectedUtilisateur,
  }) {
    return UtilisateurState(
      utilisateurs: utilisateurs ?? this.utilisateurs,
      selectedUtilisateur: selectedUtilisateur ?? this.selectedUtilisateur,
    );
  }
}

class UtilisateurNotifier extends StateNotifier<UtilisateurState> {
  final http.Client client;

  UtilisateurNotifier({required this.client})
    : super(
        const UtilisateurState(utilisateurs: [], selectedUtilisateur: null),
      ) {
    loadUtilisateurs();
  }

  Future<void> loadUtilisateurs() async {
    final response = await client.get(
      Uri.parse("http://51.15.211.239:8444/api/v1/user"),
    );
    List data = json.decode(response.body);

    final users = data.map((e) => UtilisateurModel.fromJson(e)).toList();
    final selected = users.isNotEmpty ? users.first : null;
    state = state.copyWith(utilisateurs: users, selectedUtilisateur: selected);
  }

  void selectUtilisateur(UtilisateurModel utilisateur) {
    state = state.copyWith(selectedUtilisateur: utilisateur);
  }

  void createUtilisateur({required UtilisateurModel newUser}) async {
    final response = await client.post(
      Uri.parse("${baseUrl}user/save"),
      body: json.encode(newUser.toJson()),
    );
    print(response.body);
    if (response.statusCode == 200) {}

    final updatedList = [...state.utilisateurs, newUser];
    state = state.copyWith(
      utilisateurs: updatedList,
      selectedUtilisateur: newUser,
    );
  }

  void updateUtilisateur(UtilisateurModel updatedUser) {
    final idx = state.utilisateurs.indexWhere((u) => u.id == updatedUser.id);
    if (idx != -1) {
      final updatedList = [...state.utilisateurs];
      updatedList[idx] = updatedUser;
      state = state.copyWith(
        utilisateurs: updatedList,
        selectedUtilisateur:
            state.selectedUtilisateur?.id == updatedUser.id
                ? updatedUser
                : state.selectedUtilisateur,
      );
    }
  }
}

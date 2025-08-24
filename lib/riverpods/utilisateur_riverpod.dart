import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
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
      headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbkBjcm0uY29tIiwiaWF0IjoxNzU1OTU1OTY0LCJleHAiOjE3NTU5ODQ3NjR9.7naVIM0TDnsGy_c2ZhxocVC3bJ_3yBbsVj1-CDuMOle-s5CC9lYQBZYpALGRk9HVT_GJ_ijbEyZMqLEDwDxUSA",
      },
    );
    List data = json.decode(response.body);

    final users = data.map((e) => UtilisateurModel.fromJson(e)).toList();
    final selected = users.isNotEmpty ? users.first : null;
    state = state.copyWith(utilisateurs: users, selectedUtilisateur: selected);
  }

  void selectUtilisateur(UtilisateurModel utilisateur) {
    state = state.copyWith(selectedUtilisateur: utilisateur);
  }

  // void createUtilisateur({
  //   required String groupe,
  //   required String motPasseChiffre,
  //   required String nom,
  //   required String prenom,
  //   required String qrCode,
  //   required String role,
  //   required String? motPasseSchema,
  // }) {
  //   final newUser = UtilisateurModel(
  //     id: DateTime.now().toString(),
  //     nom: nom,
  //     prenom: prenom,
  //     groupe: groupe,
  //     motPasseSchema: motPasseSchema ?? '',
  //     motPasseChiffre: motPasseChiffre,
  //     qrCode: qrCode,
  //     role: role,
  //   );

  //   final updatedList = [...state.utilisateurs, newUser];
  //   state = state.copyWith(
  //     utilisateurs: updatedList,
  //     selectedUtilisateur: newUser,
  //   );
  // }

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

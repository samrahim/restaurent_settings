import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/utilisateur_model.dart';

class UtilisateurState {
  final List<UtilisateurModel> utilisateurs;
  final UtilisateurModel? selectedUtilisateur;
  final String? error;

  const UtilisateurState({
    required this.error,
    required this.utilisateurs,

    required this.selectedUtilisateur,
  });

  UtilisateurState copyWith({
    List<UtilisateurModel>? utilisateurs,
    UtilisateurModel? selectedUtilisateur,

    String? error,
  }) {
    return UtilisateurState(
      error: error ?? this.error,
      utilisateurs: utilisateurs ?? this.utilisateurs,
      selectedUtilisateur: selectedUtilisateur ?? this.selectedUtilisateur,
    );
  }
}

class UtilisateurNotifier extends StateNotifier<UtilisateurState> {
  final http.Client client;

  UtilisateurNotifier({required this.client})
    : super(
        const UtilisateurState(
          utilisateurs: [],
          selectedUtilisateur: null,
          error: "",
        ),
      ) {
    loadUtilisateurs();
  }

  Future<void> loadUtilisateurs() async {
    final response = await client.get(
      Uri.parse("http://51.15.211.239:8444/api/v1/user"),
    );
    List data = json.decode(response.body);

    final users = data.map((e) => UtilisateurModel.fromJson(e)).toList();
    for (var user in users) {
      if (user.firstname == "update firstname") {
        print(user.dateOfBirth);
      }
    }

    final selected = users.isNotEmpty ? users.first : null;
    state = state.copyWith(utilisateurs: users, selectedUtilisateur: selected);
  }

  void selectUtilisateur(UtilisateurModel utilisateur) {
    state = state.copyWith(selectedUtilisateur: utilisateur);
  }

  void createUtilisateur({required UtilisateurModel newUser}) async {
    if (newUser.role == null || newUser.role!.isEmpty) {
      newUser = newUser.copyWith(role: "Autre");
    }

    final response = await client.post(
      Uri.parse("${baseUrl}user/save"),

      body: json.encode(newUser.toJson()),
    );
    print(response.body);
    if (response.statusCode == 200) {
      loadUtilisateurs();
    } else {
      final Map<String, dynamic> mp = json.decode(response.body);
      if (mp["message"] == "Error : Utilisateur existe déjà!") {
        state = state.copyWith(error: "Utilisateur existe déjà!");
      }
    }
  }

  Future<void> updateUtilisateur(UtilisateurModel updatedUser) async {
    final response = await client.put(
      Uri.parse("${baseUrl}user/${updatedUser.id}"),
      body: json.encode(updatedUser.toJson()),
    );
    Map body = json.decode(response.body);

    if (response.statusCode == 200) {
      loadUtilisateurs();
    } else {
      state = state.copyWith(
        error: "err",
        selectedUtilisateur: state.utilisateurs[0],
      );
    }
  }
}

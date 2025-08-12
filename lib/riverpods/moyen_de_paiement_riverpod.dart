import 'dart:convert';

import 'package:restaurent/models/moyen_de_paiement_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class MoyenDePaiementState {
  final List<MoyenDePaiementModel> moyens;
  final MoyenDePaiementModel? selected;
  final bool? isloading;

  const MoyenDePaiementState({
    required this.moyens,
    required this.selected,
    required this.isloading,
  });

  MoyenDePaiementState copyWith({
    List<MoyenDePaiementModel>? moyens,
    MoyenDePaiementModel? selected,
    bool? isloading,
  }) {
    return MoyenDePaiementState(
      isloading: isloading ?? this.isloading,
      moyens: moyens ?? this.moyens,
      selected: selected ?? this.selected,
    );
  }
}

class MoyenDePaiementNotifier extends StateNotifier<MoyenDePaiementState> {
  final http.Client client;

  MoyenDePaiementNotifier({required this.client})
    : super(
        const MoyenDePaiementState(moyens: [], selected: null, isloading: true),
      ) {
    getMoyensDePaiement();
  }

  Future<void> getMoyensDePaiement() async {
    state.copyWith(isloading: true);
    final response = await client.get(
      Uri.parse("http://51.15.211.239:8444/api/moyens-paiement"),
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      List<MoyenDePaiementModel> moyenDePaiement =
          data.map((e) => MoyenDePaiementModel.fromJson(e)).toList();

      final selected =
          moyenDePaiement.isNotEmpty ? moyenDePaiement.first : null;
      state = state.copyWith(
        moyens: moyenDePaiement,
        selected: selected,
        isloading: false,
      );
    }
  }

  void select(MoyenDePaiementModel moyen) {
    state = state.copyWith(selected: moyen);
  }

  Future<void> update({required MoyenDePaiementModel updatedModel}) async {
    print("we called ${updatedModel.toJson()}");
    print('updated id ${updatedModel.id}');
    try {
      final response = await client.put(
        Uri.parse(
          "http://51.15.211.239:8444/api/moyens-paiement/${updatedModel.id}",
        ),
        body: json.encode(updatedModel.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        MoyenDePaiementModel updated = MoyenDePaiementModel.fromJson(data);
        print("updated response is ${updated.toJson()}");
        final updatedList =
            state.moyens.map((e) {
              return e.id == updated.id ? updated : e;
            }).toList();
        state = state.copyWith(moyens: updatedList, selected: updated);
      }
    } catch (e) {
      print(e);
      print(e);
      throw Exception();
    }
  }

  Future<void> create({required MoyenDePaiementModel model}) async {
    try {
      final response = await client.post(
        Uri.parse("http://51.15.211.239:8444/api/moyens-paiement"),
        body: json.encode(model.toJson()),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );

      Map<String, dynamic> data = json.decode(response.body);
      MoyenDePaiementModel newModel = MoyenDePaiementModel.fromJson(data);

      final updatedList = [...state.moyens, newModel];
      state = state.copyWith(moyens: updatedList);
    } catch (e) {
      print(e);
    }
  }
}

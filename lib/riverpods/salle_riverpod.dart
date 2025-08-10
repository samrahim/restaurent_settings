import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/salle_model.dart';

class SalleState {
  final List<SalleModel> salles;

  SalleState({required this.salles});

  SalleState copyWith({List<SalleModel>? salles}) {
    return SalleState(salles: salles ?? this.salles);
  }
}

class SalleNotifier extends StateNotifier<SalleState> {
  final http.Client client;

  SalleNotifier({required this.client}) : super(SalleState(salles: [])) {
    getSalles();
  }

  Future<void> getSalles() async {
    try {
      final response = await client.get(
        Uri.parse(
          '${baseUrl}dashboard/seller/shop-sections?page=1&perPage=50&lang=en',
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        state = state.copyWith(
          salles: data.map((e) => SalleModel.fromJson(e)).toList(),
        );
      }
    } catch (e) {
      throw 'Error fetching salles: $e';
    }
  }

  SalleModel? getSalleById(int id) {
    for (SalleModel salle in state.salles) {
      if (salle.id == id) {
        return salle;
      }
    }
    return null;
  }
}

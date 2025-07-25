import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/salle_model.dart';

class SalleNotifier extends StateNotifier<List<SalleModel>> {
  final http.Client client;

  SalleNotifier({required this.client}) : super([]) {
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
        state = data.map((e) => SalleModel.fromJson(e)).toList();
      }
    } catch (e) {
      throw 'Error fetching salles: $e';
    }
  }

  List<SalleModel> getSalleById(List<int> ids) {
    print('i called $ids');
    return state.where((salle) => ids.contains(salle.id)).toList();
  }
}

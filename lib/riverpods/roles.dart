import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/roles.dart';

class RoleState {
  final List<Role>? roles;
  final bool? isLoading;
  RoleState({required this.roles, required this.isLoading});
  RoleState copyWith({List<Role>? roles, bool? isLoading}) {
    return RoleState(
      roles: roles ?? this.roles,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class RolesNotifier extends StateNotifier<RoleState> {
  final http.Client client;

  RolesNotifier({required this.client})
    : super(RoleState(roles: [], isLoading: true)) {
    getRoles();
  }

  Future<void> getRoles() async {
    state = state.copyWith(isLoading: true);
    final response = await client.get(Uri.parse("${baseUrl}privilege"));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      List<Role> roles = data.map((e) => Role.fromJSon(e)).toList();
      state = state.copyWith(roles: roles, isLoading: false);
    } else {
      throw Exception(response.body);
    }
  }
}

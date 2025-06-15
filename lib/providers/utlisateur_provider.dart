import 'package:flutter/material.dart';
import 'package:restaurent/models/utilisateur_model.dart';

// Nouveau Provider pour remplacer UtilisateurBloc
class UtilisateurProvider with ChangeNotifier {
  List<UtilisateurModel>? _utilisateurs;
  UtilisateurModel? _selectedUtilisateur;

  List<UtilisateurModel>? get utilisateurs => _utilisateurs;
  UtilisateurModel? get selectedUtilisateur => _selectedUtilisateur;
  UtilisateurProvider() {
    loadUtilisateurs();
  }
  void loadUtilisateurs() {
    //FIXME: call API
    _utilisateurs = utilisateurList;
    _selectedUtilisateur =
        (_utilisateurs != null && _utilisateurs!.isNotEmpty)
            ? _utilisateurs!.first
            : null;
    notifyListeners();
  }

  void selectUtilisateur(UtilisateurModel utilisateur) {
    _selectedUtilisateur = utilisateur;
    notifyListeners();
  }

  void createUtilisateur({
    required String groupe,
    required String motPasseChiffre,
    required String nom,
    required String prenom,
    required String qrCode,
    required String role,
    required String motPasseSchema,
  }) {
    final newUser = UtilisateurModel(
      id: DateTime.now().toString(),
      nom: nom,
      prenom: prenom,
      groupe: groupe,
      motPasseSchema: motPasseSchema,
      motPasseChiffre: motPasseChiffre,
      qrCode: qrCode,
      role: role,
    );

    _utilisateurs = [...?_utilisateurs, newUser];
    notifyListeners();
  }

  void updateUtilisateur(UtilisateurModel updatedUser) {
    final index =
        _utilisateurs?.indexWhere((u) => u.id == updatedUser.id) ?? -1;
    if (index != -1) {
      _utilisateurs = [...?_utilisateurs?..[index] = updatedUser];
      if (_selectedUtilisateur?.id == updatedUser.id) {
        _selectedUtilisateur = updatedUser;
      }
      notifyListeners();
    }
  }
}

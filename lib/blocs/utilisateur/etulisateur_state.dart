part of 'etulisateur_bloc.dart';

sealed class UtilisateurState extends Equatable {}

final class UtilisateurInitial extends UtilisateurState {
  final List<UtilisateurModel>? utilisateurs;
  final UtilisateurModel? selectedEtulisateur;
  UtilisateurInitial({required this.utilisateurs, this.selectedEtulisateur});
  @override
  List<Object> get props => [utilisateurs ?? [], selectedEtulisateur ?? ""];
  UtilisateurInitial copyWith({
    List<UtilisateurModel>? utilisateursList,
    UtilisateurModel? selectedUtilisateurItem,
  }) {
    return UtilisateurInitial(
      utilisateurs: utilisateursList ?? utilisateurs,
      selectedEtulisateur: selectedUtilisateurItem ?? selectedEtulisateur,
    );
  }
}

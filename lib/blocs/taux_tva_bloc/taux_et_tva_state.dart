part of 'taux_et_tva_bloc.dart';

sealed class TauxEtTvaState extends Equatable {}

final class TauxEtTvaInitial extends TauxEtTvaState {
  final List<TauxTvaModel>? tauxTvas;
  final TauxTvaModel? selectedTauxTva;
  TauxEtTvaInitial({required this.tauxTvas, required this.selectedTauxTva});
  @override
  List<Object> get props => [tauxTvas ?? [], selectedTauxTva ?? ""];
  TauxEtTvaInitial copyWith({
    List<TauxTvaModel>? tauxTvas,
    TauxTvaModel? selectedTauxTva,
  }) {
    return TauxEtTvaInitial(
      tauxTvas: tauxTvas ?? this.tauxTvas,
      selectedTauxTva: selectedTauxTva ?? this.selectedTauxTva,
    );
  }
}

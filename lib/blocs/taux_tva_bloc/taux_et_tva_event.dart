part of 'taux_et_tva_bloc.dart';

sealed class TauxEtTvaEvent extends Equatable {}

class CreatTauxTva extends TauxEtTvaEvent {
  final double tauxTva;
  final int elementsInclus;
  CreatTauxTva({required this.tauxTva, required this.elementsInclus});

  @override
  List<Object?> get props => [tauxTva, elementsInclus];
}

class UpdateTauxTva extends TauxEtTvaEvent {
  final TauxTvaModel tauxTvaModel;
  UpdateTauxTva({required this.tauxTvaModel});

  @override
  List<Object?> get props => [tauxTvaModel];
}

class GetTauxTvas extends TauxEtTvaEvent {
  final List<TauxTvaModel> tauxTvas;

  GetTauxTvas({required this.tauxTvas});

  @override
  List<Object?> get props => [tauxTvas];
}

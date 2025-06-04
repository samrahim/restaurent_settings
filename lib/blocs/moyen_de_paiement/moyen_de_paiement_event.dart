part of 'moyen_de_paiement_bloc.dart';

sealed class MoyenDePaiementEvent extends Equatable {
  const MoyenDePaiementEvent();

  @override
  List<Object> get props => [];
}

class SelectMoyenDePaiement extends MoyenDePaiementEvent {
  final MoyenDePaiementModel moyenDePaiement;

  const SelectMoyenDePaiement({required this.moyenDePaiement});

  @override
  List<Object> get props => [moyenDePaiement];
}

class UpdateMoyenDePaiementEvent extends MoyenDePaiementEvent {
  final MoyenDePaiementModel moyenDePaiement;

  const UpdateMoyenDePaiementEvent({required this.moyenDePaiement});

  @override
  List<Object> get props => [moyenDePaiement];
}

class CreateMoyenDePaiementEvent extends MoyenDePaiementEvent {
  final String moyenDePaiementName;

  const CreateMoyenDePaiementEvent({required this.moyenDePaiementName});

  @override
  List<Object> get props => [moyenDePaiementName];
}

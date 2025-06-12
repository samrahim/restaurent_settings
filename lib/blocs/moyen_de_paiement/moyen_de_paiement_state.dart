part of 'moyen_de_paiement_bloc.dart';

sealed class MoyenDePaiementState extends Equatable {
  const MoyenDePaiementState();

  @override
  List<Object> get props => [];
}

class MoyenDePaiementInitial extends MoyenDePaiementState {
  final List<MoyenDePaiementModel> moyenDePaiement;
  final MoyenDePaiementModel selectedModel;
  const MoyenDePaiementInitial({
    required this.moyenDePaiement,
    required this.selectedModel,
  });

  @override
  List<Object> get props => [moyenDePaiement, selectedModel];

  MoyenDePaiementInitial copyWith({
    List<MoyenDePaiementModel>? moyenDePaiement,
    MoyenDePaiementModel? selectedModel,
  }) {
    return MoyenDePaiementInitial(
      moyenDePaiement: moyenDePaiement ?? this.moyenDePaiement,
      selectedModel: selectedModel ?? this.selectedModel,
    );
  }
}

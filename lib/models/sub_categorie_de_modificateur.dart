import 'package:equatable/equatable.dart';
import 'package:restaurent/models/taux_tva_model.dart';

class SubCategorieDeModificateur extends Equatable {
  final String id;

  final String nom;
  final double prix;
  final TauxTvaModel tvaModel;

  const SubCategorieDeModificateur({
    required this.id,
    required this.nom,
    required this.prix,
    required this.tvaModel,
  });

  @override
  List<Object?> get props => [id, nom, prix, tvaModel];
  SubCategorieDeModificateur copyWith({
    String? id,
    String? nom,
    double? prix,
    TauxTvaModel? tvaModel,
  }) {
    return SubCategorieDeModificateur(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prix: prix ?? this.prix,
      tvaModel: tvaModel ?? this.tvaModel,
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:restaurent/models/taux_tva_model.dart';

class SubCategorieDeModificateur extends Equatable {
  final String id;
  final int categorieId;
  final String nom;
  final double prix;
  final TauxTvaModel tvaModel;

  const SubCategorieDeModificateur({
    required this.categorieId,
    required this.id,
    required this.nom,
    required this.prix,
    required this.tvaModel,
  });

  @override
  List<Object?> get props => [id, nom, prix, tvaModel, categorieId];
  SubCategorieDeModificateur copyWith({
    String? id,
    int? categorieId,
    String? nom,
    double? prix,
  }) {
    return SubCategorieDeModificateur(
      id: id ?? this.id,
      categorieId: categorieId ?? this.categorieId,
      nom: nom ?? this.nom,
      prix: prix ?? this.prix,
      tvaModel: tvaModel,
    );
  }
}

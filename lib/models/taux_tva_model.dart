import 'package:equatable/equatable.dart';

class TauxTvaModel extends Equatable {
  final String id;
  final double tauxTva;
  final int elementsInclus;

  const TauxTvaModel({
    required this.tauxTva,
    required this.elementsInclus,
    required this.id,
  });

  @override
  List<Object?> get props => [tauxTva, elementsInclus];

  TauxTvaModel copyWith({double? tauxTva, int? elementsInclus, String? id}) {
    return TauxTvaModel(
      id: id ?? this.id,
      tauxTva: tauxTva ?? this.tauxTva,
      elementsInclus: elementsInclus ?? this.elementsInclus,
    );
  }
}

List<TauxTvaModel> tauxTvaList = [
  TauxTvaModel(id: '1', tauxTva: 19.6, elementsInclus: 1),
  TauxTvaModel(id: '2', tauxTva: 10, elementsInclus: 2),
  TauxTvaModel(id: '3', tauxTva: 5.5, elementsInclus: 3),
  TauxTvaModel(id: '4', tauxTva: 2.1, elementsInclus: 4),
];

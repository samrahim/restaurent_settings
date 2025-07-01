import 'package:flutter/material.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/salle_model.dart';

class SalleIdsPicker extends StatelessWidget {
  final List<SalleModel> salles;
  final List<int> selectedSalleIds;
  final Function(List<int>) onSelectionChanged;

  const SalleIdsPicker({
    super.key,
    required this.salles,
    required this.selectedSalleIds,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Disponible dans les salles'),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: salles.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final salle = salles[i];
                final id = salle.id;
                final nom = salle.nom;
                final selected = selectedSalleIds.contains(id);
                return ChoiceChip(
                  label: Text(nom),
                  selected: selected,
                  selectedColor: AppColors.indingo200,
                  onSelected: (sel) {
                    if (salle.nom == 'Toutes') {
                      final updatedSalleIds = sel ? [id] : [];
                      onSelectionChanged(updatedSalleIds as List<int>);
                    } else {
                      final updatedSalleIds =
                          sel
                              ? [
                                ...selectedSalleIds.where(
                                  (e) =>
                                      e !=
                                      salles
                                          .firstWhere((s) => s.nom == 'Toutes')
                                          .id,
                                ),
                                id,
                              ]
                              : selectedSalleIds.where((e) => e != id).toList();
                      onSelectionChanged(updatedSalleIds);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/screens/reglage_screen.dart';

class ProductSelectionScreen extends ConsumerWidget {
  final List<String> selectedIds;
  final Function(List<String>) onSelectionChanged;
  final bool isForCreate;
  final Function(AffectationMode) onModeChanged;
  final VoidCallback onBack;

  ProductSelectionScreen({
    super.key,
    required this.selectedIds,
    required this.onSelectionChanged,
    required this.isForCreate,
    required this.onModeChanged,
    required this.onBack,
  });
  AffectationMode mode = AffectationMode.POUR_SEULEMENT;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productRiverpod);
    final debouncer = Debouncer();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
              Expanded(
                flex: 3,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Rechercher un produit...',
                    prefixIcon: const Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onChanged: (value) {
                    debouncer.debounce(
                      duration: const Duration(milliseconds: 200),
                      onDebounce: () {
                        ref.read(productRiverpod.notifier).searchProds(value);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<AffectationMode>(
                  value: mode,
                  decoration: const InputDecoration(border: InputBorder.none),
                  items:
                      isForCreate
                          ? AffectationMode.values
                              .where(
                                (e) =>
                                    e !=
                                    AffectationMode.AJOUTER_A_LIST_EXSISTANTE,
                              )
                              .map(
                                (v) => DropdownMenuItem(
                                  value: v,
                                  child: Text(v.name.replaceAll("_", " ")),
                                ),
                              )
                              .toList()
                          : AffectationMode.values
                              .map(
                                (v) => DropdownMenuItem(
                                  value: v,
                                  child: Text(v.name.replaceAll("_", " ")),
                                ),
                              )
                              .toList(),
                  onChanged: (value) {
                    if (value != null) onModeChanged(value);
                  },
                ),
              ),
            ],
          ),
        ),

        // --- Product list ---
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount:
                productState.searchResults.isNotEmpty
                    ? productState.searchResults.length
                    : productState.prod.length,
            itemBuilder: (context, index) {
              final produit =
                  productState.searchResults.isNotEmpty
                      ? productState.searchResults[index]
                      : productState.prod[index];
              final isSelected = selectedIds.contains(produit.id);

              return ListTile(
                tileColor: isSelected ? AppColors.indingo200 : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isSelected ? Colors.blue[200]! : Colors.grey[200]!,
                  ),
                ),
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: produit.color ?? Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.restaurant, color: Colors.white),
                ),
                title: Text(produit.name ?? ''),
                subtitle: Text(
                  'Prix: ${produit.pricebuy?.toStringAsFixed(2) ?? '0.00'} €',
                ),
                trailing: Icon(
                  isSelected ? Icons.check : Icons.add,
                  color: isSelected ? Colors.white : Colors.grey[600],
                ),
                onTap: () {
                  final updatedList = List<String>.from(selectedIds);
                  if (isSelected) {
                    updatedList.remove(produit.id);
                  } else {
                    updatedList.add(produit.id!);
                  }
                  onSelectionChanged(updatedList);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

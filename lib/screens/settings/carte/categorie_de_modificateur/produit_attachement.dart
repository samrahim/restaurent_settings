import 'package:flutter/material.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/produits_model.dart';
import 'package:restaurent/riverpods/drawer_riverpod/drawer_state.dart';
import 'package:restaurent/screens/reglage_screen.dart';

class ProduitAttachement extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final StateNotifierProvider<dynamic, dynamic> provider;
  const ProduitAttachement({
    super.key,
    required this.scaffoldKey,
    required this.provider,
  });

  @override
  ConsumerState<ProduitAttachement> createState() => _ProduitAttachementState();
}

class _ProduitAttachementState extends ConsumerState<ProduitAttachement> {
  final Debouncer _debouncer = Debouncer();

  @override
  void dispose() {
    _debouncer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(widget.provider.notifier);

    final productState = ref.watch(productRiverpod);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: const Text(
          'Sélectionner les Produits',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            notifier.setAttachmentProductScreen(false);
            widget.scaffoldKey.currentState?.openEndDrawer();
          },
        ),
        actions: [],
      ),
      body: Consumer(
        builder: (context, drawerPro, _) {
          final state = ref.watch(drawerRiverpod);

          if (state is DrawerCreateCategorieDeModificateur) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Rechercher un produit...',
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) {
                              _debouncer.debounce(
                                duration: const Duration(milliseconds: 200),
                                onDebounce: () {
                                  ref
                                      .read(productRiverpod.notifier)
                                      .searchProds(value);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade400),
                            color: Colors.grey[50],
                          ),
                          child: DropdownButtonFormField<AffectationMode>(
                            value: state.modificateur.produitMode,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey[600],
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                            items:
                                AffectationMode.values
                                    .where(
                                      (e) =>
                                          e !=
                                          AffectationMode
                                              .AJOUTER_A_LIST_EXSISTANTE,
                                    )
                                    .map(
                                      (v) => DropdownMenuItem(
                                        value: v,
                                        child: Text(
                                          v.name.replaceAll("_", " "),
                                          style: AppTextStyle.indingosubHeading,
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (AffectationMode? value) {
                              if (value != null) {
                                final updated = state.modificateur.copyWith(
                                  produitMode: value,
                                );
                                final container = ProviderScope.containerOf(
                                  context,
                                );
                                container
                                    .read(drawerRiverpod.notifier)
                                    .openCreateCategorieDeModificateur(updated);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount:
                            productState.searchResults.isNotEmpty
                                ? productState.searchResults.length
                                : productState.prod.length,
                        itemBuilder: (context, index) {
                          ProduitsModel produit =
                              productState.searchResults.isNotEmpty
                                  ? productState.searchResults[index]
                                  : productState.prod[index];

                          final isSelected =
                              state.modificateur.produitsIds != null &&
                              state.modificateur.produitsIds!.contains(
                                produit.id,
                              );

                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? AppColors.indingo200!
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? Colors.blue[200]!
                                        : Colors.grey[200]!,
                                width: 1,
                              ),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: produit.color ?? Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.restaurant,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              title: Text(
                                produit.name ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                  color:
                                      isSelected
                                          ? Colors.blue[700]
                                          : Colors.black87,
                                ),
                              ),
                              subtitle: Text(
                                'Prix: ${produit.pricebuy?.toStringAsFixed(2) ?? '0.00'} €',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              trailing:
                                  isSelected
                                      ? Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.blue[500],
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      )
                                      : Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.grey[600],
                                          size: 16,
                                        ),
                                      ),
                              onTap: () {
                                final produitsIds =
                                    state.modificateur.produitsIds;
                                if (produitsIds != null &&
                                    produitsIds.contains(produit.id)) {
                                  final updatedIds =
                                      produitsIds
                                          .where((e) => e != produit.id)
                                          .toList();
                                  final updated = state.modificateur.copyWith(
                                    produitsIds: updatedIds,
                                  );
                                  final container = ProviderScope.containerOf(
                                    context,
                                  );
                                  container
                                      .read(drawerRiverpod.notifier)
                                      .openCreateCategorieDeModificateur(
                                        updated,
                                      );
                                } else if (produitsIds != null &&
                                    !produitsIds.contains(produit.id)) {
                                  final updatedIds = List<String>.from(
                                    produitsIds,
                                  )..add(produit.id!);
                                  final updated = state.modificateur.copyWith(
                                    produitsIds: updatedIds,
                                  );

                                  final container = ProviderScope.containerOf(
                                    context,
                                  );
                                  container
                                      .read(drawerRiverpod.notifier)
                                      .openCreateCategorieDeModificateur(
                                        updated,
                                      );
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is DrawerCreateCategoriePrix) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Rechercher un produit...',
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) {
                              _debouncer.debounce(
                                duration: const Duration(milliseconds: 200),
                                onDebounce: () {
                                  ref
                                      .read(productRiverpod.notifier)
                                      .searchProds(value);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade400),
                            color: Colors.grey[50],
                          ),
                          child: DropdownButtonFormField<AffectationMode>(
                            // value: state.model.po,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey[600],
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                            items:
                                AffectationMode.values
                                    .where(
                                      (e) =>
                                          e !=
                                          AffectationMode
                                              .AJOUTER_A_LIST_EXSISTANTE,
                                    )
                                    .map(
                                      (v) => DropdownMenuItem(
                                        value: v,
                                        child: Text(
                                          v.name.replaceAll("_", " "),
                                          style: AppTextStyle.indingosubHeading,
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (AffectationMode? value) {
                              if (value != null) {
                                // final updated = state.model.copyWith(
                                //   produitMode: value,
                                // );
                                // final container = ProviderScope.containerOf(
                                //   context,
                                // );
                                // container
                                //     .read(drawerRiverpod.notifier)
                                //     .openCreateCategorieDeModificateur(updated);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount:
                            productState.searchResults.isNotEmpty
                                ? productState.searchResults.length
                                : productState.prod.length,
                        itemBuilder: (context, index) {
                          ProduitsModel produit =
                              productState.searchResults.isNotEmpty
                                  ? productState.searchResults[index]
                                  : productState.prod[index];

                          final isSelected =
                              state.model.produitsIds != null &&
                              state.model.produitsIds!.contains(produit.id);

                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? AppColors.indingo200!
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? Colors.blue[200]!
                                        : Colors.grey[200]!,
                                width: 1,
                              ),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: produit.color ?? Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.restaurant,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              title: Text(
                                produit.name ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                  color:
                                      isSelected
                                          ? Colors.blue[700]
                                          : Colors.black87,
                                ),
                              ),
                              subtitle: Text(
                                'Prix: ${produit.pricebuy?.toStringAsFixed(2) ?? '0.00'} €',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              trailing:
                                  isSelected
                                      ? Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.blue[500],
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      )
                                      : Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.grey[600],
                                          size: 16,
                                        ),
                                      ),
                              onTap: () {
                                final produitsIds = state.model.produitsIds;
                                if (produitsIds != null &&
                                    produitsIds.contains(produit.id)) {
                                  final updatedIds =
                                      produitsIds
                                          .where((e) => e != produit.id)
                                          .toList();
                                  final updated = state.model.copyWith(
                                    produitsIds: updatedIds,
                                  );
                                  final container = ProviderScope.containerOf(
                                    context,
                                  );
                                  container
                                      .read(drawerRiverpod.notifier)
                                      .openCreateCategoriePrixDrawer(updated);
                                } else if (produitsIds != null &&
                                    !produitsIds.contains(produit.id)) {
                                  final updatedIds = List<String>.from(
                                    produitsIds,
                                  )..add(produit.id!);
                                  final updated = state.model.copyWith(
                                    produitsIds: updatedIds,
                                  );

                                  final container = ProviderScope.containerOf(
                                    context,
                                  );
                                  container
                                      .read(drawerRiverpod.notifier)
                                      .openCreateCategoriePrixDrawer(updated);
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

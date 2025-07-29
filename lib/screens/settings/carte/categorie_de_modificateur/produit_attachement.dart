import 'package:flutter/material.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:provider/provider.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/produits_model.dart';
import 'package:restaurent/providers/providers.dart';

class ProduitAttachement extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ProduitAttachement({super.key, required this.scaffoldKey});

  @override
  State<ProduitAttachement> createState() => _ProduitAttachementState();
}

class _ProduitAttachementState extends State<ProduitAttachement> {
  final Debouncer _debouncer = Debouncer();

  @override
  void dispose() {
    _debouncer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Produits'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<CategorieModificateurProvider>(context, listen: false)
                .attachemntProductScreen = false;
            widget.scaffoldKey.currentState?.openEndDrawer();
          },
        ),
        actions: [],
      ),
      body: Consumer<DrawerProvider>(
        builder: (context, drawerPro, _) {
          final state = drawerPro.state;
          if (state is DrawerCreateCategorieDeModificateur) {
            return Column(
              children: [
                DropdownButtonFormField<AffectationMode>(
                  value: state.modificateur.produitMode,
                  decoration: const InputDecoration(
                    labelText: 'Affectation mode',
                    border: InputBorder.none,
                  ),
                  items:
                      AffectationMode.values
                          .where(
                            (e) =>
                                e != AffectationMode.AJOUTER_A_LIST_EXSISTANTE,
                          )
                          .map(
                            (v) => DropdownMenuItem(
                              value: v,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  v.name.replaceAll("_", " "),
                                  style: AppTextStyle.indingosubHeading,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (AffectationMode? value) {
                    if (value != null) {
                      final updated = state.modificateur.copyWith(
                        produitMode: value,
                      );
                      context
                          .read<DrawerProvider>()
                          .openCreateCategorieDeModificateur(updated);
                    }
                  },
                ),
                TextField(
                  onChanged: (value) {
                    _debouncer.debounce(
                      duration: const Duration(milliseconds: 400),
                      onDebounce: () {
                        productProvider.searchProds(value);
                      },
                    );
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        productProvider.searchResults.isNotEmpty
                            ? productProvider.searchResults.length
                            : productProvider.prod.length,
                    itemBuilder: (context, index) {
                      ProduitsModel produit =
                          productProvider.searchResults.isNotEmpty
                              ? productProvider.searchResults[index]
                              : productProvider.prod[index];

                      return ListTile(
                        title: Text(produit.name ?? ''),
                        trailing: const Icon(Icons.check, color: Colors.green),
                        onTap: () {
                          final produitsIds = state.modificateur.produitsIds;
                          if (produitsIds != null &&
                              produitsIds.contains(produit.id)) {
                            final updatedIds =
                                produitsIds
                                    .where((e) => e != produit.id)
                                    .toList();
                            state.modificateur.copyWith(
                              produitsIds: updatedIds,
                            );
                          } else if (produitsIds != null &&
                              !produitsIds.contains(produit.id)) {
                            produitsIds.add(produit.id!);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}

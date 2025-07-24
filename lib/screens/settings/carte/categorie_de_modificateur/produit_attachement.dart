import 'package:flutter/material.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:provider/provider.dart';
import 'package:restaurent/models/produits_model.dart';
import 'package:restaurent/providers/providers.dart';

class ProduitAttachement extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  ProduitAttachement({super.key, required this.scaffoldKey});

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
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Done', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              print(productProvider.searchResults);
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
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/produits_model.dart';
import 'package:restaurent/riverpods/drawer_riverpod/drawer_state.dart';
import 'package:restaurent/screens/reglage_screen.dart';
import 'package:restaurent/widgets/update_prod_ui.dart';

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
            return ProductSelectionScreen(
              selectedIds: state.modificateur.produitsIds ?? [],
              isForCreate: true,
              onSelectionChanged: (ids) {
                final updated = state.modificateur.copyWith(produitsIds: ids);
                ref
                    .read(drawerRiverpod.notifier)
                    .openCreateCategorieDeModificateur(updated);
              },
              onModeChanged: (mode) {
                final updated = state.modificateur.copyWith(produitMode: mode);
                ref
                    .read(drawerRiverpod.notifier)
                    .openCreateCategorieDeModificateur(updated);
              },
              onBack: () {
                notifier.setAttachmentProductScreen(false);
                widget.scaffoldKey.currentState?.openEndDrawer();
              },
            );
          } else if (state is DrawerCreateCategoriePrix) {
            return ProductSelectionScreen(
              selectedIds: state.model.produitsIds ?? [],
              isForCreate: true,
              onSelectionChanged: (ids) {
                final updated = state.model.copyWith(produitsIds: ids);
                ref
                    .read(drawerRiverpod.notifier)
                    .updateCreateCategoriePrixModel(updated);
              },
              onModeChanged: (mode) {
                final updated = state.model.copyWith(produitMode: mode);
                ref
                    .read(drawerRiverpod.notifier)
                    .updateCreateCategoriePrixModel(updated);
              },
              onBack: () {
                notifier.setAttachmentProductScreen(false);
                widget.scaffoldKey.currentState?.openEndDrawer();
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

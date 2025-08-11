import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/models.dart';
import 'package:restaurent/riverpods/drawer_riverpod/drawer_state.dart';
import 'package:restaurent/screens/reglage_screen.dart';
import 'package:restaurent/widgets/widgets.dart';

class ModificateurDetails extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ModificateurDetails({required this.scaffoldKey, super.key});

  @override
  ConsumerState<ModificateurDetails> createState() =>
      _ModificateurDetailsState();
}

class _ModificateurDetailsState extends ConsumerState<ModificateurDetails> {
  AffectationMode mode = AffectationMode.AJOUTER_A_LIST_EXSISTANTE;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(tempSelectedIdsProvider.notifier).state = List.from(
        ref.read(categorieModificateurRiverpod).selected?.produitsIds ?? [],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final categorieModificateurState = ref.watch(categorieModificateurRiverpod);
    final categorieModificateurNotifier = ref.read(
      categorieModificateurRiverpod.notifier,
    );
    final drawerNotifier = ref.read(drawerRiverpod.notifier);
    final drawerState = ref.watch(drawerRiverpod);
    final modificateur = categorieModificateurState.selected;
    final productState = ref.watch(productRiverpod);

    final tempSelected = ref.watch(tempSelectedIdsProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            categorieModificateurNotifier.deselect();
          },
        ),

        centerTitle: true,
        title: Text(
          modificateur?.nom ?? "",
          style: AppTextStyle.largeindingotext,
        ),
      ),
      body:
          modificateur != null &&
                  (drawerState is! UpdateProdsScreenModificateur)
              ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Card(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'CATÉGORIE DE MODIFICATEURS',
                                    style: AppTextStyle.greysubHeading,
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              color: Colors.grey.shade400,
                              child: ListTile(
                                title: Text(
                                  'Informations générales',
                                  style: AppTextStyle.indingoHeading,
                                ),
                                trailing: const Icon(Icons.chevron_right),
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'MODIFICATEURS / SUPPLÉMENTS',
                                    style: AppTextStyle.greysubHeading,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      final container =
                                          ProviderScope.containerOf(context);
                                      container
                                          .read(drawerRiverpod.notifier)
                                          .openCreateSubCategorieDeModificateur(
                                            modificateur,
                                          );
                                      widget.scaffoldKey.currentState!
                                          .openDrawer();
                                    },
                                    icon: Icon(Icons.add, color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: modificateur.modificateurs.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      buildModifierTile(
                                        modificateur.modificateurs[index].nom,
                                      ),
                                      if (index !=
                                          modificateur.modificateurs.length - 1)
                                        const Divider(),
                                    ],
                                  );
                                },
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'PRODUITS',
                                    style: AppTextStyle.greysubHeading,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      drawerNotifier.updateProdModificateur(
                                        modificateur: modificateur,
                                      );
                                    },
                                    icon: Icon(Icons.add, color: Colors.red),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    modificateur.produitsIds?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final product = ref
                                      .read(productRiverpod.notifier)
                                      .getProductById(
                                        modificateur.produitsIds![index],
                                      );

                                  if (product == null) {
                                    return SizedBox.shrink();
                                  }

                                  return Column(
                                    children: [
                                      buildModifierTile(
                                        product.name ?? 'Nom non défini',
                                      ),
                                      if (index !=
                                          modificateur.produitsIds!.length - 1)
                                        const Divider(),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),

                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Card(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        CustomListTile(
                                          onTap: () {
                                            final container =
                                                ProviderScope.containerOf(
                                                  context,
                                                );
                                            container
                                                .read(drawerRiverpod.notifier)
                                                .openUpdateCategorieDeModificateur(
                                                  modificateur,
                                                  'nom',
                                                  modificateur.nom,
                                                );

                                            widget.scaffoldKey.currentState!
                                                .openEndDrawer();
                                          },
                                          trailingwidget: null,
                                          title: Text(
                                            'Nom',
                                            style: AppTextStyle.greyHeading,
                                          ),
                                          leading: null,
                                          trailing: modificateur.nom,
                                        ),
                                        const Divider(),
                                        CustomListTile(
                                          onTap: null,
                                          trailingwidget: const Icon(
                                            Icons.restaurant,
                                            color: Colors.indigo,
                                          ),
                                          title: Text(
                                            'Icone',
                                            style: AppTextStyle.greyHeading,
                                          ),
                                          leading: null,
                                          trailing: null,
                                        ),

                                        const Divider(),

                                        CustomListTile(
                                          onTap: () {
                                            final container =
                                                ProviderScope.containerOf(
                                                  context,
                                                );
                                            container
                                                .read(drawerRiverpod.notifier)
                                                .openUpdateCategorieDeModificateur(
                                                  modificateur,
                                                  'couleur',
                                                  Color(
                                                    int.parse(
                                                      '0X${modificateur.couleur!.replaceAll('#', '')}',
                                                    ),
                                                  ),
                                                );

                                            widget.scaffoldKey.currentState!
                                                .openEndDrawer();
                                          },
                                          leading: null,
                                          trailing: null,
                                          title: Text(
                                            "Couleur",
                                            style: AppTextStyle.greyHeading,
                                          ),
                                          trailingwidget: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: hexToColor(
                                                modificateur.couleur!,
                                              ),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.black26,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Divider(),
                                        buildScheduleCard(modificateur),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 32),
                                  Container(
                                    margin: const EdgeInsets.only(top: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        CustomListTile(
                                          onTap: () {
                                            final container =
                                                ProviderScope.containerOf(
                                                  context,
                                                );
                                            container
                                                .read(drawerRiverpod.notifier)
                                                .openUpdateCategorieDeModificateur(
                                                  modificateur,
                                                  'typeDeSelection',
                                                  modificateur
                                                          .typeSelection
                                                          ?.name
                                                          .replaceAll(
                                                            '_',
                                                            ' ',
                                                          ) ??
                                                      '',
                                                );

                                            widget.scaffoldKey.currentState!
                                                .openEndDrawer();
                                          },
                                          leading: null,
                                          trailing:
                                              modificateur.typeSelection != null
                                                  ? modificateur
                                                      .typeSelection
                                                      ?.name
                                                      .replaceAll('_', ' ')
                                                  : "",
                                          title: Text(
                                            'Type de sélection',
                                            style: AppTextStyle.greyHeading,
                                          ),
                                          trailingwidget: null,
                                        ),

                                        Divider(),
                                        CustomListTile(
                                          onTap: () {
                                            final container =
                                                ProviderScope.containerOf(
                                                  context,
                                                );
                                            container
                                                .read(drawerRiverpod.notifier)
                                                .openUpdateCategorieDeModificateur(
                                                  modificateur,
                                                  'obligatoire',
                                                  modificateur.obligatoire,
                                                );

                                            widget.scaffoldKey.currentState!
                                                .openEndDrawer();
                                          },
                                          leading: 'Obligatoire',
                                          trailing: null,
                                          title: null,
                                          trailingwidget: Switch(
                                            activeTrackColor: AppColors.primary,
                                            value: modificateur.obligatoire!,
                                            onChanged: null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  ButtonSupprimer(
                                    style: null,
                                    text: 'Supprimer',
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
              : modificateur != null &&
                  (drawerState is UpdateProdsScreenModificateur)
              ? Column(
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
                        IconButton(
                          onPressed: () {
                            drawerNotifier.resetDrawer();
                          },
                          icon: Icon(Icons.arrow_back),
                        ),
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
                                // _debouncer.debounce(
                                //   duration: const Duration(milliseconds: 200),
                                //   onDebounce: () {
                                //     ref
                                //         .read(productRiverpod.notifier)
                                //         .searchProds(value);
                                //   },
                                // );
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await categorieModificateurNotifier
                                .update(
                                  categorieModificateurState.selected!.copyWith(
                                    produitMode: mode,
                                    produitsIds: ref.read(
                                      tempSelectedIdsProvider,
                                    ),
                                  ),
                                )
                                .then((e) {
                                  drawerNotifier.resetDrawer();
                                });
                          },
                          icon: Icon(Icons.arrow_back),
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
                              value: mode,
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
                                      .map(
                                        (v) => DropdownMenuItem(
                                          value: v,
                                          child: Text(
                                            v.name.replaceAll("_", " "),
                                            style:
                                                AppTextStyle.indingosubHeading,
                                          ),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (AffectationMode? value) {
                                if (value != null) {
                                  mode = value;
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

                            final isSelected = tempSelected.contains(
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
                                  final currentList = ref.read(
                                    tempSelectedIdsProvider,
                                  );
                                  if (currentList.contains(produit.id)) {
                                    ref
                                        .read(tempSelectedIdsProvider.notifier)
                                        .state = currentList
                                            .where((e) => e != produit.id)
                                            .toList();
                                  } else {
                                    ref
                                        .read(tempSelectedIdsProvider.notifier)
                                        .state = [...currentList, produit.id!];
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
              )
              : SizedBox.shrink(),
    );
  }

  Widget buildScheduleCard(CategorieDeModificateur model) {
    List<String?> salleName = [];

    model.sallesIDS?.forEach((e) {
      final salle = ref.watch(salleRiverpod.notifier).getSalleById(e);
      if (salle != null) {
        salleName.add(salle.name);
      }
    });
    return CustomListTile(
      onTap: () {
        final container = ProviderScope.containerOf(context);
        container
            .read(drawerRiverpod.notifier)
            .openUpdateCategorieDeModificateur(model, 'salle', model.sallesIDS);
        widget.scaffoldKey.currentState?.openEndDrawer();
      },
      trailingwidget: null,
      title: null,
      leading: 'Salles concernées par la catégorie de prix',
      trailing: salleName.join(','),
    );
  }
}

Widget buildModifierTile(String nom) {
  return ListTile(
    title: Text(nom, style: AppTextStyle.indingosubHeading),
    trailing: const Icon(Icons.drag_handle),
  );
}

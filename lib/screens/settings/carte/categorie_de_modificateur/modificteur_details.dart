import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/models.dart';
import 'package:restaurent/providers/product_provider.dart';
import 'package:restaurent/providers/providers.dart';

import 'package:restaurent/widgets/widgets.dart';

class ModificateurDetails extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ModificateurDetails({required this.scaffoldKey, super.key});

  @override
  State<ModificateurDetails> createState() => _ModificateurDetailsState();
}

class _ModificateurDetailsState extends State<ModificateurDetails> {
  @override
  Widget build(BuildContext context) {
    final modificateur =
        Provider.of<CategorieModificateurProvider>(context).selectedCategorie;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<CategorieModificateurProvider>(
              context,
              listen: false,
            ).deselect();
          },
        ),

        centerTitle: true,
        title: Text(
          '${modificateur?.nom ?? ""}',
          style: AppTextStyle.largeindingotext,
        ),
      ),
      body: Row(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'MODIFICATEURS / SUPPLÉMENTS',
                            style: AppTextStyle.greysubHeading,
                          ),
                          IconButton(
                            onPressed: () {
                              context
                                  .read<DrawerProvider>()
                                  .openCreateSubCategorieDeModificateur(
                                    modificateur!,
                                  );

                              widget.scaffoldKey.currentState!.openDrawer();
                            },
                            icon: Icon(Icons.add, color: Colors.red),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      color: Colors.white,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: modificateur!.modificateurs.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              _buildModifierTile(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('PRODUITS', style: AppTextStyle.greysubHeading),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add, color: Colors.red),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            modificateur.produitsIds!.isNotEmpty
                                ? modificateur.produitsIds!.length
                                : 0,
                        itemBuilder: (context, index) {
                          final productList = context
                              .read<ProductProvider>()
                              .getProductById(modificateur.produitsIds![index]);

                          if (productList == null || productList.isEmpty) {
                            return ListTile(
                              title: Text(
                                'Produit introuvable',
                                style: AppTextStyle.indingosubHeading,
                              ),
                            );
                          }

                          final product = productList.first;

                          return Column(
                            children: [
                              _buildModifierTile(
                                product.name ?? 'Nom non défini',
                              ),
                              if (index != modificateur.produitsIds!.length - 1)
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
                                    context
                                        .read<DrawerProvider>()
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
                                    context
                                        .read<DrawerProvider>()
                                        .openUpdateCategorieDeModificateur(
                                          modificateur,
                                          'salle',

                                          modificateur.sallesIDS,
                                        );
                                    widget.scaffoldKey.currentState!
                                        .openEndDrawer();
                                  },
                                  title: Text(
                                    'Afficher dans les salles et comptoirs',
                                    style: AppTextStyle.greyHeading,
                                  ),
                                  leading: null,
                                  trailing:
                                      modificateur.sallesIDS != null
                                          ? modificateur.sallesIDS!
                                              .map(
                                                (id) =>
                                                    Provider.of<SalleProvider>(
                                                          context,
                                                        ).salles
                                                        .firstWhere(
                                                          (s) => s.id == id,
                                                        )
                                                        .name,
                                              )
                                              .join(', ')
                                          : 'Aucune salle sélectionnée',
                                  trailingwidget: null,
                                ),
                                const Divider(),

                                CustomListTile(
                                  onTap: () {
                                    context
                                        .read<DrawerProvider>()
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
                                      color: hexToColor(modificateur.couleur!),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black26),
                                    ),
                                  ),
                                ),
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
                                    context
                                        .read<DrawerProvider>()
                                        .openUpdateCategorieDeModificateur(
                                          modificateur,
                                          'typeDeSelection',
                                          modificateur.typeSelection!
                                              .replaceAll('_', ' '),
                                        );
                                    widget.scaffoldKey.currentState!
                                        .openEndDrawer();
                                  },
                                  leading: null,
                                  trailing: modificateur.typeSelection!
                                      .replaceAll('_', ' '),
                                  title: Text(
                                    'Type de sélection',
                                    style: AppTextStyle.greyHeading,
                                  ),
                                  trailingwidget: null,
                                ),

                                Divider(),
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<DrawerProvider>()
                                        .openUpdateCategorieDeModificateur(
                                          modificateur,
                                          'obligatoire',

                                          modificateur.obligatoire,
                                        );
                                    widget.scaffoldKey.currentState!
                                        .openEndDrawer();
                                  },
                                  child: CustomListTile(
                                    onTap: () {
                                      context
                                          .read<DrawerProvider>()
                                          .openUpdateCategorieDeModificateur(
                                            modificateur,
                                            'typeDeSelection',
                                            modificateur.typeSelection!
                                                .replaceAll('_', ' '),
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
      ),
    );
  }

  Widget _buildModifierTile(String nom) {
    return ListTile(
      title: Text(nom, style: AppTextStyle.indingosubHeading),
      trailing: const Icon(Icons.drag_handle),
    );
  }
}

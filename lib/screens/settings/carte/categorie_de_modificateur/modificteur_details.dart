import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:restaurent/blocs/drawer/drawer_bloc.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/models.dart';
import 'package:restaurent/providers/product_provider.dart';

import 'package:restaurent/widgets/widgets.dart';

class ModificateurDetails extends StatefulWidget {
  final CategorieDeModificateur modificateur;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const ModificateurDetails({
    required this.scaffoldKey,
    super.key,

    required this.modificateur,
  });

  @override
  State<ModificateurDetails> createState() => _ModificateurDetailsState();
}

class _ModificateurDetailsState extends State<ModificateurDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Card(
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
                            context.read<DrawerBloc>().add(
                              OpenCreateSubCategorieDeModificateur(
                                modificateur: widget.modificateur,
                              ),
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
                      itemCount: widget.modificateur.modificateurs.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            _buildModifierTile(
                              widget.modificateur.modificateurs[index].nom,
                            ),
                            if (index !=
                                widget.modificateur.modificateurs.length - 1)
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

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.white,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            widget.modificateur.produitsIds!.isNotEmpty
                                ? widget.modificateur.produitsIds!.length
                                : 0,
                        itemBuilder: (context, index) {
                          final productList = context
                              .read<ProductProvider>()
                              .getProductById(
                                widget.modificateur.produitsIds![index],
                              );

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
                              if (index !=
                                  widget.modificateur.produitsIds!.length - 1)
                                const Divider(),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
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
                              InkWell(
                                onTap: () {
                                  context.read<DrawerBloc>().add(
                                    OpenUpdateCategorieDeModificateur(
                                      modificateur: widget.modificateur,
                                      attributeName: 'nom',
                                      currentValue: widget.modificateur.nom,
                                    ),
                                  );
                                  widget.scaffoldKey.currentState!
                                      .openEndDrawer();
                                },
                                child: CustomListTile(
                                  trailingwidget: null,
                                  title: Text(
                                    'Nom',
                                    style: AppTextStyle.greyHeading,
                                  ),
                                  leading: null,
                                  trailing: widget.modificateur.nom,
                                ),
                              ),
                              const Divider(),
                              CustomListTile(
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

                              InkWell(
                                onTap: () {
                                  context.read<DrawerBloc>().add(
                                    OpenUpdateCategorieDeModificateur(
                                      modificateur: widget.modificateur,
                                      attributeName: 'salle',
                                      currentValue:
                                          widget.modificateur.sallesIDS,
                                    ),
                                  );
                                  widget.scaffoldKey.currentState!
                                      .openEndDrawer();
                                },
                                child: CustomListTile(
                                  title: Text(
                                    'Afficher dans les salles et comptoirs',
                                    style: AppTextStyle.greyHeading,
                                  ),
                                  leading: null,
                                  trailing:
                                      widget.modificateur.sallesIDS != null
                                          ? widget.modificateur.sallesIDS!
                                              .map(
                                                (id) =>
                                                    salles
                                                        .firstWhere(
                                                          (s) => s.id == id,
                                                        )
                                                        .nom,
                                              )
                                              .join(', ')
                                          : 'Aucune salle sélectionnée',
                                  trailingwidget: null,
                                ),
                              ),
                              const Divider(),
                              InkWell(
                                onTap: () {
                                  context.read<DrawerBloc>().add(
                                    OpenUpdateCategorieDeModificateur(
                                      modificateur: widget.modificateur,
                                      attributeName: 'couleur',
                                      currentValue: Color(
                                        int.parse(
                                          '0X${widget.modificateur.color!.replaceAll('#', '')}',
                                        ),
                                      ),
                                    ),
                                  );
                                  widget.scaffoldKey.currentState!
                                      .openEndDrawer();
                                },
                                child: CustomListTile(
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
                                      color: Color(
                                        int.parse(
                                          '0X${widget.modificateur.color!.replaceAll('#', '')}',
                                        ),
                                      ),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black26),
                                    ),
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
                              InkWell(
                                onTap: () {
                                  context.read<DrawerBloc>().add(
                                    OpenUpdateCategorieDeModificateur(
                                      modificateur: widget.modificateur,
                                      attributeName: 'typeDeSelection',
                                      currentValue: widget
                                          .modificateur
                                          .typeSelection!
                                          .replaceAll('_', ' '),
                                    ),
                                  );
                                  widget.scaffoldKey.currentState!
                                      .openEndDrawer();
                                },
                                child: CustomListTile(
                                  leading: null,
                                  trailing: widget.modificateur.typeSelection!
                                      .replaceAll('_', ' '),
                                  title: Text(
                                    'Type de sélection',
                                    style: AppTextStyle.greyHeading,
                                  ),
                                  trailingwidget: null,
                                ),
                              ),
                              const Divider(),
                              InkWell(
                                onTap: () {
                                  context.read<DrawerBloc>().add(
                                    OpenUpdateCategorieDeModificateur(
                                      modificateur: widget.modificateur,
                                      attributeName: 'affectaionMode',
                                      currentValue: widget
                                          .modificateur
                                          .affectationMode!
                                          .name
                                          .replaceAll('_', ''),
                                    ),
                                  );
                                  widget.scaffoldKey.currentState!
                                      .openEndDrawer();
                                },
                                child: CustomListTile(
                                  leading: null,
                                  trailing: widget
                                      .modificateur
                                      .affectationMode!
                                      .name
                                      .replaceAll('_', ' '),
                                  title: Text(
                                    'Affectaion mode',
                                    style: AppTextStyle.greyHeading,
                                  ),
                                  trailingwidget: null,
                                ),
                              ),
                              const Divider(),
                              InkWell(
                                onTap: () {
                                  context.read<DrawerBloc>().add(
                                    OpenUpdateCategorieDeModificateur(
                                      modificateur: widget.modificateur,
                                      attributeName: 'obligatoire',
                                      currentValue:
                                          widget.modificateur.obligatoire,
                                    ),
                                  );
                                  widget.scaffoldKey.currentState!
                                      .openEndDrawer();
                                },
                                child: CustomListTile(
                                  leading: 'Obligatoire',
                                  trailing: null,
                                  title: null,
                                  trailingwidget: Switch(
                                    activeTrackColor: AppColors.primary,
                                    value: widget.modificateur.obligatoire!,
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

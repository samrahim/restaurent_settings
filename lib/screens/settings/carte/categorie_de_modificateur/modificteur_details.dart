import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:restaurent/blocs/categorie_de_modificateur_bloc/categorie_modificateur_bloc.dart';
import 'package:restaurent/blocs/drawer/drawer_bloc.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/categorie_de_modificateur.dart';

import '../../../widgets/widgets.dart';

class ModificateurDetails extends StatefulWidget {
  final CategorieDeModificateur modificateur;
  final String categoryName;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ModificateurDetails({
    required this.scaffoldKey,
    super.key,
    required this.categoryName,
    required this.modificateur,
  });

  @override
  State<ModificateurDetails> createState() => _ModificateurDetailsState();
}

class _ModificateurDetailsState extends State<ModificateurDetails> {
  bool isObligatoire = false;
  String _selectedValue = 'Tous';
  String _typeSelection = 'Un seul choix';
  final List<String> _optiontypeDeSelection = ['Un seul choix', 'Multi choix'];
  Color _currentColor = Colors.pinkAccent;
  final List<String> _options = ['Tous', 'Les salles', 'Les comptoirs'];
  void _openColorPicker() {
    showDialog(
      context: context,
      builder: (context) {
        Color tempColor = _currentColor;
        return AlertDialog(
          title: Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: tempColor,
              onColorChanged: (Color color) {
                tempColor = color;
              },
              enableAlpha: false,

              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Select'),
              onPressed: () {
                setState(() {
                  _currentColor = tempColor;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(color: Colors.grey.shade100),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
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
                        trailing: Icon(Icons.chevron_right),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'MODIFICATEURS / SUPPLÉMENTS',
                            style: AppTextStyle.greysubHeading,
                          ),
                          Icon(Icons.add, color: Colors.red),
                        ],
                      ),
                    ),

                    Container(
                      color: Colors.white,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              _buildModifierTile(modifiers[index]),
                              if (index != 4) Divider(),
                            ],
                          );
                        },
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('PRODUITS', style: AppTextStyle.greysubHeading),
                          Icon(Icons.add, color: Colors.red),
                        ],
                      ),
                    ),

                    // List of products
                    Container(
                      color: Colors.white,
                      child: ListView.builder(
                        shrinkWrap: true,

                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              _buildModifierTile(modifiers[index]),
                              if (index != 4) Divider(),
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
          SizedBox(width: 24),
          // Right panel - Form
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4),
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
                              currentValue: widget.categoryName,
                            ),
                          );
                          widget.scaffoldKey.currentState!.openEndDrawer();
                        },
                        child: CustomListTile(
                          trailingwidget: null,
                          title: Text('Nom', style: AppTextStyle.greyHeading),
                          leading: null,
                          trailing: widget.categoryName,
                        ),
                      ),
                      Divider(),
                      CustomListTile(
                        trailingwidget: Icon(
                          Icons.restaurant,
                          color: Colors.indigo.shade400,
                        ),
                        title: Text('Icone', style: AppTextStyle.greyHeading),
                        leading: null,
                        trailing: null,
                      ),
                      Divider(),

                      InkWell(
                        onTap: () {
                          context.read<DrawerBloc>().add(
                            OpenUpdateCategorieDeModificateur(
                              modificateur: widget.modificateur,
                              attributeName: 'salle',
                              currentValue: widget.categoryName,
                            ),
                          );
                          widget.scaffoldKey.currentState!.openEndDrawer();
                        },
                        child: CustomListTile(
                          title: Text(
                            'Afficher dans les salles et comptoirs',
                            style: AppTextStyle.greyHeading,
                          ),
                          leading: null,
                          trailing: widget.modificateur.typeDeSalleDisponible!,
                          trailingwidget: null,
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () {
                          context.read<DrawerBloc>().add(
                            OpenUpdateCategorieDeModificateur(
                              modificateur: widget.modificateur,
                              attributeName: 'couleur',
                              currentValue: widget.modificateur.color,
                            ),
                          );
                          widget.scaffoldKey.currentState!.openEndDrawer();
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
                              color: widget.modificateur.color,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black26),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Container(
                  margin: EdgeInsets.only(top: 4),
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
                              currentValue: widget.modificateur.typeDeSelection,
                            ),
                          );
                          widget.scaffoldKey.currentState!.openEndDrawer();
                        },
                        child: CustomListTile(
                          leading: null,
                          trailing: widget.modificateur.typeDeSelection,
                          title: Text(
                            'Type de sélection',
                            style: AppTextStyle.greyHeading,
                          ),
                          trailingwidget: null,
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () {
                          context.read<DrawerBloc>().add(
                            OpenUpdateCategorieDeModificateur(
                              modificateur: widget.modificateur,
                              attributeName: 'obligatoire',
                              currentValue: widget.modificateur.obligatoire,
                            ),
                          );
                          widget.scaffoldKey.currentState!.openEndDrawer();
                        },
                        child: CustomListTile(
                          leading: 'Obligatoire',
                          trailing: null,
                          title: null,
                          trailingwidget: Switch(
                            activeTrackColor: AppColors.primary,
                            value: isObligatoire,
                            onChanged: null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),

                ButtonSupprimer(onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModifierTile(String title) {
    return ListTile(
      title: Text(title, style: AppTextStyle.indingosubHeading),
      trailing: Icon(Icons.drag_handle),
    );
  }
}

List<String> produits = [
  'La cote de veau',
  'L\'entrecôte grillée',
  'Magret de canard',
  'Parmentier de canard',
  'Steak tartare',
  'Tartare de saumons',
];

List<String> modifiers = ['Bleu', 'Saignant', 'Bien cuit', 'Très cuit', 'Rosé'];

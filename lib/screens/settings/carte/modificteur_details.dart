import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:restaurent/consts.dart';

import '../../widgets/widgets.dart';

class ModificateurDetails extends StatefulWidget {
  final String categoryName;

  const ModificateurDetails({Key? key, required this.categoryName})
    : super(key: key);

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
              enableAlpha: false, // hide opacity slider
              showLabel: true,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
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
                          // MODIFICATEURS / SUPPLÉMENTS section
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
                              shrinkWrap:
                                  true, // Important for letting the list be as tall as its children
                              physics:
                                  NeverScrollableScrollPhysics(), // To prevent nested scroll issues
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
                                Text(
                                  'PRODUITS',
                                  style: AppTextStyle.greysubHeading,
                                ),
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
                            CustomListTile(
                              trailingwidget: null,
                              title: Text(
                                'Nom',
                                style: AppTextStyle.greyHeading,
                              ),
                              leading: null,
                              trailing: widget.categoryName,
                            ),
                            Divider(),
                            CustomListTile(
                              trailingwidget: Icon(
                                Icons.restaurant,
                                color: Colors.indigo.shade400,
                              ),
                              title: Text(
                                'Icone',
                                style: AppTextStyle.greyHeading,
                              ),
                              leading: null,
                              trailing: null,
                            ),
                            Divider(),

                            CustomListTile(
                              title: Text(
                                'Afficher dans les salles et comptoirs',
                                style: AppTextStyle.greyHeading,
                              ),
                              leading: null,
                              trailing: null,
                              trailingwidget: DropdownButton<String>(
                                underline: SizedBox(),
                                style: AppTextStyle.indingosubHeading,
                                value: _selectedValue,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      _selectedValue = newValue;
                                    });
                                  }
                                },
                                items:
                                    _options.map<DropdownMenuItem<String>>((
                                      String value,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                              ),
                            ),
                            Divider(),
                            CustomListTile(
                              leading: null,
                              trailing: null,
                              title: Text(
                                "Couleur",
                                style: AppTextStyle.greyHeading,
                              ),
                              trailingwidget: GestureDetector(
                                onTap: _openColorPicker,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: _currentColor,
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
                            CustomListTile(
                              leading: null,
                              trailing: null,
                              title: Text(
                                'Type de sélection',
                                style: AppTextStyle.greyHeading,
                              ),
                              trailingwidget: DropdownButton<String>(
                                underline: SizedBox(),
                                style: AppTextStyle.indingosubHeading,
                                value: _typeSelection,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      _typeSelection = newValue;
                                    });
                                  }
                                },
                                items:
                                    _optiontypeDeSelection
                                        .map<DropdownMenuItem<String>>((
                                          String value,
                                        ) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        })
                                        .toList(),
                              ),
                            ),
                            Divider(),
                            CustomListTile(
                              leading: 'Obligatoire',
                              trailing: null,
                              title: null,
                              trailingwidget: Switch(
                                activeColor: Colors.blueAccent,
                                value: isObligatoire,
                                onChanged: (value) {
                                  setState(() {
                                    isObligatoire = value;
                                  });
                                },
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

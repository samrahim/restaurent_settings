import 'package:flutter/material.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/screens/settings/carte/modificteur_details.dart';
import 'package:restaurent/screens/widgets/action_button.dart';
import 'package:restaurent/screens/widgets/widgets.dart';

class ModificateursSupplementsScreen extends StatefulWidget {
  const ModificateursSupplementsScreen({super.key});

  @override
  State<ModificateursSupplementsScreen> createState() =>
      _ModificateursSupplementsScreenState();
}

class _ModificateursSupplementsScreenState
    extends State<ModificateursSupplementsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController name = TextEditingController();
  String? selectedCategory;

  Widget _buildCategoriesList() {
    return Container(
      color: Colors.grey.shade200,
      margin: EdgeInsets.all(6),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),

            margin: EdgeInsets.all(18),
            child: Column(
              children: [
                ...categories_de_modificateurs.map(
                  (e) => Column(
                    children: [
                      GestureDetector(
                        child: ListTile(
                          title: Text(e, style: AppTextStyle.indingoHeading),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.indigo,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selectedCategory = e;
                          });
                        },
                      ),
                      e != categories_de_modificateurs.last
                          ? Divider()
                          : SizedBox(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width * .25,
        child: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Nom de la catégorie",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.grey!),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  hintText: "Disponibilité",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.grey!),
                  ),
                ),
                items:
                    salles
                        .map((e) => DropdownMenuItem(child: Text(e), value: e))
                        .toList(),
                onChanged: (value) {},
              ),
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.grey!),
              ),
              child: CustomListTile(
                leading: null,
                trailing: null,
                title: Text("Obligatoire"),
                trailingwidget: Switch(
                  activeColor: AppColors.primary,
                  value: true,
                  onChanged: (value) {},
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  categories_de_modificateurs.add(name.text);
                });
                name.clear();
                Navigator.pop(context);
              },
              child: Text("Ajouter"),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Column(
          children: [
            selectedCategory != null
                ? AppBar(
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title: Text(
                    selectedCategory!,
                    style: AppTextStyle.indingoHeading,
                  ),
                  actions: [SizedBox()],
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      setState(() {
                        selectedCategory = null;
                      });
                    },
                  ),
                )
                : AppBar(
                  actions: [
                    ActionButton(onPressed: () {}, text: 'Reorganiser'),
                    ActionButton(
                      onPressed: () {
                        _scaffoldKey.currentState?.openEndDrawer();
                      },
                      text: 'Nouveau',
                    ),
                  ],
                  centerTitle: true,
                  title: Text(
                    'Categories de modificateurs / Supplements ',
                    style: AppTextStyle.largeindingotext,
                  ),
                ),
            Expanded(
              child:
                  selectedCategory == null
                      ? _buildCategoriesList()
                      : ModificateurDetails(categoryName: selectedCategory!),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> categories_de_modificateurs = [
  "Cuisson",
  "Sauces",
  "Supplements payants",
  "Accompagnement",
  "Glaces",
];

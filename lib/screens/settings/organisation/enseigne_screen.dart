import 'package:flutter/material.dart';
import 'package:restaurent/widgets/custom_list_tile.dart';

class EnseigneScreen extends StatelessWidget {
  const EnseigneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      padding: EdgeInsets.all(16),
      child: Container(
        margin: EdgeInsets.all(8),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle("Entete"),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),

                child: Column(
                  children: [
                    CustomListTile(
                      onTap: null,
                      trailingwidget: null,
                      leading: 'Nom de l\'enseigne',
                      trailing: "LNE 1",
                      title: null,
                    ),
                    Divider(),
                    CustomListTile(
                      onTap: null,
                      trailingwidget: null,
                      leading: 'Adresse',
                      trailing: "1 Place Laine 1",
                      title: null,
                    ),
                    Divider(),
                    CustomListTile(
                      onTap: null,
                      trailingwidget: null,
                      leading: 'Code Postal',
                      trailing: "330001",
                      title: null,
                    ),
                    Divider(),
                    CustomListTile(
                      onTap: null,
                      trailingwidget: null,
                      leading: 'Ville',
                      trailing: "Bordeaux",
                      title: null,
                    ),
                    Divider(),
                    CustomListTile(
                      onTap: null,
                      trailingwidget: null,
                      leading: 'Telephone',
                      trailing: "010000000",
                      title: null,
                    ),
                    Divider(),
                    CustomListTile(
                      onTap: null,
                      trailingwidget: null,
                      leading: 'Raison sociale',
                      trailing: "Swift",
                      title: null,
                    ),
                    Divider(),
                    CustomListTile(
                      onTap: null,
                      trailingwidget: null,
                      leading: 'RCS',
                      trailing: "Test 1",
                      title: null,
                    ),
                    Divider(),
                    CustomListTile(
                      onTap: null,
                      trailingwidget: null,
                      leading: 'APE',
                      trailing: "Test 1",
                      title: null,
                    ),
                    Divider(),
                    CustomListTile(
                      onTap: null,
                      leading: 'Siret',
                      trailingwidget: null,
                      trailing: "011111",
                      title: null,
                    ),
                    Divider(),
                    CustomListTile(
                      onTap: null,
                      leading: 'Numero de TVA',
                      trailingwidget: null,
                      trailing: "Test 1",
                      title: null,
                    ),
                  ],
                ),
              ),

              _buildTitle("PIED DE PAGE"),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    CustomListTile(
                      onTap: null,
                      leading: 'Horaires',
                      trailing: "12h00 - 14h00 ",
                      title: null,
                      trailingwidget: null,
                    ),
                    Divider(),
                    CustomListTile(
                      onTap: null,
                      trailingwidget: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.indigo.shade400,
                      ),
                      title: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .6,
                          ),
                          Text(
                            'Venez vous regler',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.indigo.shade400,
                            ),
                          ),
                        ],
                      ),
                      leading: 'Champ libre',
                      trailing: null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text(title, style: TextStyle(fontSize: 20, color: Colors.grey)),
    );
  }
}

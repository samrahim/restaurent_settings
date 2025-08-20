import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/sub_categorie_de_modificateur.dart';
import 'package:restaurent/models/taux_tva_model.dart';
import 'package:restaurent/screens/reglage_screen.dart';
import 'package:restaurent/screens/settings/carte/categorie_de_modificateur/modificateurs_supplements_screen.dart';
import 'package:restaurent/widgets/create_button.dart';

class CreateSubCategorieDrawer extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CreateSubCategorieDrawer({super.key, required this.scaffoldKey});

  @override
  ConsumerState<CreateSubCategorieDrawer> createState() =>
      _CreateSubCategorieDrawerState();
}

class _CreateSubCategorieDrawerState
    extends ConsumerState<CreateSubCategorieDrawer> {
  TextEditingController prix = TextEditingController();
  TextEditingController supplement = TextEditingController();
  TauxTvaModel tvaModel = tauxTvaList[0];
  bool subActif = false;
  @override
  Widget build(BuildContext context) {
    final tauxEtTvaState = ref.watch(tauxEtTvaRiverpod);
    final categorieModificateurNotifier = ref.read(
      categorieModificateurRiverpod.notifier,
    );
    final categorieModificateurState = ref.watch(categorieModificateurRiverpod);
    return Drawer(
      width: MediaQuery.of(context).size.width * .33,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Créer une nouvelle sous-catégorie',
                style: AppTextStyle.indingoHeading,
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: supplement,

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Le nom est requis";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,

              decoration: InputDecoration(
                labelText: 'Nom',
                labelStyle: AppTextStyle.indingosubHeading,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: prix,
              decoration: InputDecoration(
                labelText: 'Prix',
                labelStyle: AppTextStyle.indingosubHeading,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
            const SizedBox(height: 16),
            CustomContainer(
              child: ListTile(
                title: Text('Actif', style: AppTextStyle.indingosubHeading),
                trailing: Switch(
                  value: subActif,
                  activeColor: AppColors.indingo400,
                  onChanged: (value) {
                    setState(() {
                      subActif = !subActif;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
                color: Colors.grey[50],
              ),
              child: DropdownButtonFormField<TauxTvaModel>(
                value: tvaModel,
                decoration: const InputDecoration(
                  labelText: 'TVA',
                  border: InputBorder.none,
                ),
                items:
                    tauxEtTvaState.tauxTvas
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.tauxTva.toString(),
                              style: AppTextStyle.indingosubHeading,
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      tvaModel = value;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 32),
            CreateButton(
              onPressed: () {
                SubCategorieDeModificateur sub = SubCategorieDeModificateur(
                  nom: supplement.text,
                  actif: subActif,
                  prix: double.parse(prix.text),
                  tvaValue: tvaModel.tauxTva!,
                );
                categorieModificateurNotifier.createSubCategorie(
                  subCategorie: sub,
                );
                supplement.clear();
                prix.clear();
                widget.scaffoldKey.currentState?.closeDrawer();
              },
              buttonText: 'Créer',
            ),
          ],
        ),
      ),
    );
  }
}

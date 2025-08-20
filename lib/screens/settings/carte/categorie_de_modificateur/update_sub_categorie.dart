import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/categorie_de_prix_model.dart';
import 'package:restaurent/models/sub_categorie_de_modificateur.dart';
import 'package:restaurent/models/taux_tva_model.dart';
import 'package:restaurent/screens/reglage_screen.dart';
import 'package:restaurent/screens/settings/carte/categorie_de_modificateur/modificateurs_supplements_screen.dart';
import 'package:restaurent/widgets/create_button.dart';

class UpdateSubcategorieDrawer extends StatefulWidget {
  final SubCategorieDeModificateur subCategorie;
  final List<TauxTvaModel> tauxTvas;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const UpdateSubcategorieDrawer({
    Key? key,
    required this.subCategorie,
    required this.tauxTvas,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  State<UpdateSubcategorieDrawer> createState() =>
      _UpdateSubcategorieDrawerState();
}

class _UpdateSubcategorieDrawerState extends State<UpdateSubcategorieDrawer> {
  late String _nom;
  late double _prix;
  late bool _actif;
  double? _selectedTva;

  @override
  void initState() {
    super.initState();
    _nom = widget.subCategorie.nom;
    _prix = widget.subCategorie.prix;
    _actif = widget.subCategorie.actif;
    _selectedTva = widget.subCategorie.tvaValue;
  }

  void _onUpdate() async {
    final updated = widget.subCategorie.copyWith(
      nom: _nom,
      prix: _prix,
      actif: _actif,
      tvaValue: _selectedTva,
    );

    final categorieContainer = ProviderScope.containerOf(context);
    categorieContainer
        .read(categorieModificateurRiverpod.notifier)
        .updateSubcategori(subCategorie: updated);
    final container = ProviderScope.containerOf(context);
    container.read(drawerRiverpod.notifier).resetDrawer();

    widget.scaffoldKey.currentState?.closeDrawer();
  }

  @override
  Widget build(BuildContext context) {
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
                'Modifier sous-catégorie',
                style: AppTextStyle.indingoHeading,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _nom,
              onChanged: (val) => setState(() => _nom = val),
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
            TextFormField(
              initialValue: _prix.toString(),
              keyboardType: TextInputType.number,
              onChanged:
                  (val) => setState(() => _prix = double.tryParse(val) ?? 0),
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
                  value: _actif,
                  activeColor: AppColors.indingo400,
                  onChanged: (val) => setState(() => _actif = val),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
                color: Colors.grey[50],
              ),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'TVA',
                  border: InputBorder.none,
                ),
                value: _selectedTva,
                hint:
                    _selectedTva == null
                        ? const Text("Select TVA")
                        : Text(_selectedTva.toString()),

                items:
                    widget.tauxTvas
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.tauxTva,
                            child: Text(
                              e.tauxTva.toString(),
                              style: AppTextStyle.indingosubHeading,
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (val) => setState(() => _selectedTva = val),
              ),
            ),
            const SizedBox(height: 32),
            CreateButton(onPressed: _onUpdate, buttonText: "Modifier"),
          ],
        ),
      ),
    );
  }
}

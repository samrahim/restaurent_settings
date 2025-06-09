import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent/blocs/drawer/drawer_bloc.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/categorie_de_prix_model.dart';
import 'package:restaurent/screens/widgets/action_button.dart';
import 'package:restaurent/screens/widgets/custom_list_tile.dart';

class CategoriesPrixScreen extends StatelessWidget {
  const CategoriesPrixScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DrawerBloc(),
      child: CategoriesPrixScreenView(),
    );
  }
}

class CategoriesPrixScreenView extends StatefulWidget {
  const CategoriesPrixScreenView({super.key});

  @override
  State<CategoriesPrixScreenView> createState() =>
      _CategoriesPrixScreenViewState();
}

class _CategoriesPrixScreenViewState extends State<CategoriesPrixScreenView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catégories de prix', style: AppTextStyle.largeindingotext),
        centerTitle: true,
        actions: [
          ActionButton(
            onPressed: () {
              // context.read<DrawerBloc>().add(OpenCreateCategoriePrixDrawer());
              // _scaffoldKey.currentState?.openEndDrawer();
            },
            text: "Reorganiser",
          ),
          ActionButton(
            onPressed: () {
              // context.read<DrawerBloc>().add(OpenCreateUtilisateurDrawer());
              // _scaffoldKey.currentState?.openEndDrawer();
            },
            text: "Nouveau",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: categoriesPrix.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: Card(
                child: CustomListTile(
                  title: Text(
                    categoriesPrix[index].nom,
                    style: AppTextStyle.indingoHeading,
                  ),
                  leading: null,
                  trailing: null,
                  trailingwidget: Icon(Icons.arrow_forward_ios),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Helllo extends StatelessWidget {
  final CategorieDePrixModel categorieDePrix;
  const Helllo({super.key, required this.categorieDePrix});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categorieDePrix.nom, style: AppTextStyle.largeindingotext),
        centerTitle: true,
        actions: [ActionButton(onPressed: () {}, text: "Enregistrer")],
      ),
    );
  }
}

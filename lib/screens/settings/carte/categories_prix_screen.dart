import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent/blocs/drawer/drawer_bloc.dart';

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

class CategoriesPrixScreenView extends StatelessWidget {
  const CategoriesPrixScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBar(),
    );
  }
}

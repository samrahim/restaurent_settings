import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:restaurent/blocs/drawer/drawer_bloc.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/providers/providers.dart';

import '../blocs/settings/settings_bloc.dart';

class ReglageScreen extends StatelessWidget {
  const ReglageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<http.Client>(create: (_) => http.Client()),
        BlocProvider(create: (_) => DrawerBloc()),
        BlocProvider(
          create:
              (_) => SettingsBloc(initialSettings: routes)..add(LoadSettings()),
        ),

        ChangeNotifierProxyProvider<http.Client, CategorieDePrixProvider>(
          create:
              (context) =>
                  CategorieDePrixProvider(client: context.read<http.Client>()),
          update:
              (_, client, previous) => CategorieDePrixProvider(client: client),
        ),
        ChangeNotifierProxyProvider<http.Client, CategorieModificateurProvider>(
          create:
              (context) => CategorieModificateurProvider(
                client: context.read<http.Client>(),
              ),
          update:
              (_, client, previous) =>
                  CategorieModificateurProvider(client: client),
        ),
        ChangeNotifierProxyProvider<http.Client, MoyenDePaiementProvider>(
          create:
              (context) =>
                  MoyenDePaiementProvider(client: context.read<http.Client>()),
          update:
              (_, client, previous) => MoyenDePaiementProvider(client: client),
        ),
        ChangeNotifierProxyProvider<http.Client, TauxEtTvaProvider>(
          create:
              (context) =>
                  TauxEtTvaProvider(client: context.read<http.Client>()),
          update: (_, client, previous) => TauxEtTvaProvider(client: client),
        ),
        ChangeNotifierProxyProvider<http.Client, UtilisateurProvider>(
          create:
              (context) =>
                  UtilisateurProvider(client: context.read<http.Client>()),
          update: (_, client, previous) => UtilisateurProvider(client: client),
        ),
      ],

      child: const ReglageView(),
    );
  }
}

class ReglageView extends StatefulWidget {
  const ReglageView({super.key});

  @override
  State<ReglageView> createState() => _ReglageViewState();
}

class _ReglageViewState extends State<ReglageView>
    with TickerProviderStateMixin {
  TabController? _mainTabController;
  List<TabController>? _subTabControllers;

  void _initializeControllers(Map<String, Map<String, dynamic>> settings) {
    _mainTabController?.dispose();
    _subTabControllers?.forEach((controller) => controller.dispose());

    _mainTabController = TabController(length: settings.length, vsync: this);

    _subTabControllers = List.generate(
      settings.length,
      (index) => TabController(
        length: settings.values.elementAt(index).length,
        vsync: this,
      ),
    );
  }

  @override
  void dispose() {
    _mainTabController?.dispose();
    _subTabControllers?.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is SettingsLoaded) {
          _initializeControllers(state.settings);
          _mainTabController?.animateTo(state.selectedMainTab);
          _subTabControllers?[state.selectedMainTab].animateTo(
            state.selectedSubTab,
          );
        }
      },
      builder: (context, state) {
        if (state is! SettingsLoaded ||
            _mainTabController == null ||
            _subTabControllers == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final mainCategories = state.settings.keys.toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Réglages'),
            bottom: TabBar(
              controller: _mainTabController,
              isScrollable: false,
              tabs:
                  mainCategories
                      .map((category) => Tab(text: category))
                      .toList(),
              onTap: (index) {
                context.read<SettingsBloc>().add(ChangeMainTab(index));
              },
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _mainTabController,
            children: List.generate(mainCategories.length, (mainIndex) {
              final category = mainCategories[mainIndex];
              final categoryOptions = state.settings[category]!;
              final subTabs = categoryOptions.entries.toList();

              return Column(
                children: [
                  Material(
                    child: TabBar(
                      controller: _subTabControllers![mainIndex],
                      isScrollable: false,

                      tabs:
                          subTabs.map((entry) {
                            final label = entry.value['label'] ?? entry.key;
                            return Tab(text: label.toString());
                          }).toList(),
                      onTap: (index) {
                        context.read<SettingsBloc>().add(
                          ChangeSubTab(mainIndex, index),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _subTabControllers![mainIndex],
                      children:
                          subTabs.map((entry) {
                            return entry.value['content'] as Widget;
                          }).toList(),
                    ),
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}

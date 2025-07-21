import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/providers/product_provider.dart';
import 'package:restaurent/providers/providers.dart';

class ReglageScreen extends StatelessWidget {
  const ReglageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<http.Client>(create: (_) => http.Client()),
        ChangeNotifierProvider(
          create:
              (_) => SettingsProvider(initialSettings: routes)..loadSettings(),
        ),
        ChangeNotifierProvider(create: (_) => DrawerProvider()),
        ChangeNotifierProvider(create: (_) => ImprimanteDrawerProvider()),
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
        ChangeNotifierProxyProvider<http.Client, ProductProvider>(
          create:
              (context) => ProductProvider(client: context.read<http.Client>()),
          update: (_, client, previous) => ProductProvider(client: client),
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
    return Consumer<SettingsProvider>(
      builder: (context, provider, child) {
        final settings = provider.settings;

        if (settings.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // Important : initialiser les contrôleurs si nécessaire
        if (_mainTabController == null || _subTabControllers == null) {
          _initializeControllers(settings);
          _mainTabController?.animateTo(provider.selectedMainTab);
          _subTabControllers?[provider.selectedMainTab].animateTo(
            provider.selectedSubTab,
          );
        }

        final mainCategories = settings.keys.toList();

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
                provider.changeMainTab(index);
              },
            ),
          ),
          body: TabBarView(
            controller: _mainTabController,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(mainCategories.length, (mainIndex) {
              final category = mainCategories[mainIndex];
              final categoryOptions = settings[category]!;
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
                        provider.changeSubTab(mainIndex, index);
                      },
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _subTabControllers![mainIndex],
                      physics: const NeverScrollableScrollPhysics(),
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

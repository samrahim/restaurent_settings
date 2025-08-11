import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent/consts.dart';
import 'package:restaurent/riverpods/drawer_riverpod/drawer_riverpod.dart';
import 'package:restaurent/riverpods/drawer_riverpod/drawer_state.dart';
import 'package:restaurent/riverpods/riverpods.dart';

final tempSelectedIdsProvider = StateProvider<List<String>>((ref) {
  return [];
});

final settingsRiverpod = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) => SettingsNotifier(initialSettings: routes)..loadSettings(),
);
final httpClientProvider = Provider<http.Client>((ref) => http.Client());

final salleRiverpod = StateNotifierProvider<SalleNotifier, SalleState>((ref) {
  final client = ref.watch(httpClientProvider);
  return SalleNotifier(client: client)..getSalles();
});

final tauxEtTvaRiverpod =
    StateNotifierProvider<TauxEtTvaNotifier, TauxEtTvaState>((ref) {
      return TauxEtTvaNotifier();
    });

final utilisateurRiverpod =
    StateNotifierProvider<UtilisateurNotifier, UtilisateurState>((ref) {
      final client = ref.watch(httpClientProvider);
      return UtilisateurNotifier(client: client);
    });

final categorieModificateurRiverpod = StateNotifierProvider<
  CategorieModificateurNotifier,
  CategorieModificateurState
>((ref) {
  final client = ref.watch(httpClientProvider);
  return CategorieModificateurNotifier(client: client);
});

final drawerRiverpod = StateNotifierProvider<DrawerNotifier, DrawerState>(
  (ref) => DrawerNotifier(),
);

final imprimanteRiverpod =
    StateNotifierProvider<ImprimanteNotifier, ImprimanteState>((ref) {
      final client = ref.watch(httpClientProvider);
      return ImprimanteNotifier(client: client);
    });

final productRiverpod = StateNotifierProvider<ProductNotifier, ProductState>((
  ref,
) {
  final client = ref.watch(httpClientProvider);
  return ProductNotifier(client: client)..getProds();
});

final categorieDePrixRiverpod =
    StateNotifierProvider<CategorieDePrixNotifier, CategorieDePrixState>((ref) {
      final client = ref.watch(httpClientProvider);
      return CategorieDePrixNotifier(client: client);
    });

final moyenDePaiementRiverpod =
    StateNotifierProvider<MoyenDePaiementNotifier, MoyenDePaiementState>((ref) {
      final client = ref.watch(httpClientProvider);
      return MoyenDePaiementNotifier(client: client);
    });

class ReglageScreen extends StatelessWidget {
  const ReglageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ReglageView();
  }
}

class ReglageView extends ConsumerStatefulWidget {
  const ReglageView({super.key});

  @override
  ConsumerState<ReglageView> createState() => _ReglageViewState();
}

class _ReglageViewState extends ConsumerState<ReglageView>
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
    final settingsState = ref.watch(settingsRiverpod);
    final notifier = ref.read(settingsRiverpod.notifier);

    final settings = settingsState.settings;

    if (settings.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // Initialisation des contrôleurs
    if (_mainTabController == null || _subTabControllers == null) {
      _initializeControllers(settings);
      _mainTabController?.animateTo(settingsState.selectedMainTab);
      _subTabControllers?[settingsState.selectedMainTab].animateTo(
        settingsState.selectedSubTab,
      );
    }

    final mainCategories = settings.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Réglages'),
        bottom: TabBar(
          controller: _mainTabController,
          isScrollable: false,
          tabs: mainCategories.map((category) => Tab(text: category)).toList(),
          onTap: notifier.changeMainTab,
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
                    notifier.changeSubTab(mainIndex, index);
                  },
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _subTabControllers![mainIndex],
                  physics: const NeverScrollableScrollPhysics(),
                  children:
                      subTabs
                          .map((entry) => entry.value['content'] as Widget)
                          .toList(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

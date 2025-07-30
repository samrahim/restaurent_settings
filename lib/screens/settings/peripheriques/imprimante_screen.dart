import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/peripherique_model.dart.dart';
import 'package:restaurent/riverpods/drawer_riverpod/drawer_state.dart';
import 'package:restaurent/riverpods/imprimante_riverpod.dart';
import 'package:restaurent/screens/reglage_screen.dart';
import 'package:restaurent/widgets/widgets.dart';

class ImprimanteScreen extends ConsumerStatefulWidget {
  const ImprimanteScreen({super.key});

  @override
  ConsumerState<ImprimanteScreen> createState() => _ImprimanteScreenState();
}

class _ImprimanteScreenState extends ConsumerState<ImprimanteScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final ipRegex = RegExp(
    r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\$',
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(imprimanteRiverpod.notifier).getAllImprimantes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final imprimanteProvider = ref.watch(imprimanteRiverpod);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Imprimantes', style: AppTextStyle.largeindingotext),
        centerTitle: true,
        actions: [
          ActionButton(
            onPressed: () {
              final container = ProviderScope.containerOf(context);
              container
                  .read(drawerRiverpod.notifier)
                  .openCreateImprimantDrawer();
              scaffoldKey.currentState?.openEndDrawer();
            },
            text: 'Nouveau',
          ),
        ],
      ),
      endDrawer: _endDrawer(),
      body: _buildTerminalStatusSection(imprimanteProvider.peripheriques),
    );
  }

  Widget _buildTerminalStatusSection(List<Peripherique> peripherique) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: peripherique.length,
          itemBuilder: (context, index) {
            final item = peripherique[index];
            return _buildTerminalTile(item);
          },
        ),
      ),
    );
  }

  Widget _buildTerminalTile(Peripherique peripherique) {
    return ListTile(
      leading: Icon(
        Icons.print,
        color: (peripherique.etat ?? false) ? Colors.green : Colors.grey,
      ),
      title: Text(peripherique.model ?? ''),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(peripherique.nom ?? ''),
          Text(peripherique.typeConnection?.name ?? ''),
        ],
      ),
    );
  }

  Widget _endDrawer() {
    return Consumer(
      builder: (context, ref, _) {
        final state = ref.watch(imprimanteRiverpod);
        final notifier = ref.watch(imprimanteRiverpod.notifier);
        final drawerState = ref.watch(drawerRiverpod);
        if (drawerState is DrawerCreateImprimant) {
          return Drawer(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Sauvgarder une imprimante',
                    style: AppTextStyle.indingoHeading,
                  ),
                  const SizedBox(height: 16),
                  _buildDropdown(notifier, state),
                  const SizedBox(height: 16),
                  if (state.selectedType == TypeConnection.TCT_IP) ...[
                    _buildIPField(notifier, state),
                    const SizedBox(height: 16),
                    _buildPortField(notifier, state),
                    const SizedBox(height: 8),
                    _buildEtatSwitch(notifier, state),
                    const SizedBox(height: 8),
                    if (ipRegex.hasMatch(state.ip) &&
                        (state.port > 0 && state.port <= 65535)) ...[
                      _buildMachineNameField(notifier, state),
                      const SizedBox(height: 8),
                      _buildEmplacementField(notifier, state),
                      const SizedBox(height: 16),
                      CreateButton(
                        onPressed: () {},
                        buttonText: "Imprimer test",
                      ),
                      const SizedBox(height: 32),
                      CreateButton(
                        onPressed: () => notifier.createImprimant(),
                        buttonText: "Enregistrer",
                      ),
                    ],
                  ],
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildDropdown(ImprimanteNotifier provider, ImprimanteState state) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
        color: Colors.grey[50],
      ),
      child: DropdownButtonFormField<TypeConnection>(
        value: state.selectedType,
        decoration: const InputDecoration(
          labelText: 'Type de connection',
          border: InputBorder.none,
        ),
        items:
            TypeConnection.values.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(
                  type.name.toUpperCase(),
                  style: AppTextStyle.indingosubHeading,
                ),
              );
            }).toList(),
        onChanged: (v) => v != null ? provider.selectType(v) : null,
      ),
    );
  }

  Widget _buildIPField(ImprimanteNotifier provider, ImprimanteState state) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator:
          (value) =>
              ipRegex.hasMatch(value ?? '') ? null : 'Invalid IP Address',
      onChanged: provider.updateIP,
      decoration: InputDecoration(
        labelText: 'Adresse IP',
        labelStyle: AppTextStyle.indingosubHeading,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildPortField(ImprimanteNotifier provider, ImprimanteState state) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.number,
      validator: (v) {
        final numberRegExp = RegExp(r'^\d+\$');
        if (!numberRegExp.hasMatch(v ?? '')) {
          return 'Le port doit être un nombre';
        }
        final port = int.tryParse(v ?? '') ?? 0;
        if (port < 1 || port > 65535) {
          return 'il faut saisir un port entre 1 et 65535';
        }
        return null;
      },
      onChanged: (v) => provider.updatePort(int.tryParse(v) ?? 0),
      decoration: InputDecoration(
        labelText: 'Port',
        labelStyle: AppTextStyle.indingosubHeading,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildEtatSwitch(ImprimanteNotifier provider, ImprimanteState state) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
        color: Colors.grey[50],
      ),
      child: ListTile(
        title: Text(
          'Etat de l\'imprimante',
          style: AppTextStyle.indingosubHeading,
        ),
        trailing: Switch(
          value: state.etat,
          activeColor: AppColors.indingo400,
          onChanged: (_) => provider.updateetat(),
        ),
      ),
    );
  }

  Widget _buildMachineNameField(
    ImprimanteNotifier provider,
    ImprimanteState state,
  ) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: provider.updateMachineName,
      decoration: InputDecoration(
        labelText: 'Nom de la machine',
        labelStyle: AppTextStyle.indingosubHeading,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildEmplacementField(
    ImprimanteNotifier provider,
    ImprimanteState state,
  ) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: provider.updateemaplacemt,
      decoration: InputDecoration(
        labelText: 'Emaplcement de la machine',
        labelStyle: AppTextStyle.indingosubHeading,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }
}

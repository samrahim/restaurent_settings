import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/roles.dart';
import 'package:restaurent/models/utilisateur_model.dart';
import 'package:restaurent/riverpods/drawer_riverpod/drawer_state.dart';
import 'package:restaurent/riverpods/riverpods.dart';
import 'package:restaurent/screens/reglage_screen.dart';
import 'package:restaurent/widgets/widgets.dart';

final roleRiverpood = StateNotifierProvider<RolesNotifier, RoleState>((ref) {
  final client = ref.watch(httpClientProvider);
  return RolesNotifier(client: client);
});
Map<String, List<UtilisateurModel>> groupUsersByRole(
  List<UtilisateurModel> users,
) {
  final Map<String, List<UtilisateurModel>> grouped = {};
  for (var user in users) {
    final role = user.role ?? "Autre";
    if (!grouped.containsKey(role)) {
      grouped[role] = [];
    }
    grouped[role]!.add(user);
  }
  return grouped;
}

final utilisateurRiverpod =
    StateNotifierProvider<UtilisateurNotifier, UtilisateurState>((ref) {
      final client = ref.watch(httpClientProvider);
      return UtilisateurNotifier(client: client);
    });

class GroupesUtilisateursScreen extends ConsumerStatefulWidget {
  const GroupesUtilisateursScreen({super.key});

  @override
  ConsumerState<GroupesUtilisateursScreen> createState() =>
      _GroupesUtilisateursScreenState();
}

class _GroupesUtilisateursScreenState
    extends ConsumerState<GroupesUtilisateursScreen> {
  UtilisateurModel createModel = UtilisateurModel(
    firstname: '',
    lastname: '',
    username: '',
    phonenumber: '',
    sex: '',
    email: '',
    motPasseSchema: '',
    pwd: '',
    dateOfBirth: '',
    codepin: '',
    role: 'SUPER_ADMIN',
  );
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final utilisateurState = ref.watch(utilisateurRiverpod);
    final utilisateurNotifier = ref.read(utilisateurRiverpod.notifier);
    final roleState = ref.watch(roleRiverpood);
    return Scaffold(
      key: _scaffoldKey,
      body: Consumer(
        builder: (context, ref, _) {
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child:
                      utilisateurState.utilisateurs.isNotEmpty
                          ? ListView(
                            children: [
                              ...groupUsersByRole(
                                utilisateurState.utilisateurs,
                              ).entries.map((entry) {
                                final role = entry.key;
                                final users = entry.value;

                                return ExpansionTile(
                                  title: Text(
                                    role,
                                    style: AppTextStyle.indingoHeading,
                                  ),
                                  children:
                                      users.map((utilisateur) {
                                        return ListTile(
                                          selectedTileColor:
                                              Colors.grey.shade300,
                                          title: Text(
                                            utilisateur.firstname ?? "",
                                            style:
                                                AppTextStyle.indingosubHeading,
                                          ),
                                          trailing: Icon(
                                            Icons.arrow_forward_ios,
                                          ),
                                          selected:
                                              utilisateurState
                                                      .selectedUtilisateur !=
                                                  null &&
                                              utilisateur.id ==
                                                  utilisateurState
                                                      .selectedUtilisateur!
                                                      .id,
                                          onTap: () {
                                            utilisateurNotifier
                                                .selectUtilisateur(utilisateur);
                                          },
                                        );
                                      }).toList(),
                                );
                              }),
                            ],
                          )
                          : Center(
                            child: Text(
                              "Aucun utilisateur trouvé",
                              style: AppTextStyle.greyHeading,
                            ),
                          ),
                ),
              ),
              Expanded(
                flex: 3,
                child:
                    utilisateurState.selectedUtilisateur != null
                        ? SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          CustomListTile(
                                            onTap: () {
                                              final container =
                                                  ProviderScope.containerOf(
                                                    context,
                                                  );
                                              container
                                                  .read(drawerRiverpod.notifier)
                                                  .openUpdateUtilisateurAttributeDrawer(
                                                    utilisateurState
                                                        .selectedUtilisateur!,
                                                    'nom',
                                                    utilisateurState
                                                        .selectedUtilisateur!
                                                        .firstname,
                                                  );

                                              _scaffoldKey.currentState
                                                  ?.openEndDrawer();
                                            },
                                            trailing: null,
                                            title: Text(
                                              'Nom',
                                              style: AppTextStyle.greyHeading,
                                            ),
                                            trailingwidget: Text(
                                              utilisateurState
                                                      .selectedUtilisateur!
                                                      .firstname ??
                                                  "",
                                              style:
                                                  AppTextStyle
                                                      .indingosubHeading,
                                            ),
                                            leading: null,
                                          ),
                                          Divider(),
                                          CustomListTile(
                                            onTap: () {
                                              final container =
                                                  ProviderScope.containerOf(
                                                    context,
                                                  );
                                              container
                                                  .read(drawerRiverpod.notifier)
                                                  .openUpdateUtilisateurAttributeDrawer(
                                                    utilisateurState
                                                        .selectedUtilisateur!,
                                                    'prenom',
                                                    utilisateurState
                                                        .selectedUtilisateur!
                                                        .lastname,
                                                  );

                                              _scaffoldKey.currentState
                                                  ?.openEndDrawer();
                                            },
                                            leading: null,
                                            trailing: null,
                                            title: Text(
                                              'Prénom',
                                              style: AppTextStyle.greyHeading,
                                            ),
                                            trailingwidget: Text(
                                              utilisateurState
                                                      .selectedUtilisateur!
                                                      .lastname ??
                                                  "",
                                              style:
                                                  AppTextStyle
                                                      .indingosubHeading,
                                            ),
                                          ),
                                          Divider(),

                                          CustomListTile(
                                            onTap: () {
                                              final container =
                                                  ProviderScope.containerOf(
                                                    context,
                                                  );
                                              container
                                                  .read(drawerRiverpod.notifier)
                                                  .openUpdateUtilisateurAttributeDrawer(
                                                    utilisateurState
                                                        .selectedUtilisateur!,
                                                    'role',
                                                    utilisateurState
                                                        .selectedUtilisateur!
                                                        .role,
                                                  );

                                              _scaffoldKey.currentState
                                                  ?.openEndDrawer();
                                            },
                                            leading: null,
                                            trailing: null,
                                            title: Text(
                                              'Role',
                                              style: AppTextStyle.greyHeading,
                                            ),
                                            trailingwidget: Text(
                                              utilisateurState
                                                      .selectedUtilisateur!
                                                      .role ??
                                                  "",
                                              style:
                                                  AppTextStyle
                                                      .indingosubHeading,
                                            ),
                                          ),

                                          Divider(),
                                          CustomListTile(
                                            onTap: () {
                                              final container =
                                                  ProviderScope.containerOf(
                                                    context,
                                                  );
                                              container
                                                  .read(drawerRiverpod.notifier)
                                                  .openUpdateUtilisateurAttributeDrawer(
                                                    utilisateurState
                                                        .selectedUtilisateur!,
                                                    'phone',
                                                    utilisateurState
                                                        .selectedUtilisateur!
                                                        .phonenumber,
                                                  );

                                              _scaffoldKey.currentState
                                                  ?.openEndDrawer();
                                            },
                                            leading: null,
                                            trailing: null,
                                            title: Text(
                                              'Téléphone',
                                              style: AppTextStyle.greyHeading,
                                            ),
                                            trailingwidget: Text(
                                              utilisateurState
                                                      .selectedUtilisateur!
                                                      .phonenumber ??
                                                  "",
                                              style:
                                                  AppTextStyle
                                                      .indingosubHeading,
                                            ),
                                          ),
                                          Divider(),
                                          CustomListTile(
                                            onTap: () {
                                              final container =
                                                  ProviderScope.containerOf(
                                                    context,
                                                  );
                                              container
                                                  .read(drawerRiverpod.notifier)
                                                  .openUpdateUtilisateurAttributeDrawer(
                                                    utilisateurState
                                                        .selectedUtilisateur!,
                                                    'dateOfBirth',
                                                    utilisateurState
                                                        .selectedUtilisateur!
                                                        .dateOfBirth,
                                                  );

                                              _scaffoldKey.currentState
                                                  ?.openEndDrawer();
                                            },
                                            leading: null,
                                            trailing: null,
                                            title: Text(
                                              'Age',
                                              style: AppTextStyle.greyHeading,
                                            ),
                                            trailingwidget: Text(
                                              utilisateurState
                                                          .selectedUtilisateur!
                                                          .dateOfBirth !=
                                                      null
                                                  ? "${DateTime.now().year - int.parse(utilisateurState.selectedUtilisateur!.dateOfBirth!.split('-').first)}"
                                                  : "Non définie",
                                              style:
                                                  AppTextStyle
                                                      .indingosubHeading,
                                            ),
                                          ),
                                          Divider(),
                                          CustomListTile(
                                            onTap: () {
                                              final container =
                                                  ProviderScope.containerOf(
                                                    context,
                                                  );
                                              container
                                                  .read(drawerRiverpod.notifier)
                                                  .openUpdateUtilisateurAttributeDrawer(
                                                    utilisateurState
                                                        .selectedUtilisateur!,
                                                    'email',
                                                    utilisateurState
                                                        .selectedUtilisateur!
                                                        .email,
                                                  );

                                              _scaffoldKey.currentState
                                                  ?.openEndDrawer();
                                            },
                                            leading: null,
                                            trailing: null,
                                            title: Text(
                                              'Email',
                                              style: AppTextStyle.greyHeading,
                                            ),
                                            trailingwidget: Text(
                                              utilisateurState
                                                      .selectedUtilisateur!
                                                      .email ??
                                                  "",
                                              style:
                                                  AppTextStyle
                                                      .indingosubHeading,
                                            ),
                                          ),
                                          Divider(),
                                          CustomListTile(
                                            onTap: () {
                                              final container =
                                                  ProviderScope.containerOf(
                                                    context,
                                                  );
                                              container
                                                  .read(drawerRiverpod.notifier)
                                                  .openUpdateUtilisateurAttributeDrawer(
                                                    utilisateurState
                                                        .selectedUtilisateur!,
                                                    'motPasseSchema',
                                                    utilisateurState
                                                        .selectedUtilisateur!
                                                        .motPasseSchema,
                                                  );

                                              _scaffoldKey.currentState
                                                  ?.openEndDrawer();
                                            },
                                            leading: null,
                                            trailing: null,
                                            title: Text(
                                              'Mot de passe schema',
                                              style: AppTextStyle.greyHeading,
                                            ),
                                            trailingwidget: Text(
                                              "*****",
                                              style:
                                                  AppTextStyle
                                                      .indingosubHeading,
                                            ),
                                          ),
                                          Divider(),
                                          CustomListTile(
                                            onTap: () {
                                              final container =
                                                  ProviderScope.containerOf(
                                                    context,
                                                  );
                                              container
                                                  .read(drawerRiverpod.notifier)
                                                  .openUpdateUtilisateurAttributeDrawer(
                                                    utilisateurState
                                                        .selectedUtilisateur!,
                                                    'motPasseChiffre',
                                                    utilisateurState
                                                        .selectedUtilisateur!
                                                        .pwd,
                                                  );

                                              _scaffoldKey.currentState
                                                  ?.openEndDrawer();
                                            },
                                            leading: null,
                                            trailing: null,
                                            title: Text(
                                              'Mot de passe chiffre',
                                              style: AppTextStyle.greyHeading,
                                            ),
                                            trailingwidget: Text(
                                              "*****",
                                              style:
                                                  AppTextStyle
                                                      .indingosubHeading,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    ButtonSupprimer(
                                      onTap: () {},
                                      text: 'Supprimer',
                                      style: null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        : Center(
                          child: Text(
                            "Sélectionnez un utilisateur",
                            style: AppTextStyle.greyHeading,
                          ),
                        ),
              ),
            ],
          );
        },
      ),
      endDrawer: Consumer(
        builder: (context, drawerProvider, _) {
          final state = ref.watch(drawerRiverpod);

          if (state is DrawerCreateUtilisateur && !roleState.isLoading!) {
            return _buildCreateUtilisateurDrawer(context, roleState);
          }
          if (state is DrawerUpdateUtilisateurAttributeState) {
            return UpdateAttributeDrawer(
              fieldType:
                  state.attributeName == "motPasseSchema"
                      ? FieldType.pattern
                      : FieldType.string,
              label: state.attributeName,
              initialValue: state.currentValue as String,
              onSaved: (value) {
                // final updated = state.utilisateur.copyWith(
                //   nom:
                //       state.attributeName == 'nom'
                //           ? value
                //           : state.utilisateur.nom,
                //   prenom:
                //       state.attributeName == 'prenom'
                //           ? value
                //           : state.utilisateur.prenom,
                //   groupe:
                //       state.attributeName == 'groupe'
                //           ? value
                //           : state.utilisateur.groupe,
                //   role:
                //       state.attributeName == 'role'
                //           ? value
                //           : state.utilisateur.role,
                //   motPasseSchema:
                //       state.attributeName == 'motPasseSchema'
                //           ? value
                //           : state.utilisateur.motPasseSchema,
                //   motPasseChiffre:
                //       state.attributeName == 'motPasseChiffre'
                //           ? value
                //           : state.utilisateur.motPasseChiffre,
                //   qrCode:
                //       state.attributeName == 'qrCode'
                //           ? value
                //           : state.utilisateur.qrCode,
                // );

                // utilisateurNotifier.updateUtilisateur(updated);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Groupes utilisateurs',
          style: AppTextStyle.largeindingotext,
        ),
        centerTitle: true,
        actions: [
          ActionButton(onPressed: () {}, text: 'Reorganiser'),
          ActionButton(
            onPressed: () {
              final container = ProviderScope.containerOf(context);
              container
                  .read(drawerRiverpod.notifier)
                  .openCreateUtilisateurDrawer(createModel);

              _scaffoldKey.currentState?.openEndDrawer();
            },
            text: 'Nouveau',
          ),
        ],
      ),
    );
  }

  Widget _buildCreateUtilisateurDrawer(BuildContext context, RoleState state) {
    final drawerState = ref.watch(drawerRiverpod);

    final createModel = (drawerState as DrawerCreateUtilisateur).model;

    return !state.isLoading!
        ? Drawer(
          width: MediaQuery.of(context).size.width * .33,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.0),
                      child: Text(
                        'Créer un nouveau utilisateur',
                        style: AppTextStyle.indingoHeading,
                      ),
                    ),

                    TextFormField(
                      initialValue: createModel.firstname,
                      decoration: InputDecoration(
                        labelStyle: AppTextStyle.indingosubHeading,
                        labelText: 'Nom',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      onChanged: (v) {
                        final container = ProviderScope.containerOf(context);
                        container
                            .read(drawerRiverpod.notifier)
                            .openCreateUtilisateurDrawer(
                              createModel.copyWith(firstname: v),
                            );
                      },
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      initialValue: createModel.lastname,
                      decoration: InputDecoration(
                        labelStyle: AppTextStyle.indingosubHeading,
                        labelText: 'Prénom',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      onChanged: (v) {
                        final container = ProviderScope.containerOf(context);
                        container
                            .read(drawerRiverpod.notifier)
                            .openCreateUtilisateurDrawer(
                              createModel.copyWith(lastname: v),
                            );
                      },
                    ),

                    const SizedBox(height: 16),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade400),
                        color: Colors.grey[50],
                      ),
                      child: DropdownButtonFormField<String>(
                        value:
                            createModel.role == ""
                                ? state.roles!.first.toString()
                                : createModel.role,
                        decoration: const InputDecoration(
                          labelText: 'Role',
                          border: InputBorder.none,
                        ),
                        items:
                            state.roles!
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e.name,
                                    child: Text(
                                      e.name,
                                      style: AppTextStyle.indingosubHeading,
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            final container = ProviderScope.containerOf(
                              context,
                            );
                            container
                                .read(drawerRiverpod.notifier)
                                .openCreateUtilisateurDrawer(
                                  createModel.copyWith(role: value),
                                );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: createModel.phonenumber,
                      decoration: InputDecoration(
                        labelStyle: AppTextStyle.indingosubHeading,
                        labelText: 'Telephone',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      onChanged: (v) {
                        final container = ProviderScope.containerOf(context);
                        container
                            .read(drawerRiverpod.notifier)
                            .openCreateUtilisateurDrawer(
                              createModel.copyWith(phonenumber: v),
                            );
                      },
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: ListTile(
                        title: Text(
                          'Date de naissance',
                          style: AppTextStyle.indingosubHeading,
                        ),
                        trailing: Text(
                          createModel.dateOfBirth == ''
                              ? "--:--"
                              : createModel.dateOfBirth!,
                          style: AppTextStyle.indingosubHeading,
                        ),
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            initialEntryMode: DatePickerEntryMode.inputOnly,
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null && context.mounted) {
                            final container = ProviderScope.containerOf(
                              context,
                            );
                            container
                                .read(drawerRiverpod.notifier)
                                .openCreateUtilisateurDrawer(
                                  createModel.copyWith(
                                    dateOfBirth:
                                        "${picked.year}-${picked.month}-${picked.day}",
                                  ),
                                );
                          }
                          print(createModel.dateOfBirth);
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: createModel.pwd,
                      decoration: InputDecoration(
                        labelStyle: AppTextStyle.indingosubHeading,
                        labelText: 'Mot de passe',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      onChanged: (v) {
                        final container = ProviderScope.containerOf(context);
                        container
                            .read(drawerRiverpod.notifier)
                            .openCreateUtilisateurDrawer(
                              createModel.copyWith(pwd: v),
                            );
                      },
                    ),

                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: createModel.email,
                      decoration: InputDecoration(
                        labelStyle: AppTextStyle.indingosubHeading,
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      onChanged: (v) {
                        final container = ProviderScope.containerOf(context);
                        container
                            .read(drawerRiverpod.notifier)
                            .openCreateUtilisateurDrawer(
                              createModel.copyWith(email: v),
                            );
                      },
                    ),

                    const SizedBox(height: 24),
                    CreateButton(
                      onPressed: () {
                        print(createModel.toJson());
                        final container = ProviderScope.containerOf(context);
                        container
                            .read(utilisateurRiverpod.notifier)
                            .createUtilisateur(newUser: createModel);
                        _scaffoldKey.currentState?.closeEndDrawer();
                      },
                      buttonText: "Ajouter",
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        : Center(child: CircularProgressIndicator());
  }
}

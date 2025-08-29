import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/utilisateur_model.dart';
import 'package:restaurent/riverpods/drawer_riverpod/drawer_state.dart';
import 'package:restaurent/riverpods/riverpods.dart';
import 'package:restaurent/screens/reglage_screen.dart';
import 'package:restaurent/widgets/widgets.dart';

final roleRiverpood = StateNotifierProvider<RolesNotifier, RoleState>((ref) {
  final client = ref.watch(httpClientProvider);
  return RolesNotifier(client: client);
});

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
    sexe: 1,
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
                              ...utilisateurState.utilisateurs.map((
                                utilisateur,
                              ) {
                                return ListTile(
                                  selectedTileColor: Colors.grey.shade300,
                                  title: Text(
                                    utilisateur.firstname ?? "",
                                    style: AppTextStyle.indingosubHeading,
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  selected:
                                      utilisateurState.selectedUtilisateur !=
                                          null &&
                                      utilisateur.id ==
                                          utilisateurState
                                              .selectedUtilisateur!
                                              .id,
                                  onTap: () {
                                    utilisateurNotifier.selectUtilisateur(
                                      utilisateur,
                                    );
                                  },
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
                                                    'firstname',
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
                                                    'lastname',
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
                                            onTap: null,
                                            leading: null,
                                            trailing: null,
                                            title: Text(
                                              'Nom d\'utilisateur',
                                              style: AppTextStyle.greyHeading,
                                            ),
                                            trailingwidget: Text(
                                              utilisateurState
                                                      .selectedUtilisateur!
                                                      .username ??
                                                  "",
                                              style:
                                                  AppTextStyle
                                                      .indingosubHeading,
                                            ),
                                          ),
                                          Divider(),
                                          CustomListTile(
                                            onTap: null,
                                            leading: null,
                                            trailing: null,
                                            title: Text(
                                              'Sexe',
                                              style: AppTextStyle.greyHeading,
                                            ),
                                            trailingwidget: Text(
                                              utilisateurState
                                                          .selectedUtilisateur!
                                                          .sexe ==
                                                      1
                                                  ? "Homme"
                                                  : "Femme",
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
                                                    'phonenumber',
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
                                            onTap: null,
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
                                                            .motPasseSchema ??
                                                        "",
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
                                                    'pwd',
                                                    utilisateurState
                                                            .selectedUtilisateur!
                                                            .pwd ??
                                                        "",
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
            switch (state.attributeName) {
              case "motPasseSchema":
                return UpdateAttributeDrawer(
                  fieldType: FieldType.pattern,
                  initialValue: state.currentValue as String,
                  label: "mot Passe Schema",
                  onSaved: (val) {
                    final updated = state.utilisateur.copyWith(
                      motPasseSchema: val,
                    );
                    utilisateurNotifier.updateUtilisateur(updated);
                  },
                );

              case "firstname":
                return UpdateAttributeDrawer(
                  fieldType: FieldType.string,
                  initialValue: state.currentValue as String,
                  label: "Nom",
                  onSaved: (val) {
                    final updated = state.utilisateur.copyWith(firstname: val);
                    utilisateurNotifier.updateUtilisateur(updated);
                  },
                );

              case "lastname":
                return UpdateAttributeDrawer(
                  fieldType: FieldType.string,
                  initialValue: state.currentValue as String,
                  label: "Prenom",
                  onSaved: (val) {
                    final updated = state.utilisateur.copyWith(lastname: val);
                    utilisateurNotifier.updateUtilisateur(updated);
                  },
                );

              case "role":
                return UpdateAttributeDrawer(
                  fieldType: FieldType.dropdown,
                  options: roleState.roles?.map((e) => e.name).toList(),
                  initialValue: state.currentValue as String,
                  label: "role",
                  onSaved: (val) {
                    final updated = state.utilisateur.copyWith(role: val);
                    utilisateurNotifier.updateUtilisateur(updated);
                  },
                );

              case "pwd":
                return UpdateAttributeDrawer(
                  fieldType: FieldType.string,

                  initialValue: state.currentValue as String,
                  label: "mot de passe",
                  onSaved: (val) {
                    final updated = state.utilisateur.copyWith(pwd: val);
                    utilisateurNotifier.updateUtilisateur(updated);
                  },
                );

              case "phonenumber":
                return UpdateAttributeDrawer(
                  fieldType: FieldType.string,
                  initialValue: state.currentValue as String,
                  label: "phonenumber",
                  onSaved: (val) {
                    final updated = state.utilisateur.copyWith(
                      phonenumber: val,
                    );
                    utilisateurNotifier.updateUtilisateur(updated);
                  },
                );

              case "email":
                return UpdateAttributeDrawer(
                  fieldType: FieldType.string,

                  initialValue: state.currentValue as String,
                  label: "email",
                  onSaved: (val) {
                    final updated = state.utilisateur.copyWith(email: val);
                    utilisateurNotifier.updateUtilisateur(updated);
                  },
                );

              case "dateOfBirth":
                return UpdateAttributeDrawer(
                  fieldType: FieldType.datePicker,

                  initialValue: state.currentValue as String,
                  label: "dateOfBirth",
                  onSaved: (val) {
                    print(val);
                    print(val is String);
                    final updated = state.utilisateur.copyWith(
                      dateOfBirth: val,
                    );
                    utilisateurNotifier.updateUtilisateur(updated);
                  },
                );

              default:
            }
          }
          return const SizedBox.shrink();
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Groupes utilisateurs', style: AppTextStyle.indingoHeading),
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
                    TextFormField(
                      initialValue: createModel.username,
                      decoration: InputDecoration(
                        labelStyle: AppTextStyle.indingosubHeading,
                        labelText: 'Nom d\'utilisateur',
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
                              createModel.copyWith(username: v),
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
                                ? state.roles!.first.name
                                : createModel.role,
                        decoration: const InputDecoration(
                          labelText: 'Role',
                          border: InputBorder.none,
                        ),
                        items: [
                          ...state.roles!.map(
                            (e) => DropdownMenuItem(
                              value: e.name,
                              child: Text(
                                e.name,
                                style: AppTextStyle.indingosubHeading,
                              ),
                            ),
                          ),

                          const DropdownMenuItem(
                            value: "__create_role__",
                            child: Row(
                              children: [
                                Icon(Icons.add, color: Colors.blue),
                                SizedBox(width: 8),
                                Text("Create Role"),
                              ],
                            ),
                          ),
                        ],
                        onChanged: (value) async {
                          if (value == "__create_role__") {
                            final newRole = await showDialog<String>(
                              context: context,
                              builder: (ctx) {
                                final controller = TextEditingController();
                                return AlertDialog(
                                  title: const Text("Create Role"),
                                  content: TextField(
                                    controller: controller,
                                    decoration: const InputDecoration(
                                      labelText: "Role name",
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx),
                                      child: const Text("Cancel"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (controller.text.isNotEmpty) {
                                          Navigator.pop(ctx, controller.text);
                                        }
                                      },
                                      child: const Text("Save"),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (newRole != null) {
                              final container = ProviderScope.containerOf(
                                context,
                              );
                              container
                                  .read(roleRiverpood.notifier)
                                  .addRole(name: newRole, description: '');

                              container
                                  .read(drawerRiverpod.notifier)
                                  .openCreateUtilisateurDrawer(
                                    createModel.copyWith(role: newRole),
                                  );
                            }
                          } else if (value != null) {
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
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade400),
                        color: Colors.grey[50],
                      ),
                      child: DropdownButtonFormField(
                        value: createModel.sexe,

                        decoration: const InputDecoration(
                          labelText: 'Sexe',
                          border: InputBorder.none,
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 1,
                            child: Text(
                              "Homme",
                              style: AppTextStyle.indingosubHeading,
                            ),
                          ),
                          DropdownMenuItem(
                            value: 0,
                            child: Text(
                              "Femme",
                              style: AppTextStyle.indingosubHeading,
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            final container = ProviderScope.containerOf(
                              context,
                            );
                            container
                                .read(drawerRiverpod.notifier)
                                .openCreateUtilisateurDrawer(
                                  createModel.copyWith(sexe: value),
                                );
                          }
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

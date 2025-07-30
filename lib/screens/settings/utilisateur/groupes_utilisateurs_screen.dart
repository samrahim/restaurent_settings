import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/utilisateur_model.dart';
import 'package:restaurent/screens/reglage_screen.dart';
import 'package:restaurent/widgets/widgets.dart';

class GroupesUtilisateursScreen extends ConsumerStatefulWidget {
  const GroupesUtilisateursScreen({super.key});

  @override
  ConsumerState<GroupesUtilisateursScreen> createState() =>
      _GroupesUtilisateursScreenState();
}

class _GroupesUtilisateursScreenState
    extends ConsumerState<GroupesUtilisateursScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController groupe = TextEditingController();
  TextEditingController motPasseSchema = TextEditingController();
  TextEditingController motPasseChiffre = TextEditingController();
  TextEditingController qrCode = TextEditingController();
  String role = roleList[0];
  String group = groupeList[0];
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nom.dispose();
    prenom.dispose();
    groupe.dispose();
    motPasseSchema.dispose();
    motPasseChiffre.dispose();
    qrCode.dispose();
    super.dispose();
  }

  Widget _buildCreateUtilisateurDrawer(BuildContext context) {
    final utilisateurNotifier = ref.read(utilisateurRiverpod.notifier);

    return Drawer(
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

                CustomTextField(
                  controller: nom,
                  label: "Nom",
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le nom d\'utilisateur est requis';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: prenom,
                  label: "Prénom",
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le prénom d\'utilisateur est requis';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Dropdown Groupe
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400),
                    color: Colors.grey[50],
                  ),
                  child: DropdownButtonFormField<String>(
                    value: group,
                    decoration: const InputDecoration(
                      labelText: 'Groupe',
                      border: InputBorder.none,
                    ),
                    items:
                        groupeList
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          group = value;
                        });
                      }
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Dropdown Role
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400),
                    color: Colors.grey[50],
                  ),
                  child: DropdownButtonFormField<String>(
                    value: role,
                    decoration: const InputDecoration(
                      labelText: 'Role',
                      border: InputBorder.none,
                    ),
                    items:
                        roleList
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          role = value;
                        });
                      }
                    },
                  ),
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  controller: motPasseSchema,
                  label: "Mot de passe schema",
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le mot de passe schema est requis';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  controller: motPasseChiffre,
                  label: "Mot de passe chiffre",
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le mot de passe chiffre est requis';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  controller: qrCode,
                  label: "QR Code",
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le QR Code est requis';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),
                CreateButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      utilisateurNotifier.createUtilisateur(
                        groupe: group,
                        motPasseChiffre: motPasseChiffre.text,
                        nom: nom.text,
                        prenom: prenom.text,
                        qrCode: qrCode.text,
                        role: role,
                        motPasseSchema: motPasseSchema.text,
                      );
                      _scaffoldKey.currentState?.closeEndDrawer();
                    }
                  },
                  buttonText: "Ajouter",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final utilisateurState = ref.watch(utilisateurRiverpod);
    final utilisateurNotifier = ref.read(utilisateurRiverpod.notifier);

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
                              utilisateurState.utilisateurs
                                      .where((e) => e.role == "Administrateur")
                                      .isNotEmpty
                                  ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Administrateurs',
                                      style: AppTextStyle.greyHeading.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                  : SizedBox.shrink(),
                              ...utilisateurState.utilisateurs
                                  .where((u) => u.role == roleList[0])
                                  .map(
                                    (utilisateur) => ListTile(
                                      selectedTileColor: Colors.grey.shade300,
                                      title: Text(
                                        utilisateur.nom,
                                        style: AppTextStyle.indingosubHeading,
                                      ),
                                      trailing: Icon(Icons.arrow_forward_ios),
                                      selected:
                                          utilisateurState
                                                  .selectedUtilisateur !=
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
                                    ),
                                  ),

                              utilisateurState.utilisateurs
                                      .where((e) => e.role == "Serveur")
                                      .isNotEmpty
                                  ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Serveurs',
                                      style: AppTextStyle.greyHeading.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                  : SizedBox.shrink(),
                              ...utilisateurState.utilisateurs
                                  .where((u) => u.role == roleList[1])
                                  .map(
                                    (utilisateur) => ListTile(
                                      selectedTileColor: Colors.grey.shade300,
                                      title: Text(
                                        utilisateur.nom,
                                        style: AppTextStyle.indingosubHeading,
                                      ),
                                      trailing: Icon(Icons.arrow_forward_ios),
                                      selected:
                                          utilisateurState
                                                  .selectedUtilisateur !=
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
                                    ),
                                  ),
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
                        ? Card(
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
                                            context
                                                .read<DrawerProvider>()
                                                .openUpdateUtilisateurAttributeDrawer(
                                                  utilisateurState
                                                      .selectedUtilisateur!,
                                                  'nom',
                                                  utilisateurState
                                                      .selectedUtilisateur!
                                                      .nom,
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
                                                .nom!,
                                            style:
                                                AppTextStyle.indingosubHeading,
                                          ),
                                          leading: null,
                                        ),
                                        Divider(),
                                        CustomListTile(
                                          onTap: () {
                                            context
                                                .read<DrawerProvider>()
                                                .openUpdateUtilisateurAttributeDrawer(
                                                  utilisateurState
                                                      .selectedUtilisateur!,
                                                  'prenom',
                                                  utilisateurState
                                                      .selectedUtilisateur!
                                                      .prenom,
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
                                                .prenom!,
                                            style:
                                                AppTextStyle.indingosubHeading,
                                          ),
                                        ),
                                        Divider(),
                                        CustomListTile(
                                          onTap: () {
                                            context
                                                .read<DrawerProvider>()
                                                .openUpdateUtilisateurAttributeDrawer(
                                                  utilisateurState
                                                      .selectedUtilisateur!,
                                                  'groupe',
                                                  utilisateurState
                                                      .selectedUtilisateur!
                                                      .groupe,
                                                );
                                            _scaffoldKey.currentState
                                                ?.openEndDrawer();
                                          },
                                          leading: null,
                                          trailing: null,
                                          title: Text(
                                            'Groupe',
                                            style: AppTextStyle.greyHeading,
                                          ),
                                          trailingwidget: Text(
                                            utilisateurState
                                                .selectedUtilisateur!
                                                .groupe!,
                                            style:
                                                AppTextStyle.indingosubHeading,
                                          ),
                                        ),
                                        Divider(),
                                        CustomListTile(
                                          onTap: () {
                                            context
                                                .read<DrawerProvider>()
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
                                                .role!,
                                            style:
                                                AppTextStyle.indingosubHeading,
                                          ),
                                        ),
                                        Divider(),
                                        CustomListTile(
                                          onTap: () {
                                            context
                                                .read<DrawerProvider>()
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
                                            utilisateurState
                                                .selectedUtilisateur!
                                                .motPasseSchema!,
                                            style:
                                                AppTextStyle.indingosubHeading,
                                          ),
                                        ),
                                        Divider(),
                                        CustomListTile(
                                          onTap: () {
                                            context
                                                .read<DrawerProvider>()
                                                .openUpdateUtilisateurAttributeDrawer(
                                                  utilisateurState
                                                      .selectedUtilisateur!,
                                                  'motPasseChiffre',
                                                  utilisateurState
                                                      .selectedUtilisateur!
                                                      .motPasseChiffre,
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
                                            utilisateurState
                                                .selectedUtilisateur!
                                                .motPasseChiffre!,
                                            style:
                                                AppTextStyle.indingosubHeading,
                                          ),
                                        ),
                                        Divider(),
                                        CustomListTile(
                                          onTap: () {
                                            context
                                                .read<DrawerProvider>()
                                                .openUpdateUtilisateurAttributeDrawer(
                                                  utilisateurState
                                                      .selectedUtilisateur!,
                                                  'qrCode',
                                                  utilisateurState
                                                      .selectedUtilisateur!
                                                      .qrCode,
                                                );
                                            _scaffoldKey.currentState
                                                ?.openEndDrawer();
                                          },
                                          leading: null,
                                          trailing: null,
                                          title: Text(
                                            'QR Code',
                                            style: AppTextStyle.greyHeading,
                                          ),
                                          trailingwidget: Text(
                                            utilisateurState
                                                .selectedUtilisateur!
                                                .qrCode!,
                                            style:
                                                AppTextStyle.indingosubHeading,
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
      endDrawer: provider_package.Consumer<DrawerProvider>(
        builder: (context, drawerProvider, _) {
          final state = drawerProvider.state;
          if (state is DrawerCreateUtilisateur) {
            return _buildCreateUtilisateurDrawer(context);
          }
          if (state is DrawerUpdateUtilisateurAttributeState) {
            return UpdateAttributeDrawer(
              fieldType: FieldType.string,
              label: state.attributeName,
              initialValue: state.currentValue as String,
              onSaved: (value) {
                final updated = state.utilisateur.copyWith(
                  nom:
                      state.attributeName == 'nom'
                          ? value
                          : state.utilisateur.nom,
                  prenom:
                      state.attributeName == 'prenom'
                          ? value
                          : state.utilisateur.prenom,
                  groupe:
                      state.attributeName == 'groupe'
                          ? value
                          : state.utilisateur.groupe,
                  role:
                      state.attributeName == 'role'
                          ? value
                          : state.utilisateur.role,
                  motPasseSchema:
                      state.attributeName == 'motPasseSchema'
                          ? value
                          : state.utilisateur.motPasseSchema,
                  motPasseChiffre:
                      state.attributeName == 'motPasseChiffre'
                          ? value
                          : state.utilisateur.motPasseChiffre,
                  qrCode:
                      state.attributeName == 'qrCode'
                          ? value
                          : state.utilisateur.qrCode,
                );
                utilisateurNotifier.updateUtilisateur(updated);
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
              context.read<DrawerProvider>().openCreateUtilisateurDrawer();
              _scaffoldKey.currentState?.openEndDrawer();
            },
            text: 'Nouveau',
          ),
        ],
      ),
    );
  }
}

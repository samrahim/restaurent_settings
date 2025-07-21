import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/utilisateur_model.dart';
import 'package:restaurent/providers/providers.dart';
import 'package:restaurent/widgets/widgets.dart';

class GroupesUtilisateursScreen extends StatefulWidget {
  const GroupesUtilisateursScreen({super.key});

  @override
  State<GroupesUtilisateursScreen> createState() =>
      _GroupesUtilisateursScreenState();
}

class _GroupesUtilisateursScreenState extends State<GroupesUtilisateursScreen> {
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Créer un nouveau utilisateur',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                              (grp) => DropdownMenuItem(
                                value: grp,
                                child: Text(grp),
                              ),
                            )
                            .toList(),
                    onChanged: (value) => setState(() => group = value!),
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: motPasseChiffre,
                  label: "Mot de passe chiffre",
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le mot de passe est requis';
                    }
                    if (!RegExp(r'^-?\d+$').hasMatch(value)) {
                      return 'Minimum entier de 8 chaine';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400),
                    color: Colors.grey[50],
                  ),
                  child: DropdownButtonFormField<String>(
                    value: role,
                    decoration: const InputDecoration(
                      labelText: 'Rôle',
                      border: InputBorder.none,
                    ),
                    items:
                        roleList
                            .map(
                              (r) => DropdownMenuItem(value: r, child: Text(r)),
                            )
                            .toList(),
                    onChanged: (value) => setState(() => role = value!),
                  ),
                ),

                const SizedBox(height: 24),
                CreateButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final provider = context.read<UtilisateurProvider>();
                      provider.createUtilisateur(
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
    return Scaffold(
      key: _scaffoldKey,
      body: Consumer<UtilisateurProvider>(
        builder: (context, provider, _) {
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child:
                      provider.utilisateurs != null
                          ? ListView(
                            children: [
                              provider.utilisateurs!
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
                              ...provider.utilisateurs!
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
                                          provider.selectedUtilisateur !=
                                              null &&
                                          utilisateur.id ==
                                              provider.selectedUtilisateur!.id,
                                      onTap: () {
                                        Provider.of<UtilisateurProvider>(
                                          context,
                                          listen: false,
                                        ).selectUtilisateur(utilisateur);
                                      },
                                    ),
                                  ),

                              provider.utilisateurs!
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
                              ...provider.utilisateurs!
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
                                          provider.selectedUtilisateur !=
                                              null &&
                                          utilisateur.id ==
                                              provider.selectedUtilisateur!.id,
                                      onTap: () {
                                        Provider.of<UtilisateurProvider>(
                                          context,
                                          listen: false,
                                        ).selectUtilisateur(utilisateur);
                                      },
                                    ),
                                  ),

                              provider.utilisateurs!
                                      .where(
                                        (e) => e.role == "Responsable de salle",
                                      )
                                      .isNotEmpty
                                  ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Responsable de salle',
                                      style: AppTextStyle.greyHeading.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                  : SizedBox.shrink(),
                              ...provider.utilisateurs!
                                  .where((u) => u.role == roleList[2])
                                  .map(
                                    (utilisateur) => ListTile(
                                      selectedTileColor: Colors.grey.shade300,
                                      title: Text(
                                        utilisateur.nom,
                                        style: AppTextStyle.indingosubHeading,
                                      ),
                                      trailing: Icon(Icons.arrow_forward_ios),
                                      selected:
                                          provider.selectedUtilisateur !=
                                              null &&
                                          utilisateur.id ==
                                              provider.selectedUtilisateur!.id,
                                      onTap: () {
                                        Provider.of<UtilisateurProvider>(
                                          context,
                                          listen: false,
                                        ).selectUtilisateur(utilisateur);
                                      },
                                    ),
                                  ),
                            ],
                          )
                          : Center(child: Text("Aucun utilisateur trouvé")),
                ),
              ),

              Expanded(
                flex: 4,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child:
                        provider.selectedUtilisateur == null
                            ? const Center(
                              child: Text('Sélectionnez un utilisateur'),
                            )
                            : Padding(
                              padding: const EdgeInsets.all(16),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      child: Column(
                                        children: [
                                          _buildUserDetailTile(
                                            title: 'Nom',
                                            value:
                                                provider
                                                    .selectedUtilisateur!
                                                    .nom,
                                            user: provider.selectedUtilisateur!,
                                            attributeName: 'nom',
                                          ),
                                          const Divider(),
                                          _buildUserDetailTile(
                                            title: 'Prénom',
                                            value:
                                                provider
                                                    .selectedUtilisateur!
                                                    .prenom,
                                            user: provider.selectedUtilisateur!,
                                            attributeName: 'prenom',
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Card(
                                      child: _buildUserDetailTile(
                                        title: 'Groupe',
                                        value:
                                            provider
                                                .selectedUtilisateur!
                                                .groupe,
                                        user: provider.selectedUtilisateur!,
                                        attributeName: 'groupe',
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Card(
                                      child: Column(
                                        children: [
                                          _buildUserDetailTile(
                                            title: 'Mot de passe Schema',
                                            value:
                                                provider
                                                    .selectedUtilisateur!
                                                    .motPasseSchema,
                                            user: provider.selectedUtilisateur!,
                                            attributeName: 'motPasseSchema',
                                          ),
                                          const Divider(),
                                          _buildUserDetailTile(
                                            title: 'Mot de passe chiffre',
                                            value:
                                                provider
                                                    .selectedUtilisateur!
                                                    .motPasseChiffre,
                                            user: provider.selectedUtilisateur!,
                                            attributeName: 'motPasseChiffre',
                                          ),
                                          const Divider(),
                                          _buildUserDetailTile(
                                            title: 'QR Code',
                                            value:
                                                provider
                                                    .selectedUtilisateur!
                                                    .qrCode,
                                            user: provider.selectedUtilisateur!,
                                            attributeName: 'qrCode',
                                          ),
                                          const Divider(),
                                          _buildUserDetailTile(
                                            title: 'Rôle',
                                            value:
                                                provider
                                                    .selectedUtilisateur!
                                                    .role,
                                            user: provider.selectedUtilisateur!,
                                            attributeName: 'role',
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 16),

                                    ButtonSupprimer(
                                      style: null,
                                      onTap: () {},
                                      text: 'Supprimer',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                  ),
                ),
              ),
            ],
          );
        },
      ),

      appBar: AppBar(
        title: Text(
          "Groupe d'utilisateurs",
          style: AppTextStyle.largeindingotext,
        ),
        centerTitle: true,
        actions: [
          ActionButton(
            onPressed: () {
              context.read<DrawerProvider>().openCreateUtilisateurDrawer();
              _scaffoldKey.currentState?.openEndDrawer();
            },
            text: "Nouveau",
          ),
        ],
      ),
      endDrawer: Consumer<DrawerProvider>(
        builder: (context, drawerProvider, _) {
          final state = drawerProvider.state;
          if (state is DrawerCreateUtilisateur) {
            return _buildCreateUtilisateurDrawer(context);
          } else if (state is DrawerUpdateUtilisateurAttributeState) {
            return _buildUpdateAttributeDrawer(context, state);
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildUpdateAttributeDrawer(
    BuildContext context,
    DrawerUpdateUtilisateurAttributeState state,
  ) {
    switch (state.attributeName) {
      case 'role':
        return UpdateAttributeDrawer(
          label: state.attributeName,
          initialValue: state.utilisateur.role,
          options: roleList,
          fieldType: FieldType.dropdown,
          onSaved: (v) {
            Provider.of<UtilisateurProvider>(
              context,
              listen: false,
            ).updateUtilisateur(state.utilisateur.copyWith(role: v));
          },
        );

      case 'motPasseChiffre':
        return UpdateAttributeDrawer(
          label: state.attributeName,
          initialValue: state.utilisateur.motPasseChiffre,

          fieldType: FieldType.string,
          onSaved: (v) {
            Provider.of<UtilisateurProvider>(
              context,
              listen: false,
            ).updateUtilisateur(state.utilisateur.copyWith(motPasseChiffre: v));
          },
        );

      case 'groupe':
        return UpdateAttributeDrawer(
          label: state.attributeName,
          initialValue: state.utilisateur.groupe,
          options: groupeList,
          fieldType: FieldType.dropdown,
          onSaved: (v) {
            Provider.of<UtilisateurProvider>(
              context,
              listen: false,
            ).updateUtilisateur(state.utilisateur.copyWith(groupe: v));
          },
        );

      case 'qrCode':
        return UpdateAttributeDrawer(
          label: state.attributeName,
          initialValue: state.utilisateur.qrCode,

          fieldType: FieldType.string,
          onSaved: (v) {
            Provider.of<UtilisateurProvider>(
              context,
              listen: false,
            ).updateUtilisateur(state.utilisateur.copyWith(qrCode: v));
          },
        );
      case 'motPasseSchema':
        return UpdateAttributeDrawer(
          label: state.attributeName,
          initialValue: state.utilisateur.motPasseSchema,

          fieldType: FieldType.pattern,
          onSaved: (v) {
            Provider.of<UtilisateurProvider>(
              context,
              listen: false,
            ).updateUtilisateur(state.utilisateur.copyWith(motPasseSchema: v));
          },
        );
      case 'nom':
        return UpdateAttributeDrawer(
          label: 'nom',
          initialValue: state.utilisateur.nom,
          fieldType: FieldType.string,
          onSaved: (v) {
            Provider.of<UtilisateurProvider>(
              context,
              listen: false,
            ).updateUtilisateur(state.utilisateur.copyWith(nom: v));
          },
        );
      case 'prenom':
        return UpdateAttributeDrawer(
          label: 'Prenom',
          initialValue: state.utilisateur.prenom,
          fieldType: FieldType.string,
          onSaved: (v) {
            Provider.of<UtilisateurProvider>(
              context,
              listen: false,
            ).updateUtilisateur(state.utilisateur.copyWith(prenom: v));
          },
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildUserDetailTile({
    required String title,
    required String value,
    required UtilisateurModel user,
    required String attributeName,
  }) {
    return InkWell(
      onTap: () {
        context.read<DrawerProvider>().openUpdateUtilisateurAttributeDrawer(
          user,
          attributeName,
          value,
        );
        _scaffoldKey.currentState?.openEndDrawer();
      },
      child: CustomListTile(
        title: Text(title, style: AppTextStyle.greyHeading),
        trailingwidget: Text(
          attributeName != 'motPasseSchema' &&
                  attributeName != 'motPasseChiffre'
              ? value
              : "****",
          style: AppTextStyle.indingosubHeading,
        ),
        leading: null,
        trailing: null,
      ),
    );
  }
}

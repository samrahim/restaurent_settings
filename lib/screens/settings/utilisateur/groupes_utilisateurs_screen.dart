import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent/blocs/drawer/drawer_bloc.dart';
import 'package:restaurent/blocs/utilisateur/etulisateur_bloc.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/utilisateur_model.dart';
import 'package:restaurent/screens/widgets/create_button.dart';
import 'package:restaurent/screens/widgets/widgets.dart';

class GroupesUtilisateursScreen extends StatelessWidget {
  const GroupesUtilisateursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UtilisateurBloc()),
        BlocProvider(create: (context) => DrawerBloc()),
      ],
      child: GroupesUtilisateursScreenView(),
    );
  }
}

class GroupesUtilisateursScreenView extends StatefulWidget {
  const GroupesUtilisateursScreenView({super.key});

  @override
  State<GroupesUtilisateursScreenView> createState() =>
      _GroupesUtilisateursScreenViewState();
}

class _GroupesUtilisateursScreenViewState
    extends State<GroupesUtilisateursScreenView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController groupe = TextEditingController();
  TextEditingController motPasseSchema = TextEditingController();
  TextEditingController motPasseChiffre = TextEditingController();
  TextEditingController qrCode = TextEditingController();
  String role = roleList[0];
  String group = groupeList[0];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<UtilisateurBloc, UtilisateurState>(
                builder: (context, state) {
                  if (state is UtilisateurInitial) {
                    return state.utilisateurs != null
                        ? ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Administrateurs',
                                style: AppTextStyle.greyHeading.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ...state.utilisateurs!
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
                                        state.selectedEtulisateur != null &&
                                        utilisateur.id ==
                                            state.selectedEtulisateur!.id,
                                    onTap: () {
                                      context.read<UtilisateurBloc>().add(
                                        SelectUtilisateur(
                                          utilisateurModel: utilisateur,
                                        ),
                                      );
                                    },
                                  ),
                                ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Serveurs',
                                style: AppTextStyle.greyHeading.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ...state.utilisateurs!
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
                                        state.selectedEtulisateur != null &&
                                        utilisateur.id ==
                                            state.selectedEtulisateur!.id,
                                    onTap: () {
                                      context.read<UtilisateurBloc>().add(
                                        SelectUtilisateur(
                                          utilisateurModel: utilisateur,
                                        ),
                                      );
                                    },
                                  ),
                                ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Responsable de salle',
                                style: AppTextStyle.greyHeading.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ...state.utilisateurs!
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
                                        state.selectedEtulisateur != null &&
                                        utilisateur.id ==
                                            state.selectedEtulisateur!.id,
                                    onTap: () {
                                      context.read<UtilisateurBloc>().add(
                                        SelectUtilisateur(
                                          utilisateurModel: utilisateur,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                          ],
                        )
                        : Center(child: Text("Aucun utilisateur trouvé"));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder<UtilisateurBloc, UtilisateurState>(
                  builder: (context, state) {
                    if (state is UtilisateurInitial) {
                      final utilisateur = state.selectedEtulisateur;
                      if (utilisateur == null) {
                        return const Center(
                          child: Text('Sélectionnez un utilisateur'),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              child: Column(
                                children: [
                                  _buildUserDetailTile(
                                    title: 'Nom',
                                    value: utilisateur.nom,
                                    user: utilisateur,
                                    attributeName: 'nom',
                                  ),
                                  const Divider(),
                                  _buildUserDetailTile(
                                    title: 'Prénom',
                                    value: utilisateur.prenom,
                                    user: utilisateur,
                                    attributeName: 'prenom',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Card(
                              child: _buildUserDetailTile(
                                title: 'Groupe',
                                value: utilisateur.groupe,
                                user: utilisateur,
                                attributeName: 'groupe',
                              ),
                            ),
                            const SizedBox(height: 16),
                            Card(
                              child: Column(
                                children: [
                                  _buildUserDetailTile(
                                    title: 'Mot de passe Schema',
                                    value: utilisateur.motPasseSchema,
                                    user: utilisateur,
                                    attributeName: 'motPasseSchema',
                                  ),
                                  const Divider(),
                                  _buildUserDetailTile(
                                    title: 'Mot de passe chiffre',
                                    value: utilisateur.motPasseChiffre,
                                    user: utilisateur,
                                    attributeName: 'motPasseChiffre',
                                  ),
                                  const Divider(),
                                  _buildUserDetailTile(
                                    title: 'QR Code',
                                    value: utilisateur.qrCode,
                                    user: utilisateur,
                                    attributeName: 'qrCode',
                                  ),
                                  const Divider(),
                                  _buildUserDetailTile(
                                    title: 'Rôle',
                                    value: utilisateur.role,
                                    user: utilisateur,
                                    attributeName: 'role',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),

                            ButtonSupprimer(onTap: () {}),
                          ],
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ),
        ],
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
              context.read<DrawerBloc>().add(OpenCreateUtilisateurDrawer());
              _scaffoldKey.currentState?.openEndDrawer();
            },
            text: "Nouveau",
          ),
        ],
      ),
      endDrawer: BlocBuilder<DrawerBloc, DrawerState>(
        builder: (context, state) {
          if (state is DrawerCreateUtilisateur) {
            return _buildCreateUtilisateurDrawer(context);
          } else if (state is DrawerUpdateUtilisateurAttributeState) {
            print('wer are in the state');
            return _buildUpdateAttributeDrawer(context, state);
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildCreateUtilisateurDrawer(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * .33,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Créer un nouvel utilisateur',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),

              TextField(
                controller: nom,
                decoration: InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: prenom,
                decoration: InputDecoration(
                  labelText: 'Prénom',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
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
                            (grp) =>
                                DropdownMenuItem(value: grp, child: Text(grp)),
                          )
                          .toList(),
                  onChanged: (value) => setState(() => group = value!),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: motPasseSchema,
                decoration: InputDecoration(
                  labelText: 'Mot de passe Schema',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: motPasseChiffre,
                decoration: InputDecoration(
                  labelText: 'Mot de passe chiffre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
              const SizedBox(height: 16),

              // Dropdown Rôle
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
                  context.read<UtilisateurBloc>().add(
                    CreateUtilisateur(
                      groupe: group,
                      motPasseChiffre: motPasseChiffre.text,
                      nom: nom.text,
                      prenom: prenom.text,
                      qrCode: qrCode.text,
                      role: role,
                      motPasseSchema: motPasseSchema.text,
                    ),
                  );
                  _scaffoldKey.currentState?.closeEndDrawer();
                },
                buttonText: "Ajouter",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateAttributeDrawer(
    BuildContext context,
    DrawerUpdateUtilisateurAttributeState state,
  ) {
    print(state.attributeName);
    switch (state.attributeName) {
      case 'role':
        return UpdateAttributeDrawer(
          label: state.attributeName,
          initialValue: state.utilisateur.role,
          options: roleList,
          fieldType: FieldType.dropdown,
          onSaved: (v) {
            context.read<UtilisateurBloc>().add(
              UpdateUtilisateur(
                utilisateurModel: state.utilisateur.copyWith(role: v),
              ),
            );
          },
        );

      case 'motPasseChiffre':
        return UpdateAttributeDrawer(
          label: state.attributeName,
          initialValue: state.utilisateur.motPasseChiffre,

          fieldType: FieldType.string,
          onSaved: (v) {
            context.read<UtilisateurBloc>().add(
              UpdateUtilisateur(
                utilisateurModel: state.utilisateur.copyWith(
                  motPasseChiffre: v,
                ),
              ),
            );
          },
        );

      case 'groupe':
        return UpdateAttributeDrawer(
          label: state.attributeName,
          initialValue: state.utilisateur.groupe,
          options: groupeList,
          fieldType: FieldType.dropdown,
          onSaved: (v) {
            context.read<UtilisateurBloc>().add(
              UpdateUtilisateur(
                utilisateurModel: state.utilisateur.copyWith(groupe: v),
              ),
            );
          },
        );

      case 'qrCode':
        return UpdateAttributeDrawer(
          label: state.attributeName,
          initialValue: state.utilisateur.qrCode,

          fieldType: FieldType.string,
          onSaved: (v) {
            context.read<UtilisateurBloc>().add(
              UpdateUtilisateur(
                utilisateurModel: state.utilisateur.copyWith(qrCode: v),
              ),
            );
          },
        );
      case 'motPasseSchema':
        return UpdateAttributeDrawer(
          label: state.attributeName,
          initialValue: state.utilisateur.motPasseSchema,

          fieldType: FieldType.pattern,
          onSaved: (v) {
            context.read<UtilisateurBloc>().add(
              UpdateUtilisateur(
                utilisateurModel: state.utilisateur.copyWith(motPasseSchema: v),
              ),
            );
          },
        );
      case 'nom':
        return UpdateAttributeDrawer(
          label: 'nom',
          initialValue: state.utilisateur.nom,
          fieldType: FieldType.string,
          onSaved: (v) {
            context.read<UtilisateurBloc>().add(
              UpdateUtilisateur(
                utilisateurModel: state.utilisateur.copyWith(nom: v),
              ),
            );
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
        context.read<DrawerBloc>().add(
          OpenUpdateUtilisateurAttributeDrawer(
            utilisateur: user,
            attributeName: attributeName,
            currentValue: value,
          ),
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

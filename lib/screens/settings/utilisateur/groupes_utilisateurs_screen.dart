import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent/blocs/drawer/drawer_bloc.dart';
import 'package:restaurent/blocs/utilisateur/etulisateur_bloc.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/utilisateur_model.dart';
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
            flex: 3,
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
                                    value: "****",
                                    user: utilisateur,
                                    attributeName: 'motPasseSchema',
                                  ),
                                  const Divider(),
                                  _buildUserDetailTile(
                                    title: 'Mot de passe chiffre',
                                    value: '****',
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
      endDrawer: _buildDrawerWithBloc(context),
    );
  }

  Widget _buildDrawerWithBloc(BuildContext context) {
    return BlocListener<DrawerBloc, DrawerState>(
      listener: (context, state) {
        if (state is DrawerCreateUtilisateur) {
          nom.clear();
          prenom.clear();
          groupe.clear();
          motPasseChiffre.clear();
          motPasseSchema.clear();
          qrCode.clear();
          role = roleList[0];
        } else if (state is DrawerUpdateUtilisateurAttributeState) {
          // Pre-fill data for update
          nom.text = state.currentValue.toString();
          prenom.text = state.currentValue.toString();
          groupe.text = state.currentValue.toString();
          motPasseChiffre.text = state.currentValue.toString();
          motPasseSchema.text = state.currentValue.toString();
          qrCode.text = state.currentValue.toString();
          role = state.currentValue.toString();
        }
      },
      child: Drawer(
        width: MediaQuery.of(context).size.width * 0.3,
        child: BlocBuilder<DrawerBloc, DrawerState>(
          builder: (context, state) {
            return _buildDrawerContent(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildDrawerContent(BuildContext context, DrawerState state) {
    if (state is DrawerCreateUtilisateur) {
      return _buildCreateUtilisateurDrawer(context);
    } else if (state is DrawerUpdateUtilisateurAttributeState) {
      return _buildUpdateAttributeDrawer(context, state);
    }
    return Container(); // Default empty drawer
  }

  Widget _buildCreateUtilisateurDrawer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Créer un nouvel utilisateur',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
                color: Colors.grey[50],
              ),
              child: DropdownButtonFormField(
                value: group,
                decoration: const InputDecoration(
                  labelText: 'Rôle',
                  border: InputBorder.none,
                ),
                items:
                    groupeList
                        .map(
                          (grp) =>
                              DropdownMenuItem(value: grp, child: Text(grp)),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    group = value!;
                  });
                },
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
                color: Colors.grey[50],
              ),
              child: DropdownButtonFormField(
                value: role,
                decoration: const InputDecoration(
                  labelText: 'Rôle',
                  border: InputBorder.none,
                ),
                items:
                    roleList
                        .map(
                          (role) =>
                              DropdownMenuItem(value: role, child: Text(role)),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    role = value!;
                  });
                },
              ),
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  context.read<UtilisateurBloc>().add(
                    CreateUtilisateur(
                      groupe: groupe.text,
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Ajouter",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateAttributeDrawer(
    BuildContext context,
    DrawerUpdateUtilisateurAttributeState state,
  ) {
    final TextEditingController controller = TextEditingController(
      text: state.currentValue.toString(),
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Modifier ${state.attributeName}',
            style: AppTextStyle.indingoHeading,
          ),
          const SizedBox(height: 24),
          if (state.attributeName == 'role')
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
                color: Colors.grey[50],
              ),
              child: DropdownButtonFormField<String>(
                value: state.currentValue,
                decoration: const InputDecoration(border: InputBorder.none),
                items:
                    roleList
                        .map(
                          (role) =>
                              DropdownMenuItem(value: role, child: Text(role)),
                        )
                        .toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.text = value;
                  }
                },
              ),
            )
          else if (state.attributeName == 'groupe')
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
                color: Colors.grey[50],
              ),
              child: DropdownButtonFormField<String>(
                value: state.currentValue,
                decoration: const InputDecoration(border: InputBorder.none),
                items:
                    groupeList
                        .map(
                          (groupe) => DropdownMenuItem(
                            value: groupe,
                            child: Text(groupe),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.text = value;
                  }
                },
              ),
            )
          else
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: state.attributeName,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                final updatedUser = state.utilisateur.copyWith(
                  nom:
                      state.attributeName == 'nom'
                          ? controller.text
                          : state.utilisateur.nom,
                  prenom:
                      state.attributeName == 'prenom'
                          ? controller.text
                          : state.utilisateur.prenom,
                  groupe:
                      state.attributeName == 'groupe'
                          ? controller.text
                          : state.utilisateur.groupe,
                  motPasseSchema:
                      state.attributeName == 'motPasseSchema'
                          ? controller.text
                          : state.utilisateur.motPasseSchema,
                  motPasseChiffre:
                      state.attributeName == 'motPasseChiffre'
                          ? controller.text
                          : state.utilisateur.motPasseChiffre,
                  qrCode:
                      state.attributeName == 'qrCode'
                          ? controller.text
                          : state.utilisateur.qrCode,
                  role:
                      state.attributeName == 'role'
                          ? controller.text
                          : state.utilisateur.role,
                );

                context.read<UtilisateurBloc>().add(
                  UpdateUtilisateur(utilisateurModel: updatedUser),
                );
                _scaffoldKey.currentState?.closeEndDrawer();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Enregistrer',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
        trailingwidget: Text(value, style: AppTextStyle.indingosubHeading),
        leading: null,
        trailing: null,
      ),
    );
  }
}

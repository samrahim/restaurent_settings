import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent/blocs/drawer/drawer_bloc.dart';
import 'package:restaurent/blocs/utilisateur/etulisateur_bloc.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/utlisateur_model.dart';
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
                                        utilisateur.nom ==
                                        (context.read<UtilisateurBloc>().state
                                                as UtilisateurInitial)
                                            .selectedEtulisateur!
                                            .nom,
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
                                        utilisateur.nom ==
                                        (context.read<UtilisateurBloc>().state
                                                as UtilisateurInitial)
                                            .selectedEtulisateur!
                                            .nom,
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
                                        utilisateur.nom ==
                                        (context.read<UtilisateurBloc>().state
                                                as UtilisateurInitial)
                                            .selectedEtulisateur!
                                            .nom,
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
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.read<DrawerBloc>().add(
                                        OpenUpdateUtilisateurDrawer(
                                          utilisateur: utilisateur,
                                        ),
                                      );

                                      _scaffoldKey.currentState
                                          ?.openEndDrawer();
                                    },
                                    child: CustomListTile(
                                      trailingwidget: Text(
                                        utilisateur!.nom,
                                        style: AppTextStyle.indingosubHeading,
                                      ),
                                      title: Text(
                                        "Nom",
                                        style: AppTextStyle.greyHeading,
                                      ),
                                      leading: null,
                                      trailing: null,
                                    ),
                                  ),

                                  Divider(),
                                  CustomListTile(
                                    trailingwidget: Text(
                                      utilisateur.prenom,
                                      style: AppTextStyle.indingosubHeading,
                                    ),
                                    title: Text(
                                      "Prenom",
                                      style: AppTextStyle.greyHeading,
                                    ),
                                    leading: null,
                                    trailing: null,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 16),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: CustomListTile(
                                trailingwidget: Text(
                                  utilisateur.groupe,
                                  style: AppTextStyle.greysubHeading,
                                ),
                                title: null,
                                leading: 'Groupe',
                                trailing: null,
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  CustomListTile(
                                    trailingwidget: Text(
                                      "****",
                                      style: AppTextStyle.indingosubHeading,
                                    ),
                                    title: Text(
                                      "Mot de passe Schema",
                                      style: AppTextStyle.greyHeading,
                                    ),
                                    leading: null,
                                    trailing: null,
                                  ),

                                  Divider(),
                                  CustomListTile(
                                    trailingwidget: Text(
                                      "****",
                                      style: AppTextStyle.indingosubHeading,
                                    ),
                                    title: Text(
                                      "Mot de passe chiffre",
                                      style: AppTextStyle.greyHeading,
                                    ),
                                    leading: null,
                                    trailing: null,
                                  ),
                                  Divider(),
                                  CustomListTile(
                                    trailingwidget: null,
                                    title: Text(
                                      "QR Code",
                                      style: AppTextStyle.greyHeading,
                                    ),
                                    leading: null,
                                    trailing: null,
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
                    return const Center(
                      child: Text('Sélectionnez un utlisateur '),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),

      appBar: AppBar(
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
        } else if (state is DrawerUpdateUtilisateurState) {
          // Pre-fill data for update
          nom.text = state.utilisateur.nom;
          prenom.text = state.utilisateur.prenom;
          groupe.text = state.utilisateur.groupe;
          motPasseChiffre.text = state.utilisateur.motPasseChiffre;
          motPasseSchema.text = state.utilisateur.motPasseSchema ?? '';
          qrCode.text = state.utilisateur.qrCode ?? '';
          role = state.utilisateur.role;
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
    } else if (state is DrawerUpdateUtilisateurState) {
      return _buildUpdateUtilisateurDrawer(context, state.utilisateur);
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
            TextField(
              controller: groupe,
              decoration: InputDecoration(
                labelText: 'Groupe',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[50],
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

  Widget _buildUpdateUtilisateurDrawer(
    BuildContext context,
    UtilisateurModel user,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Modifier l\'utilisateur',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: user.nom),
              decoration: InputDecoration(
                labelText: 'Nom',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              onChanged: (value) => nom.text = value,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: user.prenom),
              decoration: InputDecoration(
                labelText: 'Prénom',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              onChanged: (value) => prenom.text = value,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: user.groupe),
              decoration: InputDecoration(
                labelText: 'Groupe',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              onChanged: (value) => groupe.text = value,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: user.motPasseChiffre),
              decoration: InputDecoration(
                labelText: 'Mot de passe chiffre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              onChanged: (value) => motPasseChiffre.text = value,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: user.motPasseSchema),
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
              controller: TextEditingController(text: user.qrCode),
              decoration: InputDecoration(
                labelText: 'QR Code',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              onChanged: (value) => qrCode.text = value,
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
                value: user.role,
                decoration: const InputDecoration(
                  labelText: 'Rôle',
                  border: InputBorder.none,
                ),
                items:
                    roleList
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
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
                    UpdateUtilisateur(
                      utilisateurModel: user.copyWith(
                        nom: nom.text.isEmpty ? user.nom : nom.text,
                        prenom: prenom.text.isEmpty ? user.prenom : prenom.text,
                        groupe: groupe.text.isEmpty ? user.groupe : groupe.text,
                        motPasseChiffre:
                            motPasseChiffre.text.isEmpty
                                ? user.motPasseChiffre
                                : motPasseChiffre.text,
                        motPasseSchema:
                            motPasseSchema.text.isEmpty
                                ? user.motPasseSchema
                                : motPasseSchema.text,
                        qrCode: qrCode.text.isEmpty ? user.qrCode : qrCode.text,
                        role: role,
                      ),
                    ),
                  );
                  nom.clear();
                  prenom.clear();
                  groupe.clear();
                  motPasseChiffre.clear();
                  motPasseSchema.clear();
                  qrCode.clear();
                  role = roleList[0];
                  _scaffoldKey.currentState?.closeEndDrawer();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Mettre à jour',
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
}

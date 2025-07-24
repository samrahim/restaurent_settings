import 'package:flutter/material.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/rapport_model.dart';
import 'package:restaurent/widgets/widgets.dart';

class RapportScreen extends StatefulWidget {
  const RapportScreen({super.key});

  @override
  State<RapportScreen> createState() => _RapportScreenState();
}

class _RapportScreenState extends State<RapportScreen> {
  late RapportModel rapportModel;

  @override
  void initState() {
    super.initState();
    // Initialize with default values
    rapportModel = RapportModel(
      impresstionDesAnnulations: false,
      impressionDuTop10Produits: false,
      impressionDuTop10ProduitsEnValeur: false,
      impressionDeTousLesProduits: false,
      impressionDeTousLesProduitsEnValeur: false,
      impressionDeTousLesProduitsParCategorie: false,
      impressionDeTousLesProduitsParCategorieAvecDetails: false,
      impressionDuCAParSalle: false,
      impressionDuCAParServeur: false,
      impressionDuMenuMoyen: false,
      impressionDuFondDeCaisse: false,
      informationDuTicketPanierMoyenGlobal: false,
      informationDuTicketPanierMoyenParSalle: false,
      informationDuTicketMoyenComptoirSurPlace: false,
      informationDuTicketMoyenComptoirAEmporter: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paramètres des rapports',
          style: AppTextStyle.largeindingotext,
        ),
        centerTitle: true,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection('Produits', [
                      CustomListTile(
                        onTap: null,
                        trailingwidget: Switch(
                          activeColor: AppColors.primary,
                          value: rapportModel.impressionDuTop10Produits,
                          onChanged: (value) {
                            setState(() {
                              rapportModel = rapportModel.copyWith(
                                impressionDuTop10Produits: value,
                              );
                            });
                          },
                        ),
                        title: Text(
                          'Impression du top 10 produits',
                          style: AppTextStyle.greyHeading,
                        ),
                        leading: null,
                        trailing: null,
                      ),
                      CustomListTile(
                        onTap: null,
                        trailingwidget: Switch(
                          activeColor: AppColors.primary,
                          value: rapportModel.impressionDuTop10ProduitsEnValeur,
                          onChanged: (value) {
                            setState(() {
                              rapportModel = rapportModel.copyWith(
                                impressionDuTop10ProduitsEnValeur: value,
                              );
                            });
                          },
                        ),
                        title: Text(
                          'Impression du top 10 produits en valeur',
                          style: AppTextStyle.greyHeading,
                        ),
                        leading: null,
                        trailing: null,
                      ),
                      CustomListTile(
                        onTap: null,
                        trailingwidget: Switch(
                          activeColor: AppColors.primary,
                          value: rapportModel.impressionDeTousLesProduits,
                          onChanged: (value) {
                            setState(() {
                              rapportModel = rapportModel.copyWith(
                                impressionDeTousLesProduits: value,
                              );
                            });
                          },
                        ),
                        title: Text(
                          'Impression de tous les produits',
                          style: AppTextStyle.greyHeading,
                        ),
                        leading: null,
                        trailing: null,
                      ),
                      CustomListTile(
                        onTap: null,
                        trailingwidget: Switch(
                          activeColor: AppColors.primary,
                          value:
                              rapportModel.impressionDeTousLesProduitsEnValeur,
                          onChanged: (value) {
                            setState(() {
                              rapportModel = rapportModel.copyWith(
                                impressionDeTousLesProduitsEnValeur: value,
                              );
                            });
                          },
                        ),
                        title: Text(
                          'Impression de tous les produits en valeur',
                          style: AppTextStyle.greyHeading,
                        ),
                        leading: null,
                        trailing: null,
                      ),
                    ]),
                    _buildSection('Catégories', [
                      CustomListTile(
                        onTap: null,
                        trailingwidget: Switch(
                          activeColor: AppColors.primary,

                          value:
                              rapportModel
                                  .impressionDeTousLesProduitsParCategorie,
                          onChanged: (value) {
                            setState(() {
                              rapportModel = rapportModel.copyWith(
                                impressionDeTousLesProduitsParCategorie: value,
                              );
                            });
                          },
                        ),
                        title: Text(
                          'Impression par catégorie',
                          style: AppTextStyle.greyHeading,
                        ),
                        leading: null,
                        trailing: null,
                      ),
                      CustomListTile(
                        onTap: null,
                        trailingwidget: Switch(
                          activeColor: AppColors.primary,
                          value:
                              rapportModel
                                  .impressionDeTousLesProduitsParCategorieAvecDetails,
                          onChanged: (value) {
                            setState(() {
                              rapportModel = rapportModel.copyWith(
                                impressionDeTousLesProduitsParCategorieAvecDetails:
                                    value,
                              );
                            });
                          },
                        ),
                        title: Text(
                          'Impression par catégorie avec détails',
                          style: AppTextStyle.greyHeading,
                        ),
                        leading: null,
                        trailing: null,
                      ),
                    ]),
                    _buildSection('Chiffre d\'affaires', [
                      CustomListTile(
                        onTap: null,
                        trailingwidget: Switch(
                          activeColor: AppColors.primary,
                          value: rapportModel.impressionDuCAParSalle,
                          onChanged: (value) {
                            setState(() {
                              rapportModel = rapportModel.copyWith(
                                impressionDuCAParSalle: value,
                              );
                            });
                          },
                        ),
                        title: Text(
                          'CA par salle',
                          style: AppTextStyle.greyHeading,
                        ),
                        leading: null,
                        trailing: null,
                      ),
                      CustomListTile(
                        onTap: null,
                        trailingwidget: Switch(
                          activeColor: AppColors.primary,
                          value: rapportModel.impressionDuCAParServeur,
                          onChanged: (value) {
                            setState(() {
                              rapportModel = rapportModel.copyWith(
                                impressionDuCAParServeur: value,
                              );
                            });
                          },
                        ),
                        title: Text(
                          'CA par serveur',
                          style: AppTextStyle.greyHeading,
                        ),
                        leading: null,
                        trailing: null,
                      ),
                    ]),
                    _buildSection('Tickets et paniers', [
                      CustomListTile(
                        onTap: null,
                        trailingwidget: Switch(
                          activeColor: AppColors.primary,
                          value:
                              rapportModel.informationDuTicketPanierMoyenGlobal,
                          onChanged: (value) {
                            setState(() {
                              rapportModel = rapportModel.copyWith(
                                informationDuTicketPanierMoyenGlobal: value,
                              );
                            });
                          },
                        ),
                        title: Text(
                          'Panier moyen global',
                          style: AppTextStyle.greyHeading,
                        ),
                        leading: null,
                        trailing: null,
                      ),
                      CustomListTile(
                        onTap: null,
                        trailingwidget: Switch(
                          activeColor: AppColors.primary,
                          value:
                              rapportModel
                                  .informationDuTicketPanierMoyenParSalle,
                          onChanged: (value) {
                            setState(() {
                              rapportModel = rapportModel.copyWith(
                                informationDuTicketPanierMoyenParSalle: value,
                              );
                            });
                          },
                        ),
                        title: Text(
                          'Panier moyen par salle',
                          style: AppTextStyle.greyHeading,
                        ),
                        leading: null,
                        trailing: null,
                      ),
                      CustomListTile(
                        onTap: null,
                        trailingwidget: Switch(
                          activeColor: AppColors.primary,
                          value:
                              rapportModel
                                  .informationDuTicketMoyenComptoirSurPlace,
                          onChanged: (value) {
                            setState(() {
                              rapportModel = rapportModel.copyWith(
                                informationDuTicketMoyenComptoirSurPlace: value,
                              );
                            });
                          },
                        ),
                        title: Text(
                          'Ticket moyen comptoir sur place',
                          style: AppTextStyle.greyHeading,
                        ),
                        leading: null,
                        trailing: null,
                      ),
                      CustomListTile(
                        onTap: null,
                        trailingwidget: Switch(
                          activeColor: AppColors.primary,
                          value:
                              rapportModel
                                  .informationDuTicketMoyenComptoirAEmporter,
                          onChanged: (value) {
                            setState(() {
                              rapportModel = rapportModel.copyWith(
                                informationDuTicketMoyenComptoirAEmporter:
                                    value,
                              );
                            });
                          },
                        ),
                        title: Text(
                          'Ticket moyen comptoir à emporter',
                          style: AppTextStyle.greyHeading,
                        ),
                        leading: null,
                        trailing: null,
                      ),
                    ]),
                    _buildSection('Autres', [
                      CustomListTile(
                        onTap: null,
                        trailingwidget: Switch(
                          activeColor: AppColors.primary,
                          value: rapportModel.impresstionDesAnnulations,
                          onChanged: (value) {
                            setState(() {
                              rapportModel = rapportModel.copyWith(
                                impresstionDesAnnulations: value,
                              );
                            });
                          },
                        ),
                        title: Text(
                          'Impression des annulations',
                          style: AppTextStyle.greyHeading,
                        ),
                        leading: null,
                        trailing: null,
                      ),
                      CustomListTile(
                        onTap: null,
                        trailingwidget: Switch(
                          activeColor: AppColors.primary,
                          value: rapportModel.impressionDuMenuMoyen,
                          onChanged: (value) {
                            setState(() {
                              rapportModel = rapportModel.copyWith(
                                impressionDuMenuMoyen: value,
                              );
                            });
                          },
                        ),
                        title: Text(
                          'Impression du menu moyen',
                          style: AppTextStyle.greyHeading,
                        ),
                        leading: null,
                        trailing: null,
                      ),
                      CustomListTile(
                        onTap: null,
                        trailingwidget: Switch(
                          activeColor: AppColors.primary,
                          value: rapportModel.impressionDuFondDeCaisse,
                          onChanged: (value) {
                            setState(() {
                              rapportModel = rapportModel.copyWith(
                                impressionDuFondDeCaisse: value,
                              );
                            });
                          },
                        ),
                        title: Text(
                          'Impression du fond de caisse',
                          style: AppTextStyle.greyHeading,
                        ),
                        leading: null,
                        trailing: null,
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Card(
              margin: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Header section
                      Text('LNE2', style: AppTextStyle.greyHeading),
                      Text(
                        '1 Place Laine2',
                        style: AppTextStyle.greysubHeading,
                      ),
                      Text(
                        '330002 Bordeaux2',
                        style: AppTextStyle.greysubHeading,
                      ),
                      Text('0100000002', style: AppTextStyle.greysubHeading),
                      Text('Swift', style: AppTextStyle.greysubHeading),
                      Text('Test2', style: AppTextStyle.greysubHeading),
                      Text('Test2', style: AppTextStyle.greysubHeading),
                      Text('Test2', style: AppTextStyle.greysubHeading),
                      Text('011111', style: AppTextStyle.greysubHeading),
                      Text('Test2', style: AppTextStyle.greysubHeading),
                      const SizedBox(height: 20),

                      // Report section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rapport X du 04/04/2023 11:27',
                            style: AppTextStyle.greyHeading,
                          ),
                          Text(
                            'Rapport global',
                            style: AppTextStyle.greyHeading,
                          ),
                          Text(
                            'Utilisateur : Administrateur A',
                            style: AppTextStyle.greyHeading,
                          ),
                          Text('Prix en €', style: AppTextStyle.greyHeading),
                          const Divider(),
                          const SizedBox(height: 10),

                          Text(
                            'Fond de caisse',
                            style: AppTextStyle.indingoHeading,
                          ),
                          const SizedBox(height: 10),

                          Text(
                            'Valeur en début de service',
                            style: AppTextStyle.greyHeading,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('0.00', style: AppTextStyle.greyHeading),
                            ],
                          ),
                          const SizedBox(height: 10),

                          Text(
                            'Solde de caisse',
                            style: AppTextStyle.indingoHeading,
                          ),
                          const SizedBox(height: 10),

                          _buildReportRow('Nombre de couverts', '0'),
                          _buildReportRow('Panier moyen', '0.00'),
                          _buildReportRow('- par commande', '0.00'),
                          _buildReportRow('Ticket moyen', '0.00'),
                          _buildReportRow('Nombre de couverts (salle)', '0'),
                          _buildReportRow('Panier moyen (salle)', '0.00'),
                          _buildReportRow('- par commande', '0.00'),
                          _buildReportRow('Ticket moyen (salle)', '0.00'),
                          _buildReportRow(
                            'Ticket moyen (cpt. sur place)',
                            '0.00',
                          ),
                          _buildReportRow(
                            'Ticket moyen (cpt. emp/liv)',
                            '0.00',
                          ),
                          _buildReportRow('Montant TVA total', '0.00'),
                          _buildReportRow('Total HT', '0.00'),
                          _buildReportRow('Total TTC', '0.00'),
                          _buildReportRow('Remise (0 % du total)', '0.00'),
                          _buildReportRow('Offert (0 % du total)', '0.00'),
                          _buildReportRow('Total hors remise TTC', '0.00'),
                          const SizedBox(height: 10),

                          Text(
                            'Annulations',
                            style: AppTextStyle.indingoHeading,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: AppTextStyle.greysubHeading)),
          Text(value, style: AppTextStyle.greysubHeading),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(title, style: AppTextStyle.indingoHeading),
        ),
        Card(child: Column(children: children)),
      ],
    );
  }
}

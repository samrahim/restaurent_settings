import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent/blocs/taux_tva_bloc/taux_et_tva_bloc.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/screens/widgets/widgets.dart';

class TauxTVAScreen extends StatelessWidget {
  const TauxTVAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TauxEtTvaBloc(),
      child: TauxTVAScreenView(),
    );
  }
}

class TauxTVAScreenView extends StatelessWidget {
  const TauxTVAScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final tauxTvaController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Taux de TVA'),
        centerTitle: true,
        actions: [ActionButton(onPressed: () {}, text: 'Nouveau')],
      ),
      body: BlocBuilder<TauxEtTvaBloc, TauxEtTvaState>(
        builder: (context, state) {
          if (state is TauxEtTvaInitial) {
            return state.tauxTvas != null
                ? ListView.builder(
                  itemCount: state.tauxTvas!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "TVA ${state.tauxTvas![index].tauxTva}",
                            style: AppTextStyle.indingoHeading,
                          ),
                          Text(
                            '${state.selectedTauxTva?.elementsInclus} éléments',
                          ),

                          SizedBox(
                            width: 100,
                            child: TextFormField(
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              controller: TextEditingController(
                                text: state.tauxTvas![index].tauxTva
                                    .toStringAsFixed(2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
                : Center(child: Text("Aucun utilisateur trouvé"));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

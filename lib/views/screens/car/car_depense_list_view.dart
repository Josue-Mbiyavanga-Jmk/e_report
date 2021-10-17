import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapport_app/models/car.dart';
import 'package:rapport_app/models/car_versement.dart';
import 'package:rapport_app/services/versement_firebase_database.dart';
import 'package:rapport_app/views/widgets/depense_widget/list_depense_widget.dart';
import 'package:rapport_app/views/widgets/versement_widget/list_versement_widget.dart';

class CarDepenseListView extends StatefulWidget {
  final Car car;
  const CarDepenseListView({Key? key, required this.car}) : super(key: key);

  @override
  _CarDepenseListViewState createState() => _CarDepenseListViewState();
}

class _CarDepenseListViewState extends State<CarDepenseListView> {
  late Car unCar;
  @override
  void initState() {
    super.initState();

    unCar = widget.car;  //here var is call and set to
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<CarDepense>>.value(
      value: VersementDatabaseService(uid: unCar.id).depenses, //on a pas besoin de uid (chercher comment l'enlever)
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Les Dépenses', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),),
          centerTitle: true,
          backgroundColor: Colors.blueGrey, //le titre depend d'où on doit partir.

        ),
        //etant le fils, il aura accès à le liste du parent
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              bottom: 20.0,
            ),
            child: DepenseList(),
          ),
        ),
        //le button

      ),
    );
  }
}

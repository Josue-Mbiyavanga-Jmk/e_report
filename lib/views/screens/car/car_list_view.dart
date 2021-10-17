import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapport_app/memory/preference.dart';
import 'package:rapport_app/models/car.dart';
import 'package:rapport_app/services/car_firebase_database.dart';
import 'package:rapport_app/views/widgets/car_widget/list_car_widget.dart';

class CarListView extends StatefulWidget {
  const CarListView({Key? key}) : super(key: key);

  @override
  _CarListViewState createState() => _CarListViewState();
}

class _CarListViewState extends State<CarListView> {

  //les variables
  String role ="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    role = UserSimplePreference.getUserRole() ?? "";
  }

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Car>>.value(
      value: CarDatabaseService(uid: '').cars , //on a pas besoin de uid (chercher comment l'enlever)
      initialData: [],
      /*catchError: (_, __){
        print(__);
        return [];
    },*/
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
            title: Text('Les voitures', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),),
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
          child: CarList(),
        ),
      ),
        //le button (on affique pour d'autres role que le User)
        floatingActionButton: role == "User" ? null : FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/addCar', arguments: null),
          backgroundColor: Colors.blueGrey,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );

  }
}



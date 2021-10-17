import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapport_app/models/car.dart';

import 'item_car_widget.dart';

class CarList extends StatefulWidget {

  @override
  _CarListState createState() => _CarListState();
}



class _CarListState extends State<CarList> {
  @override
  Widget build(BuildContext context) {
    //on recupere la liste des cars depuis le parent (car_list_view)
    final cars = Provider.of<List<Car>>(context) ?? [];

    return cars.length == 0 ?
        EmptyCarList(context) :
        ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index){
              return CarItemWidget(car:cars[index]);
            }
        );
  }

  Widget EmptyCarList (BuildContext context) => Center(
    child: Container(
      margin: EdgeInsets.only(top: 80, bottom: 40, left: 10, right: 10),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: Text(
        'Aucune voiture, veuillez les ajouter',
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.blueGrey),
      ),
    ),
  );
}


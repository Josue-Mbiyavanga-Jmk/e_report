import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapport_app/memory/preference.dart';
import 'package:rapport_app/models/car.dart';

class CarView extends StatefulWidget {

  //construteur
  const CarView({Key? key, required this.car}) : super(key: key);
  //attribut
  final Car car;

  @override
  _CarViewState createState() => _CarViewState();
}

class _CarViewState extends State<CarView> {
  //
  late Car unCar;
  String role ="";

  @override
  void initState() {
    super.initState();

    unCar = widget.car;  //here var is call and set to
    //recuperation dans la préférence
    role = UserSimplePreference.getUserRole() ?? "";
  }


  @override
  Widget build(BuildContext context) {
    //on recupère l'argument passé
    //final car = ModalRoute.of(context)!.settings.arguments as Car;
    //

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Détail Voiture',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
        ),
        centerTitle: false,
        backgroundColor: Colors.blueGrey,
        elevation: 1.0,
        actions: role == "User" ? null : <Widget>[
          TextButton.icon(
            icon: Icon(Icons.edit, color: Colors.white,),
            label: Text('Editer',
                style: TextStyle(color: Colors.white)
            ),
            onPressed: () async{
              //on part pour enregistrer modifier
              Navigator.pushNamed(
                  context, '/addCar',
                  arguments: unCar);
            },
          )
          ]
      ),
      body: ListView(
        children: [
          //pour la 3ème animation
          Container(
            padding: EdgeInsets.only(top: 12, bottom: 12),
            child: Hero(
              tag: "carDetail"+ unCar.name + unCar.marque , //ça doit etre unique donc id sera mieux
              child:new Image.asset('assets/image/report_1.png',width:500,height:160,fit:BoxFit.contain),
            ),
          ),
          Divider(height: 8,color: Colors.blueGrey),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              padding: EdgeInsets.all(2),
              child:
                  Row(
                    children: [
                      Text(unCar.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                      Text(' - ', style: TextStyle(fontSize: 20, color: Colors.black),),
                      Text(unCar.marque, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey[800]),)
                    ],
                  ),
              ),
            ),
          //SizedBox(height: 2,),
          Container(
              margin: EdgeInsets.only(left: 12, right: 12),
              child: Text('versement de ${unCar.tarif_versement} \$ par jour', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.grey[600]),)
          ),

          SizedBox(height: 15,),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              padding: EdgeInsets.all(2),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 6,
                            child:  Row(
                          children: [
                            Icon(Icons.monetization_on_outlined, color: Colors.blueGrey,),
                            SizedBox(width: 5,),
                            Text('Total de Versements', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.grey[600]),)
                          ],
                        )
                        ),
                        Expanded(
                            flex: 4,
                            child:  Align(
                              alignment: Alignment.centerRight,
                              child: Text('${unCar.total_versement} \$',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.5,),
                  Divider(height: 2,color: Colors.blueGrey,),
                   SizedBox(height: 9.5,),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 6,
                            child:  Row(
                              children: [
                                Icon(Icons.launch, color: Colors.blueGrey,),
                                SizedBox(width: 5,),
                                Text('Total de Dépenses', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18,color: Colors.grey[600]),)
                              ],
                            ),
                        ),
                        Expanded(
                            flex: 4,
                            child:  Align(
                              alignment: Alignment.centerRight,
                              child: Text('${unCar.total_depense} \$',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.5,),
                  Divider(height: 2,color: Colors.blueGrey,),
                ],
              ),
            ),
          ),
          SizedBox(height: 70,),
          GestureDetector(
            onTap: ()=>Navigator.pushNamed(context, '/listVersement', arguments: unCar),
            child: Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 2, right: 2),
              padding: EdgeInsets.only(top: 12, bottom: 12, left: 5, right: 3),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey, width: 2),
                  borderRadius: BorderRadius.circular(3)
              ),
              child: Row(
                children: [
                  Expanded(
                      flex: 7,
                      child: Center(
                        child: Text('Les Versements',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blueGrey)),
                      )
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                      flex: 3,
                      child: Center(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.arrow_forward, color: Colors.blueGrey,)
                        ),
                          ),
                      )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: ()=>Navigator.pushNamed(context, '/listDepense', arguments: unCar),
            child: Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 2, right: 2),
              padding: EdgeInsets.only(top: 12, bottom: 12, left: 5, right: 3),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey, width: 2),
                  borderRadius: BorderRadius.circular(3)
              ),
              child: Row(
                children: [
                  Expanded(
                      flex: 7,
                      child: Center(
                        child: Text('Les Dépenses', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color:Colors.blueGrey)),
                      )
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                      flex: 3,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.arrow_forward, color: Colors.blueGrey,)
                      ),
                      )
                ],
              ),
            ),
          ),





        ],
      ),
      floatingActionButton: role == "User" ? null : FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addCarChargeEtVersement',arguments: unCar),
        backgroundColor: Colors.blueGrey,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}

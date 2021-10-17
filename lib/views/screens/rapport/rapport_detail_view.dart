import 'package:flutter/material.dart';
import 'package:rapport_app/config/constant.dart';
import 'package:rapport_app/memory/preference.dart';
import 'package:rapport_app/models/rapport.dart';

class RapportDetailView extends StatefulWidget {
  final Rapport rapport;
  const RapportDetailView({Key? key, required this.rapport}) : super(key: key);

  @override
  _RapportDetailViewState createState() => _RapportDetailViewState();
}

class _RapportDetailViewState extends State<RapportDetailView> {
  //
  late Rapport unRapport;
  String role ="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    unRapport = widget.rapport;
    //recuperation dans la préférence
    role = UserSimplePreference.getUserRole() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Détail Rapport',
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
                    context, '/addRapport',
                    arguments: unRapport);
              },
            )
          ]
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 12, bottom: 12),
            child: Hero(
              tag: "rapportDetail"+ unRapport.id , //ça doit etre unique donc id sera mieux
              child:new Image.asset('assets/image/report.png',width:500,height:100,fit:BoxFit.contain),
            ),
          ),
          Divider(height: 8,color: Colors.blueGrey),
          Container(
            padding: EdgeInsets.only(left: 30.0, right: 15.0),
            margin: EdgeInsets.only(top: 25),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      'Date du rapport',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,)
                  ),
                  SizedBox(height: 4,),
                  Text(
                      'Le '+getTextOfDate(unRapport.date),
                      style: TextStyle(fontSize: 20)
                  ),

                ],
              )
            ),

          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            margin: EdgeInsets.only(bottom: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Libellé',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,)
                ),
                SizedBox(height: 8,),
                Text(
                    unRapport.description,
                    style: TextStyle(fontSize: 18, height: 1.4)
                )
              ],
            ),
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.only(left: 30.0, right: 15.0),
            margin: EdgeInsets.only(bottom: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Observation',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,)
                ),
                SizedBox(height: 8,),
                Text(
                    unRapport.observation,
                    style: TextStyle(fontSize: 18, height: 1.4)
                )
              ],
            ),
          ),
        ] ,
      ),
    );
  }
}

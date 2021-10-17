import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapport_app/models/rapport.dart';

import 'item_rapport_widget.dart';

class RapportList extends StatefulWidget {

  @override
  _RapportListState createState() => _RapportListState();
}



class _RapportListState extends State<RapportList> {
  @override
  Widget build(BuildContext context) {
    //on recupere la liste des cars depuis le parent (car_list_view)
    final rapports = Provider.of<List<Rapport>>(context) ?? [];

    return rapports.length == 0 ?
    EmptyRapportList(context) :
    ListView.builder(
        itemCount: rapports.length,
        itemBuilder: (context, index){
          return RapportItemWidget(rapport:rapports[index]);
        }
    );
  }

  Widget EmptyRapportList (BuildContext context) => Center(
    child: Container(
      margin: EdgeInsets.only(top: 80, bottom: 40, left: 10, right: 10),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: Text(
        'Aucun rapport, veuillez les ajouter',
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.blueGrey),
      ),
    ),
  );
}


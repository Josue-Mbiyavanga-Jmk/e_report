import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapport_app/models/car_versement.dart';
import 'package:rapport_app/views/widgets/versement_widget/item_versement_widget.dart';


class VersementList extends StatefulWidget {

  @override
  _VersementListState createState() => _VersementListState();
}



class _VersementListState extends State<VersementList> {
  @override
  Widget build(BuildContext context) {
    //on recupere la liste des versement depuis le parent (car_versement_list_view)
    final versements = Provider.of<List<CarVersement>>(context) ?? [];

    return versements.length == 0 ?
        EmptyVersementList(context) :
        ListView.builder(
            itemCount: versements.length,
            itemBuilder: (context, index){
              return VersementItemWidget(versement:versements[index]);
            }
        );
  }

  Widget EmptyVersementList (BuildContext context) => Center(
    child: Container(
      margin: EdgeInsets.only(top: 80, bottom: 40, left: 10, right: 10),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: Text(
        'Aucun versement, veuillez les ajouter',
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.blueGrey),
      ),
    ),
  );
}


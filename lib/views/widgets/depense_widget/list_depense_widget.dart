import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapport_app/models/car_versement.dart';
import 'package:rapport_app/views/widgets/depense_widget/item_depense_widget.dart';



class DepenseList extends StatefulWidget {

  @override
  _DepenseListState createState() => _DepenseListState();
}



class _DepenseListState extends State<DepenseList> {
  @override
  Widget build(BuildContext context) {
    //on recupere la liste des depenses depuis le parent (car_depense_list_view)
    final depenses = Provider.of<List<CarDepense>>(context) ?? [];
    print(depenses);

    return depenses.length == 0 ?
        EmptyDepenseList(context) :
        ListView.builder(
            itemCount: depenses.length,
            itemBuilder: (context, index){
              return DepenseItemWidget(depense:depenses[index]);
            }
        );
  }

  Widget EmptyDepenseList (BuildContext context) => Center(
    child: Container(
      margin: EdgeInsets.only(top: 80, bottom: 40, left: 10, right: 10),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: Text(
        'Aucune dépense, veuillez les ajouter',
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.blueGrey),
      ),
    ),
  );
}


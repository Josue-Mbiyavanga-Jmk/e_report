import 'package:flutter/material.dart';
import 'package:rapport_app/models/car.dart';
import 'package:rapport_app/models/rapport.dart';

//la classe des items
class RapportItemWidget extends StatelessWidget{
  //constructeur
  const RapportItemWidget({Key? key, required this.rapport}):super(key:key);
  final Rapport rapport;

  //méthode pour afficher la date au format humain
  String getTextOfDate(DateTime myDate){
    return '${myDate.day}/${myDate.month}/${myDate.year}';

  }

  @override
  Widget build(BuildContext context) {
    //GestureDetector c'est pour les actions
    // chaque item est un Card d'une ligne ayant une image et une colonne de 2 text.
    return GestureDetector(
      //au clic
      onTap: (){
        //avec les routes dynamique
        Navigator.pushNamed(
            context,
            '/detailRapport',
            arguments: rapport);

      },
      child: Card(
        margin: EdgeInsets.only(top: 7, bottom: 5),
        elevation: 6,
        child: Row(
          children: [
            //pour la 3ème animation
            Container(
              child: Hero(
                  tag: "imageRapport"+ rapport.id, //ça doit etre unique donc id sera mieux
                  child:new Image.asset('assets/image/report.png',width:80,height:80,fit:BoxFit.cover)
              ),
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey, width: 1),
                  borderRadius: BorderRadius.circular(5)
              ),
            )
            ,
            SizedBox(width: 7.5,),
            //new Image.asset(recipe.imageUrl,width:100,height:100,fit:BoxFit.cover),
            Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 4), //espace du bas
                      child: Text('Le '+getTextOfDate(rapport.date),
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 3), //espace du bas
                      child: Text(rapport.description, style: TextStyle(color: Colors.grey[700], fontSize: 15)),
                    ),
                    Text(
                        rapport.observation.length > 25 ?
                        rapport.observation.substring(0,25)+'...voir plus >>>' :
                        rapport.observation+'...voir plus >>>' ,
                        style: TextStyle(color: Colors.grey[500], fontSize: 12)
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
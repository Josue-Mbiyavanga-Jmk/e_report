import 'package:flutter/material.dart';
import 'package:rapport_app/config/constant.dart';
import 'package:rapport_app/models/car_versement.dart';

//la classe des items
class VersementItemWidget extends StatelessWidget{
  //constructeur
  const VersementItemWidget({Key? key, required this.versement}):super(key:key);
  final CarVersement versement;

  @override
  Widget build(BuildContext context) {
    //GestureDetector c'est pour les actions
    // chaque item est un Card d'une ligne ayant une image et une colonne de 2 text.
    return GestureDetector(
      //au clic
      onTap: (){
        //avec les routes dynamique

      },
      child: Card(
        margin: EdgeInsets.only(top: 7, bottom: 5),
        elevation: 6,
        child: Row(
          children: [
            //pour la 3ème animation
            Container(
              child: Hero(
                  tag: "imageVersement"+ versement.id, //ça doit etre unique donc id sera mieux
                  child:new Image.asset('assets/image/budget.png',width:78,height:78,fit:BoxFit.cover)
              ),
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 6, right: 6),
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
                      child: Text('Le '+getTextOfDate(versement.date),
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 3), //espace du bas
                      child: Text('Montant à payer : ${versement.versement} \$', style: TextStyle(color: Colors.grey[700], fontSize: 15)),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 3), //espace du bas
                      child: Text('Montant payé : ${versement.montant} \$', style: TextStyle(color: Colors.grey[700], fontSize: 15)),
                    ),
                    Text(
                        versement.observation.length > 25 ?
                        versement.observation.substring(0,25)+'...' :
                        versement.observation+'...' ,
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
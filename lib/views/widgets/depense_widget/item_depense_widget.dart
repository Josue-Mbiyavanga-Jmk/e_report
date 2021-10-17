import 'package:flutter/material.dart';
import 'package:rapport_app/config/constant.dart';
import 'package:rapport_app/models/car_versement.dart';

//la classe des items
class DepenseItemWidget extends StatelessWidget{
  //constructeur
  const DepenseItemWidget({Key? key, required this.depense}):super(key:key);
  final CarDepense depense;


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
        child:Row(
              children: [
                //pour la 3ème animation
                Container(
                  child: Hero(
                      tag: "imageDepense"+ depense.id, //ça doit etre unique donc id sera mieux
                      child:new Image.asset('assets/image/depense.png',width:78,height:78,fit:BoxFit.cover)
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
                          child: Text('Le '+getTextOfDate(depense.date),
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 3), //espace du bas
                          child: Text('Montant payé :${depense.montant} \$', style: TextStyle(color: Colors.grey[700], fontSize: 15)),
                        ),
                        Text(
                            depense.observation.length > 25 ?
                            depense.observation.substring(0,25)+'...' :
                            depense.observation+'...' ,
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
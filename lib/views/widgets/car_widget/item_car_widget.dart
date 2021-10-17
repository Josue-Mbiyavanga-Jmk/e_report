import 'package:flutter/material.dart';
import 'package:rapport_app/models/car.dart';

//la classe des items
class CarItemWidget extends StatelessWidget{
  //constructeur
  const CarItemWidget({Key? key, required this.car}):super(key:key);
  final Car car;

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
            '/detailCar',
            arguments: car);

      },
      child: Card(
        margin: EdgeInsets.only(top: 7, bottom: 5),
        elevation: 6,
        child: Row(
          children: [
            //pour la 3ème animation
            Container(
              child: Hero(
                  tag: "imageCar"+ car.id, //ça doit etre unique donc id sera mieux
                  child:new Image.asset('assets/image/sport_car.png',width:80,height:80,fit:BoxFit.cover)
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
                      padding: const EdgeInsets.only(bottom: 8), //espace du bas
                      child: Text(car.name,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 4), //espace du bas
                      child: Text(car.marque, style: TextStyle(color: Colors.grey[700], fontSize: 16)),
                    ),
                    Text('${car.tarif_versement.toString()} \$/versement par jour.', style: TextStyle(color: Colors.grey[500], fontSize: 16))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
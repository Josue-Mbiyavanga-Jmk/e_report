import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:rapport_app/models/app_user.dart';
import 'package:rapport_app/services/user_firebase_database.dart';

class UserItemWidget extends StatefulWidget {
  final AppUserData user;
  const UserItemWidget({Key? key, required this.user}) : super(key: key);

  @override
  _UserItemWidgetState createState() => _UserItemWidgetState();
}

class _UserItemWidgetState extends State<UserItemWidget> {

  late AppUserData appUserData;
  bool switchValue = false;
  Timer? _timer; //pour le progress

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appUserData = widget.user;
    switchValue = appUserData.status == 1 ? true : false;

  }

  //
  //methode
  void activeUser(int status, DatabaseService database) async{
    //on commence par lancer le progress
    _timer?.cancel();
    await EasyLoading.show(
      status: appUserData.status == 1 ? 'désactivation...' : 'activation',
      maskType: EasyLoadingMaskType.black,
    );
    //appel à firebase
    await  database.updateUser(appUserData,status);
    //on change l'état
    setState(() {
      switchValue = status == 1 ? true : false;
    });
    //on arrete la progression
    _timer?.cancel();
    await EasyLoading.dismiss();
    //pour afficher le message de succes
    _timer?.cancel();
    await EasyLoading.showSuccess('opération réussie!');

  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    //on prend la db
    final database = DatabaseService(uid: user.uid);

    //GestureDetector c'est pour les actions
    // chaque item est un Card d'une ligne ayant une image et une colonne de 2 text.
    return GestureDetector(
      //au clic
      onTap: (){
        //avec les routes dynamique
        /*Navigator.pushNamed(
            context,
            '/detailUser',
            arguments: user);*/

      },
      child: Card(
        margin: EdgeInsets.only(top: 7, bottom: 5),
        elevation: 6,
        child: Row(
          children: [
            //pour la 3ème animation
            Container(
              child: Hero(
                  tag: "imageUser"+ appUserData.uid, //ça doit etre unique donc id sera mieux
                  child:new Image.asset('assets/image/user.png',width:80,height:95,fit:BoxFit.contain)
              ),
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey, width: 0.5),
                  borderRadius: BorderRadius.circular(2)
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
                      margin: const EdgeInsets.only(bottom: 2),
                      child: Text(appUserData.name,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 4), //espace du bas
                      child: Text(appUserData.email ?? 'email@domain.com', style: TextStyle(color: Colors.grey[700], fontSize: 16)),
                    ),
                    Container(
                        padding: const EdgeInsets.only(bottom: 1), //espace du bas
                        child: Row(
                          children: [
                            Text('role :', style: TextStyle(color: Colors.grey[700], fontSize: 16)),
                            SizedBox(width: 2,),
                            Text(appUserData.role, style: TextStyle(color: Colors.grey[700], fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        )
                    ),
                    Row(
                      children: [
                        Text(appUserData.status == 1 ? 'activé' : 'désactivé', style: TextStyle(color: Colors.grey[500], fontSize: 14)),
                        SizedBox(width: 75,),
                        buildSwitch(database)
                      ],
                    )

                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget buildSwitch(DatabaseService database)=> Transform.scale(
    scale: 1.0,
    child: Switch.adaptive(
      value: switchValue,
      //thumbColor: MaterialStateProperty.all(Colors.blue),//couleur pour tous les cas
      //trackColor: MaterialStateProperty.all(Colors.grey),//couleur de la barre pour tous les cas
      activeColor: Colors.blueGrey,//couleur quand c'est active
      activeTrackColor: Colors.blueGrey.withOpacity(0.4), //couleur de la barre quand c'est active
      //inactiveThumbColor: Colors.grey,//couleur quand c'est inactive
      //inactiveTrackColor: Colors.grey.withOpacity(0.5),
      splashRadius: 10, //pour mettre une ombre après un long clic
      onChanged: (value)=> {
        //print(appUserData.uid)
        //print(appUserData.name)
         activeUser(value ? 1 : 0, database)
        /*setState(() {
            switchValue = value;
            activeUser(value ? 1 : 0, database); //si c'est vrai alors c'est 1 sinon 0
            print(switchValue);

      })*/

      },
    ),
  );
}



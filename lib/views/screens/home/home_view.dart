import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapport_app/config/utils.dart';
import 'package:rapport_app/memory/preference.dart';
import 'package:rapport_app/models/app_user.dart';
import 'package:rapport_app/services/user_firebase_database.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  //garder en memoire le role du user
  void saveRole(String role) async{
    await UserSimplePreference.setUserRole(role);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    //on prend la db
    final database = DatabaseService(uid: user.uid);

    return StreamBuilder<AppUserData>(
        stream: database.user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            AppUserData? userData = snapshot?.data;
            if(userData != null){
              saveRole(userData.role);
            }
          }
          else{
            //quand firebase retourne encore rien
          }
         //on retourne la page
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Accueil',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false, //enlever le button retour
                backgroundColor: Colors.blueGrey,
              ),
            body: Container(
              child: Column(
                children: [
                  Expanded(
                      flex: 9,
                      child: Container(
                        child: Center(
                          //report.json ou report_1.json ou completing_tasks.json
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 15.0),
                            margin: EdgeInsets.only(
                                top: 40, bottom: 40, left: 12.5, right: 12.5),
                            child: ListView(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                        child: Container(
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  'assets/image/car.png',
                                                  width: 80,
                                                  height: 80,
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text('Gérer les voitures')
                                              ],
                                            ),
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blueGrey,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),

                                      onTap: () => Navigator.pushNamed(
                                          context, '/listCar'),
                                    ),
                                    SizedBox(width: 20),
                                    GestureDetector(
                                        child: Container(
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  'assets/image/report.png',
                                                  width: 80,
                                                  height: 80,
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text('Gérer les rapports')
                                              ],
                                            ),
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blueGrey,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),

                                      onTap: () => Navigator.pushNamed(
                                          context, '/listRapport'),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                        child: Container(
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  'assets/image/avatar.png',
                                                  width: 80,
                                                  height: 80,
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text('Le Profil utilisateur')
                                              ],
                                            ),
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blueGrey,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),

                                      onTap: () => Navigator.pushNamed(
                                          context, '/profilUser'),
                                    ),
                                    SizedBox(width: 20),
                                    GestureDetector(
                                          child: Container(
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/image/people.png',
                                                    width: 80,
                                                    height: 80,
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text('Les utilisateurs')
                                                ],
                                              ),
                                            padding: EdgeInsets.only(
                                                top: 12,
                                                bottom: 12,
                                                left: 15,
                                                right: 15),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blueGrey,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                          ),

                                        onTap: () {
                                          final role = UserSimplePreference
                                                  .getUserRole() ??
                                              "";
                                          role != "User"
                                              ? Navigator.pushNamed(
                                                  context, '/listUser')
                                              : Utils.showSnackBar(context,
                                                  title:
                                                      "L'accès à cette fonctionnalité est reservé à l'administrateur seul",
                                                  bg: Colors.blueGrey);
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 3.0),
                        child: Center(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text('Jmk@2021 - tous les droits réservés',
                              style: TextStyle(fontSize: 11, color: Colors.grey),),
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
          );
        }
    );

  }
}

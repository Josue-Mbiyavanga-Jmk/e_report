import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rapport_app/models/app_user.dart';
import 'package:rapport_app/views/screens/home/home_view.dart';
import 'package:rapport_app/views/screens/authentification/login_view.dart';

//cette classe recupere l'etat du user afin de faire le routing

class SplashWrapperView extends StatefulWidget {
  const SplashWrapperView({Key? key}) : super(key: key);

  @override
  _SplashWrapperViewState createState() => _SplashWrapperViewState();
}

class _SplashWrapperViewState extends State<SplashWrapperView> {

  @override
  void initState() {
    //on recupère le user courant
    final user = Provider.of<AppUser?>(context, listen: false);
    super.initState();
    Timer(
        Duration(seconds: 8),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => user == null
                    ? LoginView()
                    : HomeView() //on navigue selon la connexion du user
                )));
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('E-report', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: Column(
          children:[
            Expanded(
                flex: 9,
                child: Container(
                  child: Center(
                    //report.json ou report_1.json ou completing_tasks.json
                      child: Column(
                        children: [
                          SizedBox(height: 30,),
                          Lottie.asset('assets/animation/completing_tasks.json'),
                          SizedBox(height: 30,),
                          Text('Bienvenu.e dans E-report', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),),

                        ],
                      )

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
            ]
        ),
      );
    }
}






import 'package:flutter/material.dart';
import 'package:rapport_app/models/car.dart';
import 'package:rapport_app/models/rapport.dart';
import 'package:rapport_app/views/screens/car/car_add_charge_versement_view.dart';
import 'package:rapport_app/views/screens/car/car_add_view.dart';
import 'package:rapport_app/views/screens/car/car_depense_list_view.dart';
import 'package:rapport_app/views/screens/car/car_detail_view.dart';
import 'package:rapport_app/views/screens/car/car_list_view.dart';
import 'package:rapport_app/views/screens/car/car_versement_list_view.dart';
import 'package:rapport_app/views/screens/home/home_view.dart';
import 'package:rapport_app/views/screens/authentification/login_view.dart';
import 'package:rapport_app/views/screens/profil/profil_user_view.dart';
import 'package:rapport_app/views/screens/rapport/rapport_add_view.dart';
import 'package:rapport_app/views/screens/rapport/rapport_detail_view.dart';
import 'package:rapport_app/views/screens/rapport/rapport_list_view.dart';
import 'package:rapport_app/views/screens/authentification/signup_view.dart';
import 'package:rapport_app/views/screens/splash_wrapper_view.dart';
import 'package:rapport_app/views/screens/user/user_list_view.dart';

//class qui gère les routes professionnelles
class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (context)=> SplashWrapperView());
      case '/signup':
        return MaterialPageRoute(builder: (context)=> SignupView());
      case '/login':
        return MaterialPageRoute(builder: (context)=> LoginView());
      case '/home':
        return PageRouteBuilder(
            pageBuilder: (context,animation,secondaryAnimation)=> HomeView(), //on part dans une autre page
            transitionsBuilder: (context,animation,secondaryAnimation,child){
              animation = CurvedAnimation(curve: Curves.ease,parent: animation);
              //ça sera de bas en haut l'apparition de l'ecran et l'inverse pour le retour
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            }
        );
      case '/detailCar':
        return PageRouteBuilder(
            pageBuilder: (context,animation,secondaryAnimation)=> CarView(car: settings.arguments as Car), //on part dans une autre page
            transitionsBuilder: (context,animation,secondaryAnimation,child){
              animation = CurvedAnimation(curve: Curves.ease,parent: animation);
              //ça sera de bas en haut l'apparition de l'ecran et l'inverse pour le retour
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            }
        );
      case '/listCar':
        return MaterialPageRoute(builder: (context)=> CarListView());
      case '/addCar':
        return MaterialPageRoute(builder: (context)=> CarAddView(car: settings.arguments as Car?));
      case '/addCarChargeEtVersement':
        return MaterialPageRoute(builder: (context)=> CarAddChargeVersementView(car: settings.arguments as Car));

      case '/listVersement':
        return MaterialPageRoute(builder: (context)=> CarVersementListView(car: settings.arguments as Car));
      case '/listDepense':
      return MaterialPageRoute(builder: (context)=> CarDepenseListView(car: settings.arguments as Car));

      case '/listRapport':
        return MaterialPageRoute(builder: (context)=> RapportListView());
      case '/addRapport':
        return MaterialPageRoute(builder: (context)=> RapportAddView(rapport: settings.arguments as Rapport?));
      case '/detailRapport':
        return MaterialPageRoute(builder: (context)=> RapportDetailView(rapport: settings.arguments as Rapport));

      case '/listUser':
        return MaterialPageRoute(builder: (context)=> UserListView());
      case '/profilUser':
        return MaterialPageRoute(builder: (context)=> ProfilUserView());

      default:
        return MaterialPageRoute(builder: (context)=> Scaffold(
          appBar: AppBar(title: Text("Error"),centerTitle: true),
          body: Center(
            child: Text("Page not found"),
          ),
        ));
    }
  }
}
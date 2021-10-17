import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

//decoration des inputs

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,//couleur de remplissage
  filled: true,
  contentPadding: EdgeInsets.all(12.0), //espace du contenu interieur
  //la bordure normale du champs de saisie
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueGrey, width: 1.0)
  ),
  //la bordure au moment focus du champs de saisie
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 1.0)
  ),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.0)
  ),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.0)
  ),
);


//méthode pour configurer progress Dialog
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  //..customAnimation = CustomAnimation();
}
//méthode pour le dropdown
DropdownMenuItem<String> buildMenuItem(String item)=> DropdownMenuItem(
  value: item,
  child: Text(
    item,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
  ),
);

//méthode pour afficher la date au format humain
String getTextOfDate(DateTime myDate){
  return '${myDate.day}/${myDate.month}/${myDate.year}';

}
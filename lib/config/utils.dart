import 'package:flutter/material.dart';

class Utils{

//methode qui retourne un snackbar
  static void showSnackBar(BuildContext context, {required String title, required Color bg})=>
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(title),
              backgroundColor: bg,
              padding: EdgeInsets.all(8)
          )
      );

  static void showSuccesAlertDialog(BuildContext context)=> showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Opération réussie!'),
          content: Text('Votre compte a été créé avec succès. Attendez votre activation pour vous connecter, merci.'),
          actions: <Widget>[
            TextButton(
                onPressed: (){
                  _dismissDialog(context);
                  _dismissDialog(context);
        }, //on le fait disparaitre
                child: Text('Ok')
            ),
          ],
        );
      }

  );
  //methode pour faire disparaitre le dialog
  //NB: c'est une méthode privée voilà pourquoi elle a _ devant son nom
  static void _dismissDialog(BuildContext context) => Navigator.of(context).pop();
}
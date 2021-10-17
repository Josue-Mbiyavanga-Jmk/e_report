import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:rapport_app/config/constant.dart';
import 'package:rapport_app/models/app_user.dart';
import 'package:rapport_app/models/car.dart';
import 'package:rapport_app/services/car_firebase_database.dart';
import 'package:rapport_app/views/widgets/button_widget.dart';

class CarAddView extends StatefulWidget {
  final Car? car;
  const CarAddView({Key? key, required this.car}) : super(key: key);

  @override
  _CarAddViewState createState() => _CarAddViewState();
}

class _CarAddViewState extends State<CarAddView> {
  //
  late Car? unCar;
  //validateur des champs de saisie
  final _formKey = GlobalKey<FormState>();
  String error ='';
  Timer? _timer; //pour le progress

  //creation des controllers
  final nameController = TextEditingController();
  final marqueController = TextEditingController();
  final versementController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    unCar = widget.car;
    if(unCar != null){
      nameController.text = unCar!.name.toString();
      marqueController.text = unCar!.marque.toString();
      versementController.text = unCar!.tarif_versement.toString();
    }
  }


  @override
  void dispose() {
  //quand on aura plus besoin
  nameController.dispose();
  marqueController.dispose();
  versementController.dispose();

  //
  super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //on prend le user depuis le main.dart pour l'utiliser
    final user = Provider.of<AppUser>(context);
    final carDatabase = CarDatabaseService(uid: user.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          unCar == null ? 'Ajouter Voiture':'Modifier Voiture',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        elevation: 1.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 40.0,
              ),
              TextFormField(
                controller: nameController,
                //pour recuperer la valeur
                decoration: textInputDecoration.copyWith(hintText: "nom voiture"),
                //le style + son placeholder
                validator: (value) =>
                    value!.isEmpty ? "Entrer un nom de voiture" : null,
              ),
              SizedBox(
                height: 15.0,
              ),
              //le separateur entre les champs du formulaire
              TextFormField(
                controller: marqueController, //pour recuperer la valeur
                decoration: textInputDecoration.copyWith(
                    hintText: "marque voiture"), //le style + son placeholder
                validator: (value) =>
                    value!.isEmpty ? "Entrer une marque de voiture" : null,
              ),
              SizedBox(
                height: 15.0,
              ),
              //le separateur entre les champs du formulaire
              TextFormField(
                controller: versementController, //pour recuperer la valeur
                decoration: textInputDecoration.copyWith(
                    hintText: "montant versement du jour en \$"), //le style + son placeholder
                validator: (value) =>
                value!.isEmpty ? "Entrer un montant de versement" : null,
              ),
              SizedBox(
                height: 25.0,
              ),
              //le separateur entre les champs du formulaire
              ButtonWidget(
                title: unCar == null? 'Enregistrer' : 'Modifier',
                hasBorder: false,
                //onTap: ()=>Navigator.pushNamed(context, '/dropdown'),
                onTap: () async {
                  //checking form valid
                  if (_formKey.currentState!.validate()) {
                    //on commence par lancer le progress
                    _timer?.cancel();
                    await EasyLoading.show(
                      status: 'opération en cours...',
                      maskType: EasyLoadingMaskType.black,
                    );
                    //recuperation des valeurs du form
                    var name = nameController.value.text;
                    var marque = marqueController.value.text;
                    var versement = versementController.value.text;
                    if(unCar == null){
                      //appel de firebase pour inserer
                       await carDatabase.saveCar(name, marque,double.parse(versement), 0, 0);
                    }
                    else{
                      //appel de firebase pour mettre à jour
                      await carDatabase.updateCar(unCar!.id, name, marque,double.parse(versement), unCar!.total_versement, unCar!.total_depense);
                    }


                    // if (result == null) {
                    //   //on bloque le progress en changeant son etat
                    //   _timer?.cancel();
                    //   await EasyLoading.dismiss();
                    //   //on change erreur etat
                    //   setState(() =>
                    //       //definition de l'erreur
                    //       error = "Veuillez envoyer des coordonnées valides");
                    // }
                      //on bloque le progress en changeant son etat
                      _timer?.cancel();
                      await EasyLoading.dismiss();
                      //pour afficher le message de succes
                      _timer?.cancel();
                      await EasyLoading.showSuccess(
                          unCar == null ? 'Voiture ajoutée avec succès!' : 'Voiture modifiée avec succès!'
                      );

                      Timer(
                          Duration(seconds: 2),
                              () {
                                if(unCar == null){
                                  Navigator.pop(context);
                                }
                                else{
                                  //astuce pour rentrer directement dans la liste (2 pop)
                                  int count = 0;
                                  Navigator.popUntil(context, (route) {
                                    return count++ == 2;
                                  });
                                }
                          }
                      );

                  }
                },
              ),
              error == ''
                  ? Container()
                  : SizedBox(
                      height: 10.0,
                    ),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 15.0),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

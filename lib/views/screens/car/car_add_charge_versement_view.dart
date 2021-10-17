import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:rapport_app/config/constant.dart';
import 'package:rapport_app/models/app_user.dart';
import 'package:rapport_app/models/car.dart';
import 'package:rapport_app/services/car_firebase_database.dart';
import 'package:rapport_app/services/versement_firebase_database.dart';
import 'package:rapport_app/views/widgets/button_widget.dart';
import 'package:rapport_app/views/widgets/date_widget/date_picker_widget.dart';

import 'car_list_view.dart';

class CarAddChargeVersementView extends StatefulWidget {
  final Car car;
  const CarAddChargeVersementView({Key? key, required this.car}) : super(key: key);

  @override
  _CarAddChargeVersementViewState createState() => _CarAddChargeVersementViewState();
}

class _CarAddChargeVersementViewState extends State<CarAddChargeVersementView> {

  //validateur des champs de saisie
  final _formKey = GlobalKey<FormState>();
  String error ='';
  Timer? _timer; //pour le progress
  final types = ['Depense','Versement'];//liste des items du dropdown
  String? selectedType;//item selectionné
  DateTime? selectedDate; //date qu'on va recevoir du DatePickerWidget

  //creation des controllers
  final montantController = TextEditingController();
  final observatiobController = TextEditingController();
  //pour versement et car_id, automatiquement
  //pour l'utiliser en bas
  late Car unCar;
  //méthode pour le recuperer dans le widget enfant
  void updateDate (DateTime? value) => setState(() => selectedDate = value);

  @override
  void initState() {
    super.initState();
    //recuperation du param passé au widget pour l'utiliser en bas
    unCar = widget.car;
  }

  @override
  void dispose() {
    //quand on aura plus besoin
    montantController.dispose();
    observatiobController.dispose();
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //on prend le user depuis le main.dart pour l'utiliser
    final user = Provider.of<AppUser>(context);
    final versementDatabase = VersementDatabaseService(uid: user.uid);
    final carDatabase = CarDatabaseService(uid: user.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ajouter Versement ou Dépense',
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey, width: 2),
                    borderRadius: BorderRadius.circular(4)
                ),
                child: DropdownButtonHideUnderline( //permet de supprimer la ligne en bas du dropdown
                  child: DropdownButton<String>(
                    hint: Text('Choisir opération',style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.black)),
                    value: selectedType,//on affiche item selectionné
                    items: types.map(buildMenuItem).toList(),
                    onChanged: (value)=> setState(()=>selectedType = value),
                    isExpanded: true, //prend toute la largeur de l'ecran
                    iconSize: 36, //taille de l'icon
                    icon: Icon(Icons.arrow_drop_down, color: Colors.blueGrey,),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey, width: 2),
                    borderRadius: BorderRadius.circular(4)
                ),
                child: DatePickerWidget(callback: (val) => updateDate(val)),
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: montantController,
                //pour recuperer la valeur
                decoration: textInputDecoration.copyWith(
                    hintText: selectedType == null ? "montant en \$" : selectedType == 'Versement'? "montant encaissé en \$": "montant depensé en \$"
                ),
                //le style + son placeholder
                validator: (value) =>
                value!.isEmpty ? "Entrer un montant" : null,
              ),
              SizedBox(
                height: 15.0,
              ),
              //le separateur entre les champs du formulaire
              TextFormField(
                controller: observatiobController, //pour recuperer la valeur
                decoration: textInputDecoration.copyWith(
                    hintText: "observation"), //le style + son placeholder
                validator: (value) =>
                value!.isEmpty ? "Entrer une observation" : null,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 5,
              ),
              SizedBox(
                height: 25.0,
              ),
              //le separateur entre les champs du formulaire
              ButtonWidget(
                title: 'Enregistrer',
                hasBorder: false,
                //onTap: ()=>Navigator.pushNamed(context, '/dropdown'),
                onTap: () async {
                  //checking form valid
                  if (_formKey.currentState!.validate()
                      && selectedType != null && selectedDate != null) {
                    //on commence par lancer le progress
                    _timer?.cancel();
                    await EasyLoading.show(
                      status: 'opération en cours...',
                      maskType: EasyLoadingMaskType.black,
                    );
                    //recuperation des valeurs du form
                    var montant = montantController.value.text;
                    final montantSaisi = double.parse(montant);
                    var observation = observatiobController.value.text;
                    //appel de firebase pour inserer
                   if(selectedType == 'Versement'){
                     //ajout du versement
                     await versementDatabase.saveVersement(unCar.id, selectedDate!,montantSaisi, unCar.tarif_versement, observation );
                    //update voiture
                     unCar.total_versement = unCar.total_versement + montantSaisi;
                     await carDatabase.updateCar(unCar.id, unCar.name, unCar.marque, unCar.tarif_versement, unCar.total_versement, unCar.total_depense);

                   }
                   else{
                     //ajout de la depense
                     await versementDatabase.saveDepense(unCar.id, selectedDate!,montantSaisi, observation );
                     //update voiture
                     unCar.total_depense = unCar.total_depense + montantSaisi;
                     await carDatabase.updateCar(unCar.id, unCar.name, unCar.marque, unCar.tarif_versement, unCar.total_versement, unCar.total_depense);
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
                        selectedType == 'Versement'? 'Versement ajouté avec succès!':'Depense ajoutée avec succès!'
                    );

                    Timer(
                        Duration(seconds: 2),
                            () {
                              //astuce pour rentrer directement dans la liste (2 pop)
                              int count = 0;
                              Navigator.popUntil(context, (route) {
                                return count++ == 2;
                              });

                              /*Navigator.of(context)
                                 .pushNamedAndRemoveUntil('/Destination', ModalRoute.withName('/poptillhere'),arguments: if you have any);

                              Navigator.pop(context);

                              Navigator.of(context).popUntil((route){
                                return route.settings.name == 'detailCar';
                              });

                              Navigator.of(context).popUntil((route) => route.settings.name == "/listCar");

                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (c) => CarListView()),
                              (route) => false);*/

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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:rapport_app/config/constant.dart';
import 'package:rapport_app/models/app_user.dart';
import 'package:rapport_app/models/rapport.dart';
import 'package:rapport_app/services/rapport_firebase_database.dart';
import 'package:rapport_app/views/widgets/button_widget.dart';
import 'package:rapport_app/views/widgets/date_widget/date_picker_widget.dart';

class RapportAddView extends StatefulWidget {
  final Rapport? rapport;
  const RapportAddView({Key? key, required this.rapport}) : super(key: key);

  @override
  _RapportAddViewState createState() => _RapportAddViewState();
}

class _RapportAddViewState extends State<RapportAddView> {
  //
  late Rapport? unRapport;
  //validateur des champs de saisie
  final _formKey = GlobalKey<FormState>();
  String error ='';
  Timer? _timer; //pour le progress
  DateTime? selectedDate; //date qu'on va recevoir du DatePickerWidget
  //creation des controllers
  final descriptionController = TextEditingController();
  final observationController = TextEditingController();

  //méthode pour le recuperer dans le widget enfant
  void updateDate (DateTime? value) => setState(() => selectedDate = value);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    unRapport = widget.rapport;
    if(unRapport != null){
      descriptionController.text = unRapport!.description.toString();
      observationController.text = unRapport!.observation.toString();
      selectedDate = unRapport!.date;

    }
  }


  @override
  void dispose() {
  //quand on aura plus besoin
  descriptionController.dispose();
  observationController.dispose();
  //
  super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //on prend le user depuis le main.dart pour l'utiliser
    final user = Provider.of<AppUser>(context);
    final rapportDatabase = RapportDatabaseService(uid: user.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          unRapport == null ? 'Ajouter Rapport':'Modifier Rapport',
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
                padding: unRapport != null ?
                EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0):
                EdgeInsets.all(0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey, width: 2),
                    borderRadius: BorderRadius.circular(4)
                ),
                child: unRapport != null ? Text('Le '+getTextOfDate(selectedDate!)):
                DatePickerWidget(callback: (val) => updateDate(val)),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: descriptionController,
                //pour recuperer la valeur
                decoration: textInputDecoration.copyWith(hintText: "libellé du rapport"),
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 4,
                //le style + son placeholder
                validator: (value) =>
                    value!.isEmpty ? "Entrer un libellé du rapport" : null,
              ),
              SizedBox(
                height: 15.0,
              ),
              //le separateur entre les champs du formulaire
              TextFormField(
                controller: observationController, //pour recuperer la valeur
                decoration: textInputDecoration.copyWith(
                    hintText: "observation de votre rapport"), //le style + son placeholder
                keyboardType: TextInputType.multiline,
                minLines: 12,
                maxLines: 22,
                validator: (value) =>
                    value!.isEmpty ? "Entrer une observation du rapport" : null,
              ),
              SizedBox(
                height: 15.0,
              ),
              //le separateur entre les champs du formulaire

              SizedBox(
                height: 25.0,
              ),
              //le separateur entre les champs du formulaire
              ButtonWidget(
                title: unRapport == null? 'Enregistrer' : 'Modifier',
                hasBorder: false,
                //onTap: ()=>Navigator.pushNamed(context, '/dropdown'),
                onTap: () async {
                  //checking form valid
                  if (_formKey.currentState!.validate() && selectedDate != null) {
                    //on commence par lancer le progress
                    _timer?.cancel();
                    await EasyLoading.show(
                      status: 'opération en cours...',
                      maskType: EasyLoadingMaskType.black,
                    );
                    //recuperation des valeurs du form
                    var description = descriptionController.value.text;
                    var observation = observationController.value.text;

                    if(unRapport == null){
                      //appel de firebase pour inserer
                       await rapportDatabase.saveRapport(selectedDate!, description,observation);
                    }
                    else{
                      //appel de firebase pour mettre à jour
                      await rapportDatabase.updateRapport(unRapport!.id, selectedDate!, description,observation);

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
                          unRapport == null ? 'Rapport ajouté avec succès!' : 'Rapport modifié avec succès!'
                      );

                      Timer(
                          Duration(seconds: 2),
                              () {
                                  if(unRapport == null){
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

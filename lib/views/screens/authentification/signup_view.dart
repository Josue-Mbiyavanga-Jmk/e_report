import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rapport_app/config/constant.dart';
import 'package:rapport_app/config/utils.dart';
import 'package:rapport_app/services/authentication.dart';
import 'package:rapport_app/views/widgets/button_widget.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

  //objet authentificationFirebase
  final AuthenticationService _auth = AuthenticationService();
  //validateur des champs de saisie
  final _formKey = GlobalKey<FormState>();
  String error ='';
  Timer? _timer; //pour le progress

  final roles = ['Admin','Sa','User'];//liste des items du dropdown
  String? selectedRole;//item selectionné
  //creation des controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //méthode qui permet au formulaire d'etre propre quand on change d'ecran
  void toggleView() {
    //gestion de l'etat
    setState(() {
      _formKey.currentState!.reset(); //pour ignorer la validation en changeant d'ecran
      error=''; //pour ignorer l'erreur en changeant d'ecran
      nameController.text ='';
      emailController.text ='';
      passwordController.text ='';
    });
  }


  @override
  void dispose() {
    //quand on aura plus besoin
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Identification', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        elevation: 1.0,
      ),
      body:Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        child: Form(
          key: _formKey,
          child:Column(
            children: [
              Expanded(
                  flex: 9,
                  child: Container(
                    child: ListView(
                      children: [
                        SizedBox(height: 40.0,),
                        TextFormField(
                          controller: nameController,//pour recuperer la valeur
                          decoration: textInputDecoration.copyWith(hintText: "nom"), //le style + son placeholder
                          validator: (value) => value!.isEmpty ? "Entrer un nom" : null,
                        ),
                        SizedBox(height: 15.0,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey, width: 2),
                              borderRadius: BorderRadius.circular(4)
                          ),
                          child: DropdownButtonHideUnderline( //permet de supprimer la ligne en bas du dropdown
                            child: DropdownButton<String>(
                              hint: Text('Choisir un role',style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.black)),
                              value: selectedRole,//on affiche item selectionné
                              items: roles.map(buildMenuItem).toList(),
                              onChanged: (value)=> setState(()=>selectedRole = value),
                              isExpanded: true, //prend toute la largeur de l'ecran
                              iconSize: 36, //taille de l'icon
                              icon: Icon(Icons.arrow_drop_down, color: Colors.blueGrey,),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        TextFormField(
                          controller: emailController,//pour recuperer la valeur
                          decoration: textInputDecoration.copyWith(hintText: "email"), //le style + son placeholder
                          validator: (value) => value!.isEmpty ? "Entrer un e-mail" : null,
                        ),
                        SizedBox(height: 15.0,) , //le separateur entre les champs du formulaire
                        TextFormField(
                          controller: passwordController,//pour recuperer la valeur
                          obscureText: true, //cacher la valeur saisie du mot de passe
                          decoration: textInputDecoration.copyWith(hintText: "mot de passe"), //le style + son placeholder
                          validator: (value) => value!.length < 6 ? "Entrer un passe de longueur 6 ou plus" : null,
                        ),
                        SizedBox(height: 25.0,) , //le separateur entre les champs du formulaire
                        ButtonWidget(
                          title: 'S\'enregistrer',
                          hasBorder: false,
                          //onTap: ()=>Navigator.pushNamed(context, '/dropdown'),
                          onTap: () async{
                            //checking form valid
                            if(_formKey.currentState!.validate() && selectedRole != null){
                              //on commence par lancer le progress
                              _timer?.cancel();
                              await EasyLoading.show(
                                status: 'enregistrement...',
                                maskType: EasyLoadingMaskType.black,
                              );
                              //recuperation des valeurs du form
                              var name = nameController.value.text;
                              var email = emailController.value.text;
                              var password = passwordController.value.text;
                              //appel de firebase
                              dynamic result = await _auth.registerWithEmailAndPassword(name,selectedRole!,0,email,password);

                              if(result == null){
                                //on bloque le progress en changeant son etat
                                _timer?.cancel();
                                await EasyLoading.dismiss();
                                //on change erreur etat
                                setState(() =>
                                //definition de l'erreur
                                error = "Veuillez envoyer des coordonnées valides"
                                );

                              }
                              else{
                                //on bloque le progress en changeant son etat
                                _timer?.cancel();
                                await EasyLoading.dismiss();
                                //pour afficher le message de succes
                                //_timer?.cancel();
                                //await EasyLoading.showSuccess('Compte créé avec succès! Attendez votre activation pour vous connecter');
                                toggleView();
                                Utils.showSuccesAlertDialog(context);

                                //Navigator.pop(context);
                                /*Timer(
                                    Duration(seconds: 3),
                                        () {
                                          toggleView();
                                          Navigator.pop(context);

                                      *//*Navigator.of(context)
                                    .pushNamedAndRemoveUntil('/signup', (Route<dynamic> route) => false);*//*
                                    }
                                );*/
                                //on enleve cet ecran du schema de navigation


                              }




                            }
                          },
                        ),
                        error =='' ? Container() : SizedBox(height: 25.0,) ,
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 15.0),
                        ),


                      ],
                    ),
                  )
              ),
              Expanded(
                  child: Container(
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
          )
        ),
      ),
    );
  }


}

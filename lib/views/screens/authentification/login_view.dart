import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rapport_app/config/constant.dart';
import 'package:rapport_app/memory/preference.dart';
import 'package:rapport_app/services/authentication.dart';
import 'package:rapport_app/services/user_firebase_database.dart';
import 'package:rapport_app/views/widgets/button_widget.dart';
import 'dart:async';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //objet authentificationFirebase
  final AuthenticationService _auth = AuthenticationService();
  //validateur des champs de saisie
  final _formKey = GlobalKey<FormState>();
  String error ='';
  Timer? _timer; //pour le progress
  //creation des controllers
  //final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //méthode qui permet au formulaire d'etre propre quand on change d'ecran
  void toggleView() {
    //gestion de l'etat
    setState(() {
      _formKey.currentState!.reset(); //pour ignorer la validation en changeant d'ecran
      error=''; //pour ignorer l'erreur en changeant d'ecran
      emailController.text ='';
      passwordController.text ='';
    });

  }

  @override
  void dispose() {
    //quand on aura plus besoin
    //nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentification', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        elevation: 1.0,
      ),
      body:Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                  flex: 9,
                  child: Container(
                    child: ListView(
                      children: [
                        SizedBox(height: 40.0,),
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
                          validator: (value) => value!.length < 4 ? "Entrer un passe de longueur 4" : null,
                        ),
                        SizedBox(height: 25.0,) , //le separateur entre les champs du formulaire
                        ButtonWidget(
                          title: 'Se connecter',
                          hasBorder: false,
                          //onTap: ()=>Navigator.pushNamed(context, '/dropdown'),
                          onTap: () async{
                            //checking form valid
                            if(_formKey.currentState!.validate()){
                              //on commence par lancer le progress
                              _timer?.cancel();
                              await EasyLoading.show(
                                status: 'connexion...',
                                maskType: EasyLoadingMaskType.black,
                              );
                              //recuperation des valeurs du form
                              var email = emailController.value.text;
                              var password = passwordController.value.text;
                              //appel de firebase
                              dynamic result = await _auth.signInWithEmailAndPassword(email, password);


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
                                //appel du user pour tester son etat
                                //final appData = await DatabaseService(uid: result.uid).user.first;
                                final appData = await DatabaseService(uid: '').getUser(result.uid);
                                //on bloque le progress en changeant son etat
                                _timer?.cancel();
                                await EasyLoading.dismiss();
                                print(appData.uid);
                                if(appData.status == 0){
                                  setState(() =>
                                  //definition de l'erreur
                                  error = "Compte pas encore activé! Attendez votre activation pour vous connecter"
                                  );
                                  // _timer?.cancel();
                                  // await EasyLoading.showSuccess('Compte pas encore activé! Attendez votre activation pour vous connecter');
                                }
                                else{
                                  await UserSimplePreference.setUserUID(appData.uid);
                                  await UserSimplePreference.setUserName(appData.name);
                                  await UserSimplePreference.setUserEmail(appData.email);
                                  Navigator.pushReplacementNamed(context, '/home');
                                }



                              }


                            }
                          },
                        ),
                        error =='' ? Container() : SizedBox(height: 10.0,) ,
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 15.0),
                        ),
                        SizedBox(height: 10.0,) ,
                        ButtonWidget(
                          title: 'Créer un compte',
                          hasBorder: true,
                          onTap: (){
                            toggleView();
                            Navigator.pushNamed(context, '/signup');
                          }

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
          ),
        ),
      ),
    );
  }
}

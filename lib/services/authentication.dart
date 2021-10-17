import 'package:firebase_auth/firebase_auth.dart';

import 'package:rapport_app/models/app_user.dart';

import 'user_firebase_database.dart';

class AuthenticationService {
  //on prend l'instance de l'authentification
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //méthode de conversion du user de firebase en un user de l'application
  AppUser? userFromFirebaseUser(User? user){ //Avant = User

    return user != null ? AppUser(uid:user.uid) : null;
  }
  //permet de recuperer le user courant et d'ecouter la connexion et/ou déconnexion du user
  Stream<AppUser?> get user{

    return _auth.authStateChanges().map(userFromFirebaseUser);
}

  //methode de connexion à firebase
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;//avant = User
      return userFromFirebaseUser(user);//le retour c'est notre objet user de l'application

    }catch(exception){
      print(exception.toString());
      return null;
    }
  }

  //methode d'enregistrement à firebase
  Future registerWithEmailAndPassword(String name, String role, int status, String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user; //avant = User
      //ici on crée le document user dans firestore
      await DatabaseService(uid: user!.uid).saveUser(name, role, 0, email);
      return userFromFirebaseUser(user);//le retour c'est notre objet user de l'application

    }catch(exception){
      print(exception.toString());
      return null;
    }
  }

  //methode de deconnexion à firebase
  Future signOut() async{
    try{

      return _auth.signOut();

    }catch(exception){
      print(exception.toString());
      return null;
    }
  }


}
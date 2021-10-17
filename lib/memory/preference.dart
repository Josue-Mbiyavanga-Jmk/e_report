

import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreference{
  static late SharedPreferences _preferences; //une variable privée
  //les variables des clés
  static const _keyUserUID = 'uid';
  static const _keyUserName = 'name';
  static const _keyUserRole = 'role';
  static const _keyUserEmail = 'email';
  //methode pour initialiser la preference
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  //methode pour garder le role
  static Future setUserRole(String role) async =>
      await _preferences.setString(_keyUserRole, role);
  //methode pour recuperer le role
  static String? getUserRole()  =>
       _preferences.getString(_keyUserRole);
  //methode pour garder le uid de l'utilisateur connecté
  static Future setUserUID(String uid) async =>
      await _preferences.setString(_keyUserUID, uid);
  //methode pour recuperer le role
  static String? getUserUID()  =>
      _preferences.getString(_keyUserUID);
  //methode pour garder le name de l'utilisateur connecté
  static Future setUserName(String name) async =>
      await _preferences.setString(_keyUserName, name);
  //methode pour recuperer le name
  static String? getUserName()  =>
      _preferences.getString(_keyUserName);
  //methode pour garder l'email de l'utilisateur connecté
  static Future setUserEmail(String email) async =>
      await _preferences.setString(_keyUserEmail, email);
  //methode pour recuperer l'email
  static String? getUserEmail()  =>
      _preferences.getString(_keyUserEmail);
}
//une classe qui nous permet de recuperer le user de firebase
class AppUser{
  final String uid;
  //constructeur
  AppUser({required this.uid});
}

//une classe qui nous permet de garder nos user dans notre base avec détails
class AppUserData{
  final String uid;
  final String name;
  final String role;
  late int status; //0 = bloqué et 1 actif
  final String email;

  AppUserData({required this.uid, required this.name, required this.role, required this.status, required this.email});
//constructeur

}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rapport_app/models/app_user.dart';


class DatabaseService{

  final String uid;
  //constructeur
  DatabaseService({ required this.uid});
  //les collections
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  //méthode utilitaire : transforme un document firestore en mon objet AppUserData
  AppUserData userFromSnapshot(DocumentSnapshot snapshot){
    return AppUserData(
        uid: snapshot.id,
        name: snapshot.get('name'),
        role: snapshot.get('role'),
        status: snapshot.get('status'),
        email: snapshot.get('email')
    );
  }
  //méthode utilitaire : transforme une collection firestore en ma liste des objets AppUserData
  List<AppUserData> userListFromSnapshot(QuerySnapshot snapshot){
      //return snapshot.docs.map((e) => return userFromSnapshot(e.data()););
      List<AppUserData> list = [];
      snapshot.docs.forEach((element) {
        list.add(userFromSnapshot(element));
      });
       return list;

  }

  //permet de recuperer un user dans firestore
  Stream<AppUserData> get user{

    return userCollection.doc(uid).snapshots().map(userFromSnapshot);
  }

  //permet de recuperer tous les users dans firestore
  Stream<List<AppUserData>> get users{

    return userCollection.snapshots().map(userListFromSnapshot);
  }
  //les méthodes CRUD

  //1: insert
  Future<void> saveUser(String name, String role, int status, String email) async{
    return await userCollection.doc(uid).set({
        'name':name,
        'role':role,
        'status':status,
        'email':email
    });
  }
  //2: update
  Future<void> updateUser(AppUserData appUserData,  int status) async{
    return await userCollection.doc(appUserData.uid).set({
      'name':appUserData.name,
      'role':appUserData.role,
      'status':status,
      'email':appUserData.email

    });
  }
  //3: read document
  Future<AppUserData> getUser(String id) async{

    final document = await userCollection.doc(id).get();
    //
    return AppUserData(
        uid: id,
        name: document.get('name'),
        role: document.get('role'),
        status: document.get('status'),
        email: document.get('email')
    );

  }

}
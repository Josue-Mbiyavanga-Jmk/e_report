
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rapport_app/models/rapport.dart';


class RapportDatabaseService{

  final String uid;
  //constructeur
  RapportDatabaseService({ required this.uid});
  //la collection
  final CollectionReference rapportCollection =
      FirebaseFirestore.instance.collection("rapports");

  //méthode utilitaire : transforme un document firestore en mon objet Rapport
  Rapport rapportFromSnapshot(DocumentSnapshot snapshot){

    return Rapport(
        id: snapshot.id,
        date: snapshot.get('date').toDate(),
        //date: unRapport.date,
        description: snapshot.get('description'),
        observation: snapshot.get('observation')
    );
  }

  //méthode utilitaire : transforme une collection firestore en ma liste des objets AppUserData
  List<Rapport> rapportListFromSnapshot(QuerySnapshot snapshot){
      //return snapshot.docs.map((e) => return userFromSnapshot(e.data()););
      List<Rapport> list = [];
      snapshot.docs.forEach((element) {
        list.add(rapportFromSnapshot(element));
      });
      //tri par date
      Comparator<Rapport> sortByDate = (a, b) => a.date.compareTo(b.date);
      list.sort(sortByDate);
      list = list.reversed.toList();
      return list;

  }

  //permet de recuperer une voiture dans firestore
  Stream<Rapport> get rapport{

    return rapportCollection.doc(uid).snapshots().map(rapportFromSnapshot);
  }

  //permet de recuperer toutes les voitures dans firestore
  Stream<List<Rapport>> get rapports{

    return rapportCollection.snapshots().map(rapportListFromSnapshot);
  }


  //les méthodes CRUD

  //1: insert
   Future<void> saveRapport(DateTime date, String description, String observation) async{
    return await rapportCollection.doc().set({
        'date':date,
        'description':description,
        'observation':observation

    });
  }

  Future<void> updateRapport(String id, DateTime date, String description, String observation) async{
    return await rapportCollection.doc(id).set({
      'date':date,
      'description':description,
      'observation':observation
    });
  }


}
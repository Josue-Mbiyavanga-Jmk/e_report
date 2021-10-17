
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rapport_app/models/car_versement.dart';

//meme service pour versement et depenses
class VersementDatabaseService{

  final String uid;
  //constructeur
  VersementDatabaseService({ required this.uid});
  //les collections
  final CollectionReference versementCollection =
        FirebaseFirestore.instance.collection("versements");
  final CollectionReference depenseCollection =
        FirebaseFirestore.instance.collection("depenses");

  //méthode utilitaire : transforme un document firestore en mon objet CarVersement
  CarVersement versementFromSnapshot(DocumentSnapshot snapshot){
    return CarVersement(
        id: snapshot.id,
        //car_id: snapshot.data()['car_id'],
        car_id: snapshot.get('car_id'),
        date: snapshot.get('date').toDate(),
        montant: snapshot.get('montant'),
        versement: snapshot.get('versement'),
        observation: snapshot.get('observation')
      /*id: snapshot.id,
      car_id: snapshot.data().toString().contains('car_id') ? snapshot.get('car_id') : '',
      date: snapshot.data().toString().contains('date') ?snapshot.get('date').toDate() : DateTime.now(),
      montant: snapshot.data().toString().contains('montant') ? snapshot.get('montant'): 0,
      versement: snapshot.data().toString().contains('versement') ? snapshot.get('versement'): 0,
      observation: snapshot.data().toString().contains('observation') ? snapshot.get('observation'): '',*/
    );
  }

  //méthode utilitaire : transforme un document firestore en mon objet CarDepense
  CarDepense depenseFromSnapshot(DocumentSnapshot snapshot){
    return CarDepense(
        id: snapshot.id,
        //car_id: snapshot.data()['car_id'],
        car_id: snapshot.get('car_id'),
        date: snapshot.get('date').toDate(),
        montant: snapshot.get('montant'),
        observation: snapshot.get('observation')
    );
  }
  //méthode utilitaire : transforme une collection firestore en ma liste des objets CarVersement
  List<CarVersement> versementListFromSnapshot(QuerySnapshot snapshot){
      //return snapshot.docs.map((e) => return userFromSnapshot(e.data()););
      List<CarVersement> list = [];
      snapshot.docs.forEach((element) {
        list.add(versementFromSnapshot(element));
      });
      //tri par date
      Comparator<CarVersement> sortByDate = (a, b) => a.date.compareTo(b.date);
      list.sort(sortByDate);
      list = list.reversed.toList();
       return list;

  }

  //méthode utilitaire : transforme une collection firestore en ma liste des objets CarDepense
  List<CarDepense> depenseListFromSnapshot(QuerySnapshot snapshot){
      //return snapshot.docs.map((e) => return userFromSnapshot(e.data()););
      List<CarDepense> list = [];
      snapshot.docs.forEach((element) {
        list.add(depenseFromSnapshot(element));
      });
      //tri par date
      Comparator<CarDepense> sortByDate = (a, b) => a.date.compareTo(b.date);
      list.sort(sortByDate);
      list = list.reversed.toList();
      return list;

  }

  /* Pour Versement */

  //permet de recuperer une voiture dans firestore
  Stream<CarVersement> get versement{

    return versementCollection.doc(uid).snapshots().map(versementFromSnapshot);
  }

  //permet de recuperer toutes les voitures dans firestore
  Stream<List<CarVersement>> get versements {
    //on lui donne le parametre
    return versementCollection.where("car_id", isEqualTo: uid).snapshots().map(versementListFromSnapshot);
    //return versementCollection.snapshots().map(versementListFromSnapshot);

  }


  //les méthodes CRUD

  //1: insert
   Future<void> saveVersement(String car_id, DateTime date, double montant, double versement, String observation) async{
    return await versementCollection.doc().set({
        'car_id':car_id,
        'date':date,
        'montant':montant,
        'versement':versement,
        'observation':observation

    });
  }

  /* Pour Depense */

  //permet de recuperer une voiture dans firestore
  Stream<CarDepense> get depense{

    return depenseCollection.doc(uid).snapshots().map(depenseFromSnapshot);
  }

  //permet de recuperer toutes les voitures dans firestore
  Stream<List<CarDepense>> get depenses{

    return depenseCollection.where("car_id", isEqualTo: uid).snapshots().map(depenseListFromSnapshot);
  }


  //les méthodes CRUD

  //1: insert
  Future<void> saveDepense(String car_id, DateTime date, double montant, String observation) async{
    return await depenseCollection.doc().set({
      'car_id':car_id,
      'date':date,
      'montant':montant,
      'observation':observation

    });
  }


}
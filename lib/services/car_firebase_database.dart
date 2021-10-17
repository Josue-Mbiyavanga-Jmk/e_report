
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rapport_app/models/car.dart';


class CarDatabaseService{

  final String uid;
  //constructeur
  CarDatabaseService({ required this.uid});
  //la collection
  final CollectionReference carCollection =
      FirebaseFirestore.instance.collection("voitures");

  //méthode utilitaire : transforme un document firestore en mon objet Car
  Car carFromSnapshot1(DocumentSnapshot snapshot ){
    return Car(
      id: snapshot.id,
      name: snapshot.data().toString().contains('name') ? snapshot.get('name') : '',
      marque: snapshot.data().toString().contains('marque') ?snapshot.get('marque') : '',
      tarif_versement: snapshot.data().toString().contains('tarif_versement') ? snapshot.get('tarif_versement'): '',
      total_versement: snapshot.data().toString().contains('total_versement') ? snapshot.get('total_versement'): '',
      total_depense: snapshot.data().toString().contains('total_depense') ? snapshot.get('total_depense'): '',

    );
  }
  Car carFromSnapshot(QueryDocumentSnapshot snapshot ){
    return Car(
        id: snapshot.id,
        name: snapshot.data().toString().contains('name') ? snapshot.get('name') : '',
        marque: snapshot.data().toString().contains('marque') ?snapshot.get('marque') : '',
        tarif_versement: snapshot.data().toString().contains('tarif_versement') ? snapshot.get('tarif_versement'): '',
        total_versement: snapshot.data().toString().contains('total_versement') ? snapshot.get('total_versement'): '',
        total_depense: snapshot.data().toString().contains('total_depense') ? snapshot.get('total_depense'): '',

    );
  }
  //méthode utilitaire : transforme une collection firestore en ma liste des objets AppUserData
  List<Car> carListFromSnapshot(QuerySnapshot snapshot){
      //return snapshot.docs.map((e) => return userFromSnapshot(e.data()););
      List<Car> list = [];
      snapshot.docs.forEach((element) {
        list.add(carFromSnapshot(element));

      });

       return list;

  }

  //permet de recuperer une voiture dans firestore
  Stream<Car> get car{

   return carCollection.doc(uid).snapshots().map(carFromSnapshot1);

  }

  //permet de recuperer toutes les voitures dans firestore
  Stream<List<Car>> get cars{

    return carCollection.snapshots().map(carListFromSnapshot);
  }


  //les méthodes CRUD

  //1: insert
   Future<void> saveCar(String name, String marque, double tarifVersement,double total_versement,double total_depense) async{
    return await carCollection.doc().set({
        'name':name,
        'marque':marque,
        'tarif_versement':tarifVersement,
        'total_versement':total_versement,
        'total_depense':total_depense
    });
  }

  Future<void> updateCar(String id, String name, String marque, double tarifVersement,double total_versement,double total_depense) async{
    return await carCollection.doc(id).set({
      'name':name,
      'marque':marque,
      'tarif_versement':tarifVersement,
      'total_versement':total_versement,
      'total_depense':total_depense
    });
  }


}
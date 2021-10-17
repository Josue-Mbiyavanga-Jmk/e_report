
//meme classe pour Versement et Dépense
class CarVersement {
  final String id;
  final String car_id;
  final DateTime date;
  final double montant; //ce qui est entré
  final double versement; //ce qui devrait entré
  final String observation;

//constructeur
  CarVersement({
    required this.id,
    required this.car_id,
    required this.date,
    required this.montant,
    required this.versement,
    required this.observation,
  });

}

class CarDepense {
  final String id;
  final String car_id;
  final DateTime date;
  final double montant; //ce qui est entré
  final String observation;

//constructeur
  CarDepense({
    required this.id,
    required this.car_id,
    required this.date,
    required this.montant,
    required this.observation,
  });

}
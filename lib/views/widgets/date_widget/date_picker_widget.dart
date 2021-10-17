
import 'package:flutter/material.dart';

import 'button_header_widget.dart';

typedef void DateTimeCallback(DateTime? date);

class DatePickerWidget extends StatefulWidget {

  late DateTimeCallback callback;
   DatePickerWidget({Key? key, required this.callback}) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  //
  DateTime? myDate;
  //
  late DateTimeCallback onRealDateChanged;

  @override
  void initState() {
    super.initState();

    onRealDateChanged = widget.callback;
    //onRealDateChanged(myDate);*///here var is call and set to
  }

  @override
  Widget build(BuildContext context) => MyButtonHeaderWidget(
      title: 'Date',
      text: getTextOfDate(),
      onClicked: ()=> pickDate(context), //on appelle une méthode à voir en bas
  );

  //méthode pour obtenir une date au calendrier
  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now(); //date initial dans le calendrier
    final newDate = await showDatePicker(
        context: context,
        initialDate: myDate ?? initialDate, //ici on met dans le calendrier une date par defaut ssi on n'a pas encore selectionné
        firstDate: DateTime(DateTime.now().year - 50), //5ans avant pour date minimal
        lastDate: DateTime(DateTime.now().year + 50), //5ans après pour date max
    );
    /* si on appuie sur annuler (cancel) sans prendre de date,
       on aura null comme valeur de la date
     */
    if(newDate == null) return;
    //si on a bien selectionné une date, garder ça dans une variable
    setState(()=> myDate = newDate);
    //appel à la méthode de notification du parent
    onRealDateChanged(myDate);
  }

  //méthode pour afficher cette date au format humain
  String getTextOfDate(){
    if(myDate == null){
      return 'Choisir Date';
    }
    else{
      return '${myDate?.day}/${myDate?.month}/${myDate?.year}';
      //en cas de l'usage de intl : ^0.16.1 dans pubspec dependencies
      //return DateFormat('dd/MM/yyyy').format(myDate);

    }
  }
}

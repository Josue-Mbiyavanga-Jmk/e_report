
import 'package:flutter/material.dart';


class MyButtonHeaderWidget extends StatelessWidget {

  final String title;
  final String text;
  final VoidCallback onClicked;

  const MyButtonHeaderWidget({
    Key? key,
    required this.title,
    required this.text,
    required this.onClicked,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyButtonWidget(
        text: text,
        onClicked:onClicked
    );
    /*return MyHearderWidget(
      title:title,
      child:MyButtonWidget(
          text: text,
          onClicked:onClicked
      ),

    );*/
  }

}

class MyButtonWidget extends StatelessWidget{
  final String text;
  final VoidCallback onClicked;

  const MyButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(40),
        primary: Colors.white,

      ),
      //child:FittedBox(
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            text,
            style: TextStyle(fontSize: 17, color: Colors.grey[600]),
          ),
        ),

      onPressed: onClicked,

    );
  }
}

class MyHearderWidget extends StatelessWidget{
  final String title;
  final Widget child;

  const MyHearderWidget({
    Key? key,
    required this.title,
    required this.child,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        SizedBox(height: 5,),
        child
      ],
    );
  }
}

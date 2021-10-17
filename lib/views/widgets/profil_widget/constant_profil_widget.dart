import 'package:flutter/material.dart';

Widget buildEditIcon(Color color) => buildCircle(
  color: Colors.white,
  all: 3,
  child: buildCircle(
    color: color,
    all: 8,
    child: Icon(
      //isEdit ? Icons.add_a_photo : Icons.edit,
      Icons.add_a_photo,
      color: Colors.white,
      size: 20,
    ),
  ),
);

Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
}) =>
    ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );

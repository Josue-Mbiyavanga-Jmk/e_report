import 'package:flutter/material.dart';


class ButtonWidget extends StatelessWidget {
  final String title;
  final bool hasBorder;
  final VoidCallback onTap;
  //final Function() onTap;

  ButtonWidget({
    required this.title,
    required this.hasBorder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: hasBorder ? Colors.white : Colors.blueGrey,
          borderRadius: BorderRadius.circular(10),
          border: hasBorder
              ? Border.all(
                  color: Colors.blueGrey,
                  width: 1.0,
                )
              : Border.fromBorderSide(BorderSide.none),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 60.0,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: hasBorder ? Colors.blueGrey : Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

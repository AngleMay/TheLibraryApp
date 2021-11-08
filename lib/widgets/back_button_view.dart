import 'package:flutter/material.dart';

class LeftButtonSession extends StatelessWidget {
  final Color buttonColor;
  final Function onTab;
  LeftButtonSession(this.buttonColor, this.onTab());
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () {
            this.onTab();
          },
          child: Icon(
            Icons.arrow_back,
            color: this.buttonColor,
            //size: 35.0,
          ),
        ),
      ),
    );
  }
}
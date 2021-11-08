import 'package:flutter/material.dart';
import 'package:the_library/resources/dimens.dart';

class SampleTextSession extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 35.0,
      padding: EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM,
        vertical: MARGIN_MEDIUM,
      ),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        "Sample",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../partials/sizeconfig.dart';

showNoResultError(BuildContext context){
  String content = "User not found.";
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          content,
          style: TextStyle(
            fontSize: 2 * SizeConfig.textMultiplier,
            fontFamily: "Montserrat"
          )
        ),
        actions: [
          FlatButton(
            child: Text(
              'OKAY',
              style: TextStyle(
                color: Colors.red,
                fontFamily: "Montserrat"
              )
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ]
      );
    }
  );
}
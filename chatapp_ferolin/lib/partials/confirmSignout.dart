import 'package:chatapp_ferolin/partials/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../partials/sizeconfig.dart';
import '../services/authentication.dart';


confirmSignout(BuildContext context){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Sign Out?',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "Montserrat"
          )
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: TextStyle(
            fontSize: 2 * SizeConfig.textMultiplier,
            fontFamily: "Montserrat"
          )
        ),
        actions: [
          FlatButton(
            child: Text(
              'No',
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Montserrat"
              )
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(
              'YES',
              style: TextStyle(
                color: Colors.red,
                fontFamily: "Montserrat"
              )
            ),
            onPressed: () {
              //code to actually sign out
              AuthenticationMethods authmethods = new AuthenticationMethods();
              Navigator.of(context).pop();
              authmethods.signOut();
            },
          ),
        ]
      );
    }
  );
}
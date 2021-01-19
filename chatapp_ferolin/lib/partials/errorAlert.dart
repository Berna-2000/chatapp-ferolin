import 'package:chatapp_ferolin/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../partials/sizeconfig.dart';
import '../services/authentication.dart';


showErrorMessage(BuildContext context, String error){
  final AuthenticationMethods authMethods = new AuthenticationMethods();
  String content;
  bool isVerified = false;
  if(error == "missing"){
    content = "Missing Fields.";
  }else if (error == "email"){
    content = "This e-mail address is already in use. Try another one.";
  }else if (error == "account"){
    content = "No account exists for the given e-mail address. Check your inputs.";
  }else{
    content = "E-mail not verified. Sent another verification email.";
  }
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Error',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "Montserrat"
          )
        ),
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
              if(error!="missing" && error!="email" && error!="account"){
                //sends another verification email
                Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context)=> Wrapper(status: isVerified)));
                authMethods.verifyEmail();
              }
              Navigator.of(context).pop();
            },
          )
        ]
      );
    }
  );
}
import 'package:chatapp_ferolin/views/verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../partials/sizeconfig.dart';


showSuccessMessage(BuildContext context, String success){
  String content;
  if(success == "reset"){
    content = "An e-mail to reset your password has been sent to your email address.";
  }else{
    content = "Sign up successful. Verification email sent.";
  }
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Success',
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
              if(success == "reset"){
                Navigator.of(context).pop();
              }else if (success == "verify"){
                Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context)=>VerifyPage()));
              }
            },
          )
        ]
      );
    }
  );
}
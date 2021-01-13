import 'package:chatapp_ferolin/controller/userController.dart';
import 'package:chatapp_ferolin/partials/loadingPage.dart';
import 'package:chatapp_ferolin/services/authentication.dart';
import '../controller/userController.dart';
import 'package:chatapp_ferolin/views/verify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'errorAlert.dart';

submitRegister(context, _formKey, username, emailAddress, password){
  String uid;
  AuthenticationMethods authmethods = new AuthenticationMethods();
  if (_formKey.currentState.validate()) {
    Loading();
    _formKey.currentState.save();
    //Navigate to Home Page
    // print(username);
    // print(emailAddress);
    // print(password);
    try{
      authmethods.signupWithEmailAndPassword(emailAddress, password)
      .then((val){
        print("${val.userId}");
        uid = "${val.userId}";
        UserController().createUser(uid, emailAddress, username);
        return true;
        // Navigator.of(context)
        //   .pushReplacement(MaterialPageRoute(builder: (context) => VerifyPage()));
      });
    }catch(e){
      print(e.toString());
    }

  }else{
    String error = "missing";
    showErrorMessage(context, error);
    return false;
  }
}

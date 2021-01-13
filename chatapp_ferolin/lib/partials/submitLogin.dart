import 'package:chatapp_ferolin/views/mainpage.dart';
import 'errorAlert.dart';
import 'package:flutter/material.dart';
import '../services/authentication.dart';
import '../views/signin.dart';

submitLogin(context, _formKey, emailAddress, password) async {
  if (_formKey.currentState.validate()) {
    _formKey.currentState.save();

    final AuthenticationMethods _auth = AuthenticationMethods();
    //Calls on the email authentication
    await _auth.signinWithEmailandPassword(emailAddress, password);
    
    //Navigate to Home Page
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => MainPage()),
    // );
  }else{
    String error = "missing";
    showErrorMessage(context, error);
  }
}

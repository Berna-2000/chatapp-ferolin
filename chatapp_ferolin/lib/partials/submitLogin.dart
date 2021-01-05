import 'package:chatapp_ferolin/views/mainpage.dart';
import 'errorAlert.dart';
import 'package:flutter/material.dart';

submitLogin(context, _formKey){
  if (_formKey.currentState.validate()) {
    _formKey.currentState.save();
    //Navigate to Home Page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
  }else{
    String error = "missing";
    showErrorMessage(context, error);
  }
}

import 'package:chatapp_ferolin/partials/loadingPage.dart';
import 'package:chatapp_ferolin/partials/sizeconfig.dart';
import 'package:chatapp_ferolin/services/authentication.dart';
import 'package:flutter/material.dart';
import '../common/packages.dart';
import '../partials/errorAlert.dart';
import '../partials/successAlert.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String emailAddress;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget _buildEmailRow(){
    return SizedBox(
      height: 70,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (input) => EmailValidator.validate(input)
            ? null
            : "Invalid E-mail Address",
        onSaved: (input) => emailAddress = input,
        onChanged: (value){
          setState(() {
            emailAddress = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Colors.blue[400],
          ),
          labelText: 'E-mail Address',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue[400]),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15.0),
          )
        ),
      )
    );
  }

  Widget _buildForgotPassword(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container (
          height: 6 * SizeConfig.heightMultiplier,
          width: 0.85 * MediaQuery.of(context).size.width,
          child: RaisedButton(
            onPressed: () async {
              //sends the reset password email
              AuthenticationMethods authMethods = new AuthenticationMethods();
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                authMethods.resetPassword(emailAddress);
                setState(() {
                  isLoading = true;
                });
                String success = "reset";
                showSuccessMessage(context, success);
                Navigator.of(context).pop();
              }else{
                String error = "missing";
                showErrorMessage(context, error);
              }
            },
            elevation: 5.0,
            color: Color(0xfff1976d2), 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              "Send Reset Password Email",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.0,
                fontSize: 2 * SizeConfig.textMultiplier,
              )
            ),
          )
        )
      ],
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff1976d2), 
        title: Text("ChatLoop Reset Password"),
      ),
      body: isLoading ? Loading() : 
      Container(
        padding: EdgeInsets.all(20.0),
        height: SizeConfig.screenHeight,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildEmailRow(),
              SizedBox(height: 15.0),
              _buildForgotPassword()
            ],
          ),
        )
      ),
    );
  }
}
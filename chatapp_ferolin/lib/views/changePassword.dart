import 'package:chatapp_ferolin/partials/sizeconfig.dart';
import 'package:chatapp_ferolin/partials/submitChangePassword.dart';
import 'package:flutter/material.dart';
import '../common/packages.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String emailAddress, newPassword, confirmPassword;
  bool _isHidden = true;
  IconData iconP = Icons.remove_red_eye_sharp;
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

  Widget _buildPasswordRow(){
    return SizedBox(
      height: 65,
      child: TextFormField(
        keyboardType: TextInputType.text,
        validator: (input){
          if(input.length < 1 ){
            return "This field is required";
          }else if (input.length >=1 && input.length < 6){
            return "Password too short";
          }else{
            return null;
          }
        },
        onSaved: (input) => newPassword = input,
        onChanged: (value){
          setState(() {
            newPassword = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.blue[400],
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isHidden = !_isHidden;
                if(iconP == Icons.visibility_off){
                  iconP = Icons.remove_red_eye_sharp;
                }else{
                  iconP = Icons.visibility_off;
                }
              });
            },
            icon: Icon(iconP),
          ),
          labelText: 'Password',
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
        obscureText: _isHidden,
      )
    );
  }

  Widget _buildConfirmPasswordRow(){
    return SizedBox(
      height: 65,
      child: TextFormField(
        keyboardType: TextInputType.text,
        validator: (input){
          if(input.length < 1 ){
            return "This field is required";
          }else if (input != newPassword){
            return "Passwords do not match!";
          }else{
            return null;
          }
        },
        onSaved: (input) => confirmPassword = input,
        onChanged: (value){
          setState(() {
            confirmPassword = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.blue[400],
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isHidden = !_isHidden;
                if(iconP == Icons.visibility_off){
                  iconP = Icons.remove_red_eye_sharp;
                }else{
                  iconP = Icons.visibility_off;
                }
              });
            },
            icon: Icon(iconP),
          ),
          labelText: 'Confirm Password',
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
        obscureText: _isHidden,
      )
    );
  }

  Widget _buildChangePassword(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container (
          height: 6 * SizeConfig.heightMultiplier,
          width: 0.85 * MediaQuery.of(context).size.width,
          child: RaisedButton(
            onPressed: () {
              submitChangePassword(context, _formKey);
            },
            elevation: 5.0,
            color: Color(0xfff1976d2), 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              "Change Password",
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
      body: Container(
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
              _buildPasswordRow(),
              SizedBox(height: 15.0),
              _buildConfirmPasswordRow(),
              SizedBox(height: 15.0),
              _buildChangePassword(),
            ],
          ),
        )
      ),
    );
  }
}
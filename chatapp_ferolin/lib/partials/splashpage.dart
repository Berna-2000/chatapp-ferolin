import 'dart:async';
import 'package:chatapp_ferolin/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../partials/sizeconfig.dart';
import '../services/authentication.dart';
import '../common/packages.dart';

class Splash extends StatefulWidget {
  @override
  _Splash createState() => new _Splash();
}

class _Splash extends State<Splash> {

  dynamic isVerified;
  String currentUser="";

  @override
  void initState() {
    Timer(Duration(seconds: 5), (){
      isVerified = checkOnSignin();
      print(currentUser);
      // currentUser = checkUserState();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=> Wrapper(status: isVerified)));
    });
    super.initState();
  }

  initializeSharedPreferenceInstance() async{
    SharedPreferences usernamePreference = await SharedPreferences.getInstance();
    setState(() {
      currentUser = usernamePreference.getString('currentUser');
    });
  }

  @override
  Widget build(BuildContext context) {
    final logoSize = 50 * SizeConfig.imageSizeMultiplier;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
              child: Image(
                image: AssetImage('assets/images/chatapplogo.png'),
                height: logoSize,
              ),
          ),
          SizedBox(height: SizeConfig.heightMultiplier),
          SpinKitChasingDots(color: Colors.tealAccent[200]),
        ],
      )
    );
  }
  Future checkOnSignin() async {
    AuthenticationMethods authMethods = new AuthenticationMethods();
    dynamic isVerified = await authMethods.checkVerfiedEmail();
    return isVerified;
  }
  Future checkUserState() async {
    AuthenticationMethods authMethods = new AuthenticationMethods();
    dynamic currentUser = await authMethods.getCurrentUser();
    return currentUser;
  }
}
import 'dart:async';
import 'package:chatapp_ferolin/views/signin.dart';
import 'package:chatapp_ferolin/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../partials/sizeconfig.dart';

class Splash extends StatefulWidget {
  @override
  _Splash createState() => new _Splash();
}

class _Splash extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), ()=> Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(seconds: 3),
              transitionsBuilder: (BuildContext context, Animation<double> animation, 
                                    Animation<double> secAnimation, Widget child){
                animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
                return ScaleTransition(
                  alignment: Alignment.center,
                  scale: animation,
                  child: child,
                );
              },
              pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation){
                return Wrapper();
              }
            ),
          )
        );
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
          SpinKitPulse(color: Colors.tealAccent[200]),
        ],
      )
    );
  }
}
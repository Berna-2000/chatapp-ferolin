import 'dart:async';
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
    Timer(Duration(seconds: 5), ()=> Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context)=> Wrapper())
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
          SpinKitChasingDots(color: Colors.tealAccent[200]),
        ],
      )
    );
  }
}
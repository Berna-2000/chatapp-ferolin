import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../partials/sizeconfig.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.65,
      color: Colors.white,
      child: Center(
        child: SpinKitChasingDots(color: Colors.tealAccent[200]),
      ),
    );
  }
}

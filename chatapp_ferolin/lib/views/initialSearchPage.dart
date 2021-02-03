import 'package:chatapp_ferolin/partials/sizeconfig.dart';
import 'package:flutter/material.dart';

class InitialSearchPage extends StatefulWidget {
  @override
  _InitialSearchPageState createState() => _InitialSearchPageState();
}

class _InitialSearchPageState extends State<InitialSearchPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.55,
      child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              width: 50 * SizeConfig.imageSizeMultiplier,
              image: AssetImage('assets/images/search.png'),
            ),
            Text(
              "Start finding your contacts."
            )
          ] 
        )
      ),
    );
  }
}
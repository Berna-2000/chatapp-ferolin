import 'package:chatapp_ferolin/partials/splashpage.dart';
import 'package:chatapp_ferolin/services/authentication.dart';
import 'package:chatapp_ferolin/views/mainpage.dart';
import 'package:chatapp_ferolin/views/profiles.dart';
import 'package:flutter/material.dart';
import 'views/signin.dart';
import 'views/register.dart';
import 'partials/sizeconfig.dart';
import 'partials/loadingPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'common/packages.dart';
// import 'partials/splashpage.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        return OrientationBuilder(
          builder: (context, orientation){
            SizeConfig().init(constraints, orientation);
              return MaterialApp(
                initialRoute: '/',
                debugShowCheckedModeBanner: false,
                routes: {
                  // '/': (context) => Splash(),
                  // '/login': (context) => LoginPage(),
                  // '/register': (context) => SignupPage(),
                  '/' : (context) => Splash(),
                },
                // home: Splash(),
              );
            }
        );
      }
    );
  }
}

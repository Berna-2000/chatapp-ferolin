import 'package:chatapp_ferolin/models/user.dart';
import 'package:chatapp_ferolin/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'services/authentication.dart';
import 'partials/sizeconfig.dart';
import 'partials/splashpage.dart';
import 'views/register.dart';
import 'views/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initializes Firebase app
  await Firebase.initializeApp();
  runApp(StreamProvider<UserClass>.value(
    value: AuthenticationMethods().user,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
      // initialRoute: '/',
      // onGenerateRoute: RouteGenerator.generateRoute,
    ),
  ));
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
                '/': (context) => Splash(),
                '/login': (context) => LoginPage(),
                '/register': (context) => SignupPage(),
              },
            );
          }
        );
      }
    );
  }
}


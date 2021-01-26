import 'package:chatapp_ferolin/views/mainpage.dart';
import 'views/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'common/packages.dart';

class Wrapper extends StatelessWidget {
  final status;
  Wrapper({this.status});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // return authentication screen or home screen
    if (user == null) {
      return Authenticate();
    } else {  
      if(status == true){
        return MainPage();
      }else{
        return Authenticate();
      }
    }
  }
}

// class Wrapper extends StatefulWidget {
//   final status;
//   Wrapper({this.status});
//   @override
//   _WrapperState createState() => _WrapperState();
// }

// class _WrapperState extends State<Wrapper> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: FutureBuilder(
//         future: AuthenticationMethods().getCurrentUser(),
//         builder: (context, AsyncSnapshot<dynamic> snapshot){
//           dynamic hey = AuthenticationMethods().getCurrentUser()
//           if(snapshot.hasData){
//             print("PREVIOUS");
//             if(widget.status == true){
//               return MainPage();
//             }else{
//               return Authenticate();
//             }
//           }else{
//             print("NNNGGHH");
//             return Authenticate();
//           }
//         }
//       )
//     );
//   }
// }
import 'package:chatapp_ferolin/models/user.dart';
import 'package:chatapp_ferolin/views/mainpage.dart';
import 'views/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'common/packages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass>(context);
    // return authentication screen or home screen
    if (user == null) {
      return Authenticate();
    } else {
      return MainPage();
    }
  }
}
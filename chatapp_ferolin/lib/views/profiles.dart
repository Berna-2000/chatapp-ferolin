import 'package:flutter/material.dart';
import '../common/packages.dart';
import '../partials/sizeconfig.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Widget _buildProfilePhoto(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Container(
            height: SizeConfig.screenHeight,
            child: Image(image: AssetImage('assets/images/chatapplogo.png'),),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfilePhoto()
            ],
          ),
        ),
      ),
    );
  }
}
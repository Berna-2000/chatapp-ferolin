import 'package:flutter/material.dart';
import '../partials/sizeconfig.dart';
import '../views/search.dart';
import '../common/packages.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  bool isEmpty = true;

  Widget _buildEmptyContacts(){
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Text(
          "You have no contacts as of the moment.",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 3 * SizeConfig.textMultiplier,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search_outlined),
          onPressed: () {
            Navigator.of(context)
              .push(MaterialPageRoute(builder: (context)=>SearchPage()));
          },
        ),
        body: isEmpty ? _buildEmptyContacts() : Container(color: Colors.amber,),
      ),
    );
  }
}
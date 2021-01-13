import 'package:flutter/material.dart';
import '../partials/sizeconfig.dart';
import '../common/packages.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  
  String searchEmail;
  bool isFocused = false;

  Widget _buildSearchBar(){
    return Row(
      children: [
        Form(
          child: Expanded(
            child: TextFormField(
              textInputAction: TextInputAction.search,
              onSaved: (input) => searchEmail = input,
              onChanged: (value){
                setState(() {
                  isFocused = !isFocused;
                  searchEmail = value;
                });
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      //TODO: search bar function
                    });
                  },
                  icon: !isFocused ? Icon(Icons.search_rounded): Icon(Icons.cancel),
                ),
                hintText: 'Search user email',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[400]),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
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
          child: Container(
            padding: EdgeInsets.all(20.0),
            height: SizeConfig.screenHeight*0.85,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSearchBar(),
              ],
            )
          ),
        ),
      ),
    );
  }
}
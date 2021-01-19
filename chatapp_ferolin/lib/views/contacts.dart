import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../partials/sizeconfig.dart';
import '../common/packages.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  
  String searchEmail;
  bool isEmpty = true;
  final searchHolder = TextEditingController();

  Widget _buildSearchBar(){
    return Row(
      children: [
        Form(
          child: Expanded(
            child: TextFormField(
              controller: searchHolder,
              textInputAction: TextInputAction.search,
              onSaved: (input) => searchEmail = input,
              onChanged: (value){
                if(value.isNotEmpty){
                  isEmpty = false;
                  print("The field is no longer Empty");
                }else{
                  isEmpty = true;
                  print("It became empty again");
                }
                setState(() {
                  searchEmail = value;
                });
              },
              onFieldSubmitted: (input) {
                //TODO: some code to search for the user here
              },
              decoration: InputDecoration(
                suffixIcon: isEmpty ? Icon(Icons.search_outlined) : 
                IconButton(
                  onPressed: () {
                    setState(() {
                      //Clears the search bar on click
                      searchHolder.clear();
                      isEmpty = true;
                    });
                  },
                  icon: Icon(Icons.cancel),
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

  _buildEmptyListContact(){
    return Container(
      height: SizeConfig.screenHeight * 0.8,
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Text(
          "You have no contacts as of the moment.",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 3 * SizeConfig.textMultiplier,
          ),
          textAlign: TextAlign.center,
        )
      )
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
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSearchBar(),
                _buildEmptyListContact(),
              ],
            )
          ),
        ),
      ),
    );
  }
}
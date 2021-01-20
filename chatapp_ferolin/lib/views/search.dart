import 'package:chatapp_ferolin/controller/userController.dart';
import 'package:chatapp_ferolin/models/appUsers.dart';
import 'package:chatapp_ferolin/partials/usersList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../partials/sizeconfig.dart';
import '../common/packages.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  String searchEmail = "";
  bool isEmpty = true;
  bool isEntered = false;
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
                }else{
                  isEmpty = true;
                }
                setState(() {
                  searchEmail = value;
                });
              },
              onFieldSubmitted: (input) {
                //TODO: some code to search for the user here
                setState(() {
                  isEntered = true;
                });
                searchEmail = input;
              },
              decoration: InputDecoration(
                suffixIcon: isEmpty ? Icon(Icons.search_outlined) : 
                IconButton(
                  onPressed: () {
                    setState(() {
                      //Clears the search bar on click
                      isEmpty = true;
                      isEntered = false;
                      searchHolder.clear();
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

  Widget _buildSearchResults(){
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: UsersList(emailAddress: searchEmail),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xfff1976d2), 
          title: Text("Search Users"),
        ),
        body: StreamProvider<List<AppUser>>.value(
          value: UserController().retrieveAllUsers,
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSearchBar(),
                isEntered ? _buildSearchResults() : Container(color: Colors.amber, child: Text("FONKY MONKY FRIDAY")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
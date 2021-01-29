import 'package:chatapp_ferolin/controller/userController.dart';
import 'package:chatapp_ferolin/models/appUsers.dart';
import 'package:chatapp_ferolin/partials/usersList.dart';
import 'package:chatapp_ferolin/views/initialSearchPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              keyboardType: TextInputType.emailAddress,
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
                //changes the view to retrieve results of the query
                if(input.isNotEmpty){
                  setState(() {
                    isEntered = true;
                  });
                  searchEmail = input;
                }
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
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[400]),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Search user email',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[400]),
                  borderRadius: BorderRadius.circular(100.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(100.0),
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
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSearchBar(),
                    isEntered ? _buildSearchResults() : InitialSearchPage(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
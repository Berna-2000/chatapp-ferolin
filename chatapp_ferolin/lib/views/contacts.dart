import 'package:chatapp_ferolin/controller/chatroomController.dart';
import 'package:chatapp_ferolin/controller/userController.dart';
import 'package:chatapp_ferolin/partials/usersList.dart';
import 'package:chatapp_ferolin/services/authentication.dart';
import 'package:chatapp_ferolin/views/noChatroomsPage.dart';
import 'package:flutter/material.dart';
import '../partials/sizeconfig.dart';
import '../common/packages.dart';
import '../models/appUsers.dart';
import '../partials/chatroomList.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Stream streamChatrooms, streamSearchedUsers;
  String chatroomId;
  User user;
  String currentUser;
  String searchEmail = "";
  bool isEmpty = true;
  bool isEntered = false;
  final searchHolder = TextEditingController();

  getChatroomList() async {
    user = await AuthenticationMethods().getCurrentUser();
    currentUser = user.displayName;
    streamChatrooms = await ChatroomController().retrieveChatrooms();
    setState(() {});
  }

  @override
  void initState(){
    getChatroomList();
    super.initState();
  }

  Widget _buildSearchBar(){
    return Row(
      children: [
        isEntered ? Padding(
          padding: EdgeInsets.only(right: 5.0),
          child: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: (){
              //some code to go back to the list of contacts
              setState(() {
                searchHolder.clear();
                isEntered = false;
              });
            },
          )
        ) : Container(),
        Expanded(
          child: TextFormField(
            controller: searchHolder,
            textInputAction: TextInputAction.search,
            keyboardType: TextInputType.emailAddress,
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
            onFieldSubmitted: (input) async {
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
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(100.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(100.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(100.0),
              ),
              hintText: 'Search user e-mail'
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChatroomsListRow(){
    return StreamBuilder(
      stream: streamChatrooms,
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return NoChatroomsPage();
        }
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          shrinkWrap: true,
          itemBuilder: (context, index){
            DocumentSnapshot chatroomSnapshot = snapshot.data.docs[index];
            String chattedUser = chatroomSnapshot.id.replaceAll(currentUser, "").replaceAll("_", "");
            String emailAddress = user.email;
            String lastMessage = chatroomSnapshot['lastMessage'];
            return ChatroomList(
                emailAddress: emailAddress, 
                lastMessage: lastMessage, 
                chattedUser: chattedUser,
                currentUser: user,);
          },
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: StreamProvider<List<AppUser>>.value(
          value: UserController().retrieveAllUsers,
            child: Container(
            height: SizeConfig.screenHeight,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical:20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildSearchBar(),
                  Container(
                    child: isEntered ? UsersList(emailAddress: searchEmail) : _buildChatroomsListRow(), 
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
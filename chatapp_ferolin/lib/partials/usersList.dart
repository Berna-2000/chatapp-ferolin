import 'package:chatapp_ferolin/partials/errorAlert.dart';
import 'package:chatapp_ferolin/partials/loadingPage.dart';
import 'package:chatapp_ferolin/partials/sizeconfig.dart';
import 'package:chatapp_ferolin/views/noResultPage.dart';
import 'package:flutter/material.dart';
import '../common/packages.dart';
import '../models/appUsers.dart';

class UsersList extends StatefulWidget {
  final emailAddress;
  UsersList({this.emailAddress});
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final userSnapshot = Provider.of<List<AppUser>>(context) ?? [];
    final userDisplay = userSnapshot.where((element) => element.emailAddress == widget.emailAddress)
                          .toList();
    return userDisplay.length == 0 ? NoResultsPage() : 
    ListView.builder(
      shrinkWrap: true,
      itemCount: userDisplay.length,
      itemBuilder: (context, index){
        return GestureDetector(
          onTap: () {
            if(user.email == userDisplay[index].emailAddress){
              String error = "self";
              showErrorMessage(context, error);
            }else{
              //TODO: 
              //1. Check if user is already in contact... 
              //2. if yes, then don't add. 
              //3. Otherwise, add.
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Color(0xfff85b5e6)
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userDisplay[index].username,
                      style: TextStyle(
                        fontSize: 2.75 * SizeConfig.textMultiplier, 
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      userDisplay[index].emailAddress,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
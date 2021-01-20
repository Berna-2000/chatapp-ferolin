import 'package:chatapp_ferolin/partials/sizeconfig.dart';
import 'package:flutter/material.dart';
import '../common/packages.dart';
import '../models/appUsers.dart';
import '../common/packages.dart';

class UsersList extends StatefulWidget {
  final emailAddress;
  UsersList({this.emailAddress});
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    final userSnapshot = Provider.of<List<AppUser>>(context) ?? [];
    final userDisplay = userSnapshot.where((element) => element.emailAddress == widget.emailAddress)
                          .toList();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: userDisplay.length,
      itemBuilder: (context, index){
        return Container(
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
              // Spacer(),
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.blue,
              //     borderRadius: BorderRadius.circular(50.0),
              //   ),
              //   padding: EdgeInsets.symmetric(horizontal: 10.0),
              //   child: Icon(Icons.add),
              // )
            ],
          ),
        );
      }
    );
  }
}
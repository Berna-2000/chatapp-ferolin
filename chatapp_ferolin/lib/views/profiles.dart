import 'package:chatapp_ferolin/common/packages.dart';
import 'package:chatapp_ferolin/partials/loadingPage.dart';
import 'package:chatapp_ferolin/services/authentication.dart';
import 'package:chatapp_ferolin/wrapper.dart';
import 'package:flutter/material.dart';
import '../partials/sizeconfig.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthenticationMethods authMethods = new AuthenticationMethods();
  String name = "Default User", 
         emailAddress = "defaultuser@email.com", 
         displayPhoto = "";
  bool isLoading = false;

  Widget _buildProfilePhoto(displayPhoto){
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 7.0, color: Color(0xfff1976d2)),
          left: BorderSide(width: 7.0, color: Color(0xfff1976d2)),
          right: BorderSide(width: 7.0, color: Color(0xfff1976d2)),
          bottom: BorderSide(width: 7.0, color: Color(0xfff1976d2)),
        ),
        borderRadius: BorderRadius.all(Radius.circular(110.0))
      ),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 7.0, color: Color(0xfff60affe)),
            left: BorderSide(width: 7.0, color: Color(0xfff60affe)),
            right: BorderSide(width: 7.0, color: Color(0xfff60affe)),
            bottom: BorderSide(width: 7.0, color: Color(0xfff60affe)),
          ),
          borderRadius: BorderRadius.all(Radius.circular(100.0))
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: Image.asset(
            displayPhoto,
            width: 50 * SizeConfig.imageSizeMultiplier,
          ),
        )
      ),
    );
  }

  Widget _buildName(String name){
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Text(
        name,
        style: TextStyle(
          color: Color(0xfffa0a0a0),
          fontWeight: FontWeight.w900,
          fontSize: 4 * SizeConfig.textMultiplier,
        )
      ),
    );
  }

  Widget _buildEmailAddress(String emailAddress){
    return Container(
      child: Text(
        emailAddress,
        style: TextStyle(
          color: Color(0xfffa0a0a0),
          fontWeight: FontWeight.bold,
          fontSize: 2.5 * SizeConfig.textMultiplier,
        )
      ),
    );
  }

  Widget _buildSignout(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container (
          margin: EdgeInsets.symmetric(vertical:15.0),
          height: 6 * SizeConfig.heightMultiplier,
          width: 0.85 * MediaQuery.of(context).size.width,
          child: RaisedButton(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              //some code to sign out 
              final AuthenticationMethods authmethods = new AuthenticationMethods();
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Sign Out?',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Montserrat"
                      )
                    ),
                    content: Text(
                      'Are you sure you want to sign out?',
                      style: TextStyle(
                        fontSize: 2 * SizeConfig.textMultiplier,
                        fontFamily: "Montserrat"
                      )
                    ),
                    actions: [
                      FlatButton(
                        child: Text(
                          'No',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Montserrat"
                          )
                        ),
                        onPressed: () {
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text(
                          'YES',
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: "Montserrat"
                          )
                        ),
                        onPressed: () async {
                          //code to actually sign out
                          await authmethods.signOut();
                          SharedPreferences usernamePreferences = await SharedPreferences.getInstance();
                          usernamePreferences.clear();
                          Navigator.of(context).pop();
                          // Navigator.of(context)
                          //   .pushReplacement(MaterialPageRoute(builder: (context)=> Wrapper(status: false)));
                        },
                      ),
                    ]
                  );
                }
              );
            },
            elevation: 5.0,
            color: Color(0xffff1f1f1), 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              "Sign out",
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 1.0,
                fontSize: 2 * SizeConfig.textMultiplier,
              )
            ),
          )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    name = user.displayName;
    displayPhoto = user.photoURL;
    emailAddress = user.email;
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading ? Loading() : 
      SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            height: SizeConfig.screenHeight*0.85,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfilePhoto(displayPhoto),
                _buildName(name),
                _buildEmailAddress(emailAddress),
                _buildSignout(),
              ],
            )
          ),
        ),
      ),
    );
  }
}
import 'package:chatapp_ferolin/partials/loadingPage.dart';
import 'package:chatapp_ferolin/partials/successAlert.dart';
import 'package:chatapp_ferolin/wrapper.dart';
import 'package:flutter/material.dart';
import '../common/packages.dart';
import '../partials/sizeconfig.dart';
import '../services/authentication.dart';
import '../partials/errorAlert.dart';
import '../controller/userController.dart';

class SignupPage extends StatefulWidget {
  final Function toggleView;
  SignupPage({this.toggleView});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String username, emailAddress, password, confirmPassword;
  bool _isHidden = true, isLoading = false;
  IconData iconP = Icons.remove_red_eye_sharp;
  User user;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final TextEditingController _passwordController = TextEditingController();

  // @override
  // void dispose(){
  //   _passwordController.dispose();
  //   super.dispose();
  // }

  changeState(state){
    setState(() {
      isLoading = state;
    });
  }

  Widget _buildHeaderWelcome(BuildContext context){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '- Register Now! -',
            style: TextStyle(
              fontSize: 2.5 * SizeConfig.textMultiplier,
              fontWeight: FontWeight.w400, 
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUsernameRow(){
    return SizedBox(
      height: 65,
      child: TextFormField(
        keyboardType: TextInputType.name,
        validator: (input){
          if(input.isEmpty){
            return "This field is required";
          }else if (input.isNotEmpty && input.length < 6){
            return "Username should be 6-20 characters long";
          }else if(input.length >20){
            return "Username should be at most 20 characters long";
          }else{
            return null;
          }
        },
        onSaved: (input) => username = input,
        onChanged: (value){
          setState(() {
            username = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            color: Colors.blue[400],
          ),
          labelText: 'Username',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue[400]),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15.0),
          )
        ),
      )
    );
  }

  Widget _buildEmailRow(){
    return SizedBox(
      height: 65,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (input) => EmailValidator.validate(input)
            ? null
            : "Invalid E-mail Address",
        onSaved: (input) => emailAddress = input,
        onChanged: (value){
          setState(() {
            emailAddress = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Colors.blue[400],
          ),
          labelText: 'E-mail Address',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue[400]),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15.0),
          )
        ),
      )
    );
  }

  Widget _buildPasswordRow(){
    return SizedBox(
      height: 65,
      child: TextFormField(
        keyboardType: TextInputType.text,
        validator: (input){
          if(input.length < 1 ){
            return "This field is required";
          }else if (input.length >=1 && input.length < 6){
            return "Password too short";
          }else{
            return null;
          }
        },
        onSaved: (input) => password = input,
        onChanged: (value){
          setState(() {
            password = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.blue[400],
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isHidden = !_isHidden;
                if(iconP == Icons.visibility_off){
                  iconP = Icons.remove_red_eye_sharp;
                }else{
                  iconP = Icons.visibility_off;
                }
              });
            },
            icon: Icon(iconP),
          ),
          labelText: 'Password',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue[400]),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15.0),
          )
        ),
        obscureText: _isHidden,
      )
    );
  }

  Widget _buildConfirmPasswordRow(){
    return SizedBox(
      height: 65,
      child: TextFormField(
        keyboardType: TextInputType.text,
        validator: (input){
          if(input.length < 1 ){
            return "This field is required";
          }else if (input != password){
            return "Passwords do not match!";
          }else{
            return null;
          }
        },
        onSaved: (input) => confirmPassword = input,
        onChanged: (value){
          setState(() {
            confirmPassword = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.blue[400],
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isHidden = !_isHidden;
                if(iconP == Icons.visibility_off){
                  iconP = Icons.remove_red_eye_sharp;
                }else{
                  iconP = Icons.visibility_off;
                }
              });
            },
            icon: Icon(iconP),
          ),
          labelText: 'Confirm Password',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue[400]),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15.0),
          )
        ),
        obscureText: _isHidden,
      )
    );
  }

  Widget _buildSignupRow(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container (
          height: 6 * SizeConfig.heightMultiplier,
          width: 0.85 * MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: 0.0),
          child: RaisedButton(
            onPressed: () async {
              //submit registration
              String uid;
              String photo = "https://img.lovepik.com/element/45001/6381.png_860.png";
              AuthenticationMethods authmethods = new AuthenticationMethods();
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                changeState(true);
                //Navigate to Home Page
                try{
                  dynamic result = await authmethods.signupWithEmailAndPassword(emailAddress, password);
                  if (result == null){
                    changeState(false);
                    String error = "email";
                    showErrorMessage(context, error);
                  }else{
                    uid = "${result.uid}";
                    await authmethods.updateProfile(username, photo);
                    UserController().createUser(uid, emailAddress, username, photo);
                    String success = "verify";
                    showSuccessMessage(context, success);
                  }
                }catch(e){
                  print(e.toString());
                }
              }else{
                String error = "missing";
                showErrorMessage(context, error);
              }
            },
            elevation: 5.0,
            color: Color(0xfff1976d2), 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              "SIGN UP",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.0,
                fontSize: 2 * SizeConfig.textMultiplier,
              )
            ),
          )
        )
      ],
    );
  }

  Widget _buildSigninRow(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account? ",
            style: TextStyle(
              fontFamily: "Montserrat",
            ),
          ),
          InkWell(
            onTap: () {
              //some code to go to the sign in page
              widget.toggleView();
            },
            child: Text(
              "Sign in",
              style: TextStyle(
                fontFamily: "Montserrat",
                color: Colors.cyan,
                fontWeight: FontWeight.w500,
              ),
            )
          )
        ],
      )
    );
  }

  Widget _buildOrRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Divider(),
        ),
        Text(
          'OR',
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        Expanded(
            child: Divider()
        ),
      ],
    );
  }

  Widget _buildSocialButtonRow(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: SignInButton(
            Buttons.Google,
            text: "Sign up with Google",
            onPressed: () async {
              //some code here to sign up with google
              String uid;
              String photo;
              String username;
              String emailAddress;
              AuthenticationMethods authmethods = new AuthenticationMethods();
              changeState(true);
              //Navigate to Home Page
              try{
                dynamic result = await authmethods.signInWithGoogle();
                if (result == null){
                  changeState(false);
                  String error = "google";
                  showErrorMessage(context, error);
                }else{
                  // await UserController().trytoSee("murrayangel54@gmail.com");
                  dynamic doesUserExist = await UserController().doesGoogleUserExist(result.email);
                  if(doesUserExist == false){
                    bool isVerified = true;
                    uid = "${result.uid}";
                    photo = "${result.photoURL}";
                    username = "${result.displayName}";
                    emailAddress = "${result.email}";
                    UserController().createUser(uid, emailAddress, username, photo);
                    Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context)=> Wrapper(status: isVerified)));
                  }else{
                    changeState(false);
                    String error = "g-registered";
                    showErrorMessage(context, error);
                  }
                }
              }catch(e){
                print(e.toString());
              }
            },
          )
        ),
        Container(
          child: SignInButton(
            Buttons.FacebookNew,
            text: "Sign up with Facebook",
            onPressed: () async {
              //some code to register with facebook
            },
          )
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var loginLogo = 20 * SizeConfig.heightMultiplier;
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading ? Loading() : 
      SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 0.25 * SizeConfig.screenHeight,
                decoration: BoxDecoration(
                  color: Colors.cyan[200],
                  image: DecorationImage(
                    colorFilter: new ColorFilter.mode(Colors.cyan[100].withOpacity(0.3), BlendMode.dstATop),
                    image: AssetImage('assets/images/chatbackground.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius:BorderRadius.only(
                    bottomLeft: const Radius.circular(70),
                    bottomRight: const Radius.circular(70),
                  )
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/chatapplogo.png'),
                            height: loginLogo,
                          ),
                        ],
                      ),
                      _buildHeaderWelcome(context),
                    ],
                  ),
                ) 
              ),
              Container(
                height: 0.75 * SizeConfig.screenHeight,
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                    child: Column(
                      children: [
                        _buildUsernameRow(),
                        SizedBox(height: 5.0),
                        _buildEmailRow(),
                        SizedBox(height: 5.0),
                        _buildPasswordRow(),
                        SizedBox(height: 5.0),
                        _buildConfirmPasswordRow(),
                        SizedBox(height: 5.0),
                        _buildSignupRow(context),
                        _buildSigninRow(),
                        _buildOrRow(),
                        _buildSocialButtonRow(),
                      ],
                    )
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );  
  }
}
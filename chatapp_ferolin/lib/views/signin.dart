import 'package:flutter/material.dart';
import '../common/packages.dart';
import '../partials/submitLogin.dart';
import '../partials/sizeconfig.dart';
import 'forgotPassword.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String emailAddress, password;
  bool _isHidden = true;
  IconData iconP = Icons.remove_red_eye_sharp;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final TextEditingController _passwordController = TextEditingController();

  // @override
  // void dispose(){
  //   _passwordController.dispose();
  //   super.dispose();
  // }

  Widget _buildHeaderWelcome(BuildContext context){
    // final topPad = MediaQuery.of(context).size.height * 0.04;
    return Container(
      // padding: EdgeInsets.only(top: topPad),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '- Welcome Back! -',
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

  Widget _buildHeaderLogin(){
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Text(
            'Log in to your account',
            style: TextStyle(
              fontSize: 3 * SizeConfig.textMultiplier,
              fontWeight: FontWeight.w700, 
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
          )
        ],
      ),
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
            return "Password is too short";
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

  Widget _buildForgotPasswordRow(){
    return Container(
      padding: EdgeInsets.zero,
      alignment: Alignment.topRight,
      child: FlatButton(
        child: Text(
          "Forgot Password",
          style: TextStyle(
            fontFamily: "Montserrat",
            color: Colors.cyan,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
          );
        },
      )
    );
  }

  Widget _buildLoginRow(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container (
          height: 6 * SizeConfig.heightMultiplier,
          // width: 0.8 * SizeConfig.screenWidth,
          width: 0.85 * MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: 0.0),
          child: RaisedButton(
            onPressed: () {
              submitLogin(context, _formKey);
            },
            elevation: 5.0,
            color: Color(0xfff1976d2), 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              "LOGIN",
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

  Widget _buildSignupRow(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account? ",
            style: TextStyle(
              fontFamily: "Montserrat",
            ),
          ),
          InkWell(
            onTap: () {
              //some code to go to the registration page
              Navigator.pushNamed(context, '/register');
            },
            child: Text(
              "Sign up",
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
            onPressed: () {
              //some code here
            },
          ),
        ),
        Container(
          child: SignInButton(
            Buttons.FacebookNew,
            text: "Sign in with Facebook",
            onPressed: () {},
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 0.35 * SizeConfig.screenHeight,
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
                      Divider(height: 15, color: Colors.white),
                      _buildHeaderLogin(),
                    ],
                  ),
                ) 
              ),
              Container(
                height: 0.62 * SizeConfig.screenHeight,
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                    child: Column(
                      children: [
                        _buildEmailRow(),
                        SizedBox(height: 15.0),
                        _buildPasswordRow(),
                        _buildForgotPasswordRow(),
                        _buildLoginRow(context),
                        _buildSignupRow(),
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
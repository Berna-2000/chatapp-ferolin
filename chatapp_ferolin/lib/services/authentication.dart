import '../models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserClass defaultUser = new UserClass(userId: "00000");

  //Receives a User object and returns only the User ID
  UserClass _userFromFirebaseUser(User user){
    return user != null ? UserClass(userId:user.uid): null;
  }

  //Auth change user stream
  Stream<UserClass> get user{
    return _auth.authStateChanges()
      .map(_userFromFirebaseUser);
  }

  //Sign in With Email and Password
  Future signinWithEmailandPassword(String email, String password) async { 
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  
  //Sign up with Custom Fields
  Future signupWithEmailAndPassword(String email, String password) async{
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Reset Password
  Future resetPassword(String email)async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }

  //Send Verification Email
  Future verifyEmail(String email) async {
    User user = _auth.currentUser;
    try{
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
    }catch(e){
      print(e.toString());
    }
  }

  //Sign Out Function
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
}
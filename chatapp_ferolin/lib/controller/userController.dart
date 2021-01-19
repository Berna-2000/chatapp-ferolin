import 'package:chatapp_ferolin/models/appUsers.dart';
import '../common/packages.dart';

class UserController {
  CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  createUser(String uid, String emailAddress, String username){
    return users.doc(uid).set({
      'username': username,
      'emailAddress': emailAddress,
      'displayPhoto': 'assets/images/default.png',
      'deleted': false,
    });
  }

  getUsersByEmailAddress(String emailAddress){
    
  }
  
}
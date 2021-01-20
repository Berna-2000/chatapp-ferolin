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

  List<AppUser> _usersList(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return AppUser(
          username: doc.data()['username'],
          emailAddress: doc.data()['emailAddress'],
          displayPhoto: doc.data()['displayPhoto'],
          uid: doc.id,
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<AppUser>> get retrieveAllUsers {
    try {
      return users.snapshots().map(_usersList);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
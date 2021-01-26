import '../common/packages.dart';

class ChatroomController {
  CollectionReference chatroom =
      FirebaseFirestore.instance.collection('chatroom');

  createChatroom(String addedUser, String currentUser){
    return chatroom.doc(addedUser+"_"+currentUser).set({
      // 'username': username,
      // 'emailAddress': emailAddress,
      // 'displayPhoto': 'assets/images/default.png',
      // 'deleted': false,
    });
  }

  checkIfContactExists(String chatroomID){
    
  }
}
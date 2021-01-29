import '../common/packages.dart';
import '../models/chatMessages.dart';
import '../models/chatroom.dart';

class ChatroomController {
  CollectionReference chatroom =
      FirebaseFirestore.instance.collection('chatroom');

  generateChatroomId(String a, String b){
    if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
      return "$b\_$a";
    }else{
      return "$a\_$b";
    }
  }

  Future checkIfContactExists(String chatroomID) async {
    final snapShot = await chatroom.doc(chatroomID).get();
      if(snapShot.exists){
        return true;
      }else{
        return null;
      }
  }
  
  createChatroom(String chatroomId, List<String>users){
    return chatroom.doc(chatroomId).set({
      'users':users,
      'lastMessage': "",
      'lastMessageSender': "",
    });
  }

  updateLastMessageSent(String chatroomID, Chatroom chatroomUpdates){
    return chatroom
      .doc(chatroomID)
      .update({
        'lastMessage': chatroomUpdates.lastMessage,
        'lastMessageSentTime': chatroomUpdates.lastMessageSentTime,
        'lastMessageSender': chatroomUpdates.lastMessageSender
      })
        .then((value) => print("Chat Room updated"))
        .catchError((e) => print("Failed to update Chat Room: $e"));  
  }

  generateMessageId(){
    return randomAlphaNumeric(12);
  }

  addMessage(String chatroomID, ChatMessages chatMessages) async{
    return chatroom.doc(chatroomID)
      .collection("chats")
      .doc(chatMessages.messageId).set({
        'message': chatMessages.message,
        'sender': chatMessages.sender,
        'sentTime': chatMessages.sentTime,
        'displayPhoto': chatMessages.displayPhoto,
        'deleted': false,
    });
  }

  Future<Stream<QuerySnapshot>> retrieveChatroomMessages(String chatroomID) async{
    return chatroom.doc(chatroomID)
      .collection("chats")
      .orderBy("sentTime", descending: false)
      .snapshots();
  }
}
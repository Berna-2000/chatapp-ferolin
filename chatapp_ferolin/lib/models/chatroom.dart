class Chatroom {
  // String chatroomId;

  List <String> users = List<String>(2);
  String lastMessage;
  DateTime lastMessageSentTime;
  String lastMessageSender;
  String uid;

  Chatroom({this.users, this.lastMessage, this.lastMessageSentTime, this.lastMessageSender, this.uid});
}
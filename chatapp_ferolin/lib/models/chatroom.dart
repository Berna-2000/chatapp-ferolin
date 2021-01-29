class Chatroom {
  // String chatroomId;

  List <String> users = List<String>(2);
  String lastMessage;
  DateTime lastMessageSentTime;
  String lastMessageSender;

  Chatroom({this.lastMessage, this.lastMessageSentTime, this.lastMessageSender});
}
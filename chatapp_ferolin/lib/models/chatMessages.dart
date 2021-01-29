import 'package:chatapp_ferolin/common/packages.dart';

class ChatMessages {
  String messageId;
  String message;
  String sender;
  DateTime sentTime;
  String displayPhoto;

  ChatMessages({this.messageId, this.message, this.sender, this.sentTime, this.displayPhoto});
}
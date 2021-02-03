import 'package:chatapp_ferolin/partials/sizeconfig.dart';
import 'package:flutter/material.dart';
import '../common/packages.dart';

class MessagesList extends StatefulWidget {
  final streamMessages;
  MessagesList({this.streamMessages});
  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  String chatroomId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.streamMessages,
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Container(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                "You can now start a conversation with this person.",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 3 * SizeConfig.textMultiplier,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index){
            DocumentSnapshot messageSnapshot = snapshot.data.docs[index];
            return Text(messageSnapshot["message"]);
          }
        );
      }
    );
  }
}
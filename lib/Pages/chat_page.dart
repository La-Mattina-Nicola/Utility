import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:utility/components/chat_bubble.dart';
import 'package:utility/components/my_textfield.dart';
import 'package:utility/services/auth/auth_service.dart';
import 'package:utility/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  
  const ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  FocusNode myFocusNode = FocusNode();
  
  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      if(myFocusNode.hasFocus) {
        Future.delayed(const Duration(seconds: 1),
        () => scrollDown(),
        );
      }
    });

    Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendMessage() async {
    if(_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverID, _messageController.text);
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList(),),
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: _buildUserInput(context)
          )
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, senderID),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return const Text("Error");
        }
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }
        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs.map(
            (doc) => _buildMessageItem(doc))
            .toList(),
        );
      }
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    var alignment2 = isCurrentUser ? TextAlign.right : TextAlign.left;
    
    final dateFormatter = DateFormat('dd/MM');
    final timeFormatter = DateFormat('HH:mm');
    final formattedDate = dateFormatter.format(data['timeStamp'].toDate());
    final formattedTime = timeFormatter.format(data['timeStamp'].toDate());
    String date = '$formattedDate $formattedTime';

    return Column(
      children: [
        Text(date, textAlign: alignment2,),
        Container(
          alignment: alignment,
          child: Column(
            children: [
              ChatBubble(message:data["message"], isCurrentUser: isCurrentUser, timestamp: data['timeStamp'],),
            ],
          )
        ),
      ],
    );
  }

  Widget _buildUserInput(context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              focusNode: myFocusNode,
              hintText: "Type a message", 
              obscureText: false, 
              controller: _messageController
            )
          ),
          Container(
            margin: const EdgeInsets.only(right: 5),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: IconButton(onPressed: sendMessage, icon: const Icon(Icons.arrow_upward), color: Theme.of(context).colorScheme.tertiary,)
          )
        ],
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final Timestamp timestamp;

  const ChatBubble({super.key, required this.message, required this.isCurrentUser, required this.timestamp});
  
  String formatDate(Timestamp timestamp) {
    final dateFormatter = DateFormat('yy-dd-MM');
    final timeFormatter = DateFormat('HH:mm');
    final formattedDate = dateFormatter.format(timestamp.toDate());
    final formattedTime = timeFormatter.format(timestamp.toDate());
    return '$formattedDate $formattedTime';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), 
            color: isCurrentUser? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.primary,),
          child: Text(message),
        ),
      ]
    );
  }
}
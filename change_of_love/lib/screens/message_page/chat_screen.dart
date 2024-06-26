import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:change_of_love/data/firebase_services/firebase_service.dart';
import 'package:change_of_love/data/model/message.dart';

class ChatScreen extends StatelessWidget {
  final String senderId;
  final String receiverId;
  final String chatRoomId;

  ChatScreen({
    required this.senderId,
    required this.receiverId,
    required this.chatRoomId,
  });

  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mesajlar'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _firebaseService.getChatMessages(chatRoomId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Henüz mesaj yok.'));
                }
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  reverse: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final message = snapshot.data![index];
                    final isMyMessage = message.senderId == senderId;

                    return Align(
                      alignment: isMyMessage
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: isMyMessage ? Colors.blueAccent : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          message.message,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _buildMessageInputField(),
        ],
      ),
    );
  }

  Widget _buildMessageInputField() {
    final TextEditingController _controller = TextEditingController();
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Mesajınızı yazın...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (_controller.text.trim().isNotEmpty) {
                final message = Message(
                  senderId: senderId,
                  receiverId: receiverId,
                  message: _controller.text.trim(),
                  timestamp: Timestamp.now(),
                );
                _firebaseService.sendMessage(chatRoomId, message);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}

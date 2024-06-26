import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:change_of_love/data/model/message.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String chatRoomId, Message message) async {
    try {
      await _firestore.collection('chats').doc(chatRoomId).collection('messages').add(message.toJson());
    } catch (e) {
      print('Error sending message: $e');
      throw e;
    }
  }

  Stream<List<Message>> getChatMessages(String chatRoomId) {
    try {
      return _firestore
          .collection('chats')
          .doc(chatRoomId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => Message.fromDocument(doc)).toList());
    } catch (e) {
      print('Error getting chat messages: $e');
      throw e;
    }
  }
}

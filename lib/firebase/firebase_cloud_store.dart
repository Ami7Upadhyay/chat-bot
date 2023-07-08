import 'package:ai_chat_bot/models/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/local_storage/app_prefrences.dart';

class FirebaseCloudStore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> storeChatData(ChatMessage chatMessage) async {
    String? email = await AppPrefrences().getEmail();
    final data = firestore.collection('chat_conversation').doc(email);
    await data.set(chatMessage.toJson());
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchStreamChatMessages(
      String email) {
    final data = firestore.collection('chat_conversation').doc(email);
    return data.snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchChatMessages(
      String email) async {
    return await firestore.collection('chat_conversation').doc(email).get();
  }
}

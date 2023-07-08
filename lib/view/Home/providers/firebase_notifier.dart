import 'package:ai_chat_bot/core/base_state/base_state.dart';
import 'package:ai_chat_bot/models/chat_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../firebase/firebase_cloud_store.dart';
import '../../../models/Message.dart';

final fireBaseProvider = StateNotifierProvider<FireBaseNotifier, BaseState>(
    (ref) => FireBaseNotifier());

class FireBaseNotifier extends StateNotifier<BaseState> {
  FireBaseNotifier() : super(InitialState(data: []));

  Future<void> getChatDataFromFireBase(String email) async {
    state = LoadingState();
    try {
      var response = await FirebaseCloudStore().fetchChatMessages(email);
      if (response.exists) {
        Map<String, dynamic>? map = response.data();
        if (map != null && map.isNotEmpty) {
          ChatMessage chatData = ChatMessage.fromJson(response);
          state =
              SuccessState<List<ChatingMessage>>(data: chatData.message ?? []);
        } else {
          state = SuccessState<List<ChatingMessage>>(data: []);
        }
      } else {
        state = SuccessState<List<ChatingMessage>>(data: []);
      }
    } catch (e) {
      state = ErrorState(data: e.toString());
    }
  }

  void storeDataToFireBase(String content) {
    SuccessState<List<ChatingMessage>> chatList =
        state as SuccessState<List<ChatingMessage>>;
    if (chatList.data != null && chatList.data!.isNotEmpty) {
      ChatingMessage data = chatList.data!.last;
      Map<String, dynamic> mapData = data.toJson();
      mapData.update('ai', (value) => content);
      chatList.data![chatList.data!.length - 1] =
          ChatingMessage.fromJson(mapData);
      FirebaseCloudStore().storeChatData(ChatMessage(message: chatList.data!));
    }
  }

  void add(String text) {
    SuccessState<List<ChatingMessage>> chatList =
        state as SuccessState<List<ChatingMessage>>;
    chatList.data?.add(ChatingMessage(user: text));
    state = SuccessState(data: chatList.data!);
  }
}

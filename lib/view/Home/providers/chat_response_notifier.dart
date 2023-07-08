import 'package:ai_chat_bot/core/base_state/base_state.dart';
import 'package:ai_chat_bot/core/request_params/request_params.dart';
import 'package:ai_chat_bot/models/chat_data.dart';
import 'package:ai_chat_bot/repository/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/show_toast.dart';

final chatResponseProvider =
    StateNotifierProvider<ChatResponseNotifier, BaseState>(
        (ref) => ChatResponseNotifier(ref.watch(respositoryProvider)));

class ChatResponseNotifier extends StateNotifier<BaseState> {
  final Repository _repository;
  ChatResponseI? chatResponseI;

  ChatResponseNotifier(this._repository) : super(InitialState());

  Future<void> getChatResponse(ChatResponseParams params) async {
    state = LoadingState();
    try {
      var response = await _repository.getChatResponse(params: params);

      response.fold((failed) {
        showCustomToast(failed.msg);
        state = ErrorState(data: failed);
      }, (result) {
        chatResponseI?.onSuccess(chatData: result);
        state = SuccessState<ChatData>(data: result);
      });
    } catch (e) {
      showCustomToast(e.toString());
      state = ErrorState(data: e.toString());
    }
  }
}

class ChatResponseParams extends RequestParams {
  final String content;
  ChatResponseParams({required this.content});
  @override
  Map<String, dynamic> toJson() {
    return {
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": content}
      ],
      "temperature": 0.7
    };
  }
}

abstract class ChatResponseI {
  void onSuccess({required ChatData chatData});
}

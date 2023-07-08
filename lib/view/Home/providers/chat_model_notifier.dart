import 'package:ai_chat_bot/core/base_state/base_state.dart';
import 'package:ai_chat_bot/repository/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/show_toast.dart';

final chatModelProvider = StateNotifierProvider<ChatModelNotifier, BaseState>(
    (ref) => ChatModelNotifier(ref.watch(respositoryProvider)));

class ChatModelNotifier extends StateNotifier<BaseState> {
  final Repository _repository;
  ChatModelNotifier(this._repository) : super(InitialState());

  Future<void> getChatModels() async {
    state = LoadingState();
    try {
      var response = await _repository.getChatModel();

      response.fold((failed) {
        showCustomToast(failed.msg);
        state = ErrorState(data: failed);
      }, (result) {
        return state = SuccessState(data: result);
      });
    } catch (e) {
      showCustomToast(e.toString());
      state = ErrorState(data: e.toString());
    }
  }
}

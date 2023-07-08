import 'package:ai_chat_bot/core/base_state/base_state.dart';
import 'package:ai_chat_bot/firebase/firebase_authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/local_storage/app_prefrences.dart';
import '../../../widgets/show_toast.dart';

final createAccountProvider =
    StateNotifierProvider<CreateAccountNotifier, BaseState>((ref) =>
        CreateAccountNotifier(ref.watch(fireBaseAuthenticationProvidr)));

class CreateAccountNotifier extends StateNotifier<BaseState> {
  final FireBaseAuthentication _fireBaseAuthentication;
  CreateAccountI? createAccountI;
  CreateAccountNotifier(this._fireBaseAuthentication) : super(InitialState());

  Future<void> createAccount(
      {required String email, required String password, String? name}) async {
    state = LoadingState();
    try {
      var fireBaseResponse = await _fireBaseAuthentication.createUser(
          email: email, password: password);

      fireBaseResponse.fold((failed) {
        showCustomToast(failed.msg);
        state = ErrorState(data: failed.toString());
      }, (response) {
        AppPrefrences().setUser(response);
        state = SuccessState<User>(data: response);
        createAccountI?.onSuccessfullCreateAccount(user: response);
      });
    } catch (e) {
      showCustomToast(e.toString());
      state = ErrorState(data: e.toString());
    }
  }
}

abstract class CreateAccountI {
  void onSuccessfullCreateAccount({User user});
}

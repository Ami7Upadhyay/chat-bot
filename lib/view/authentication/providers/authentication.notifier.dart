import 'package:ai_chat_bot/core/base_state/base_state.dart';
import 'package:ai_chat_bot/core/local_storage/app_prefrences.dart';
import 'package:ai_chat_bot/firebase/firebase_authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/show_toast.dart';

final authenticateUserProvider =
    StateNotifierProvider<AuthenticationNotifier, BaseState>((ref) =>
        AuthenticationNotifier(ref.watch(fireBaseAuthenticationProvidr)));

class AuthenticationNotifier extends StateNotifier<BaseState> {
  final FireBaseAuthentication _fireBaseAuthentication;
  AuthenticationI? authenticationI;

  AuthenticationNotifier(this._fireBaseAuthentication) : super(InitialState());

  Future<void> authenticateUser(
      {required String email, required String password}) async {
    state = LoadingState();

    try {
      var firebaseResponse = await _fireBaseAuthentication.authenticateUser(
          email: email, password: password);
      firebaseResponse.fold((failed) {
        showCustomToast(failed.msg);
        state = ErrorState(data: failed);
      }, (response) {
        AppPrefrences().setUser(response);
        state = SuccessState<User>(data: response);
        authenticationI?.onSuccessfulAuthentication(user: response);
      });
    } catch (e) {
      showCustomToast(e.toString());
      state = ErrorState(data: e.toString());
    }
  }
}

abstract class AuthenticationI {
  void onSuccessfulAuthentication({User user});
}

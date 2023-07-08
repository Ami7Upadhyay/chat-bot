import 'package:ai_chat_bot/firebase/firebase_authentication_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/error/failure.dart';

final fireBaseAuthenticationProvidr = Provider<FireBaseAuthentication>(
    (ref) => FireBaseAuthenticationImpl());

abstract class FireBaseAuthentication {
  Future<Either<Failure, User>> createUser(
      {required String email, required String password, String? name});
  Future<Either<Failure, User>> authenticateUser(
      {required String email, required String password});
}

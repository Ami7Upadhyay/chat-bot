import 'package:ai_chat_bot/core/error/failure.dart';
import 'package:ai_chat_bot/firebase/firebase_authentication.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuthenticationImpl implements FireBaseAuthentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FireBaseAuthenticationImpl();
  // : _firebaseAuth = firebaseAuth;
  @override
  Future<Either<Failure, User>> createUser(
      {required String email, required String password, String? name}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        return Right(user);
      }
      return Right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Left(Failure.server(
            code: 0, msg: 'The Password is took week try another password'));
      } else if (e.code == 'email-already-in-use') {
        return Left(Failure.server(
            code: 0,
            msg:
                'The account $email already exist try another email address.'));
      } else {
        return Left(Failure.server(code: 0, msg: e.code));
      }
    } catch (e) {
      return Left(Failure.server(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> authenticateUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return Right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Left(Failure.server(msg: 'email address $email not found!'));
      } else if (e.code == 'wrong-password') {
        return Left(
            Failure.server(msg: 'You have entered an invalid password'));
      } else {
        return Left(Failure.server(code: 0, msg: e.code));
      }
    } catch (e) {
      return Left(Failure.server(
          code: 0, msg: 'The account already exists for that email.'));
    }
  }
}

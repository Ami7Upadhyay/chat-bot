
import 'package:firebase_core/firebase_core.dart';

class AppFireBase {
  static init() async {
    await Firebase.initializeApp();
  } 
}
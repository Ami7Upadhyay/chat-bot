import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPrefrences {
  SharedPreferences? _sharedPreferences;
  static String SET_USER_KEY = 'SET_USER_KEY';
  static String SET_EMAIL = 'SET_EMAIL';
  static String EMAIL = '';

  void setUser(User user) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences?.setString(SET_USER_KEY, user.toString());
    EMAIL = user.email ?? '';
    setEmail(user.email);
  }

  void setEmail(String? email) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences?.setString(SET_EMAIL, email ?? '');
  }

  Future<String> getEmail() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String email = _sharedPreferences?.getString(SET_EMAIL) ?? '';
    EMAIL = email;
    return Future.value(email);
  }

  // Future<User> getUser() async {
  //   _sharedPreferences = await SharedPreferences.getInstance();
  //   _sharedPreferences?.get(SET_USER_KEY);
  // }
  Future<bool> isLogin() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String user = _sharedPreferences?.getString(SET_USER_KEY) ?? '';
    return Future.value(user.isEmpty ? false : true);
  }

  Future<void> clear() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences?.remove(SET_USER_KEY);
  }
}

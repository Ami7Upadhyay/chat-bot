import 'package:ai_chat_bot/config/app_theme.dart';
import 'package:ai_chat_bot/core/local_storage/app_prefrences.dart';
import 'package:ai_chat_bot/view/Home/home.dart';
import 'package:ai_chat_bot/view/authentication/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var isLogin = await AppPrefrences().isLogin();
  String email = await AppPrefrences().getEmail();
  runApp(ProviderScope(
      child: MyApp(
    isLogin: isLogin,
    email: email,
  )));
}

class MyApp extends StatelessWidget {
  final bool isLogin;
  final String email;
  const MyApp({super.key, this.isLogin = false, required this.email});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: isLogin ? HomePage(email: email) : SignInPage(),
    );
  }
}

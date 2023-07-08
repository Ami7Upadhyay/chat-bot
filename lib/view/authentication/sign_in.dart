import 'package:ai_chat_bot/extension/app_extenstion.dart';
import 'package:ai_chat_bot/view/Home/home.dart';
import 'package:ai_chat_bot/view/authentication/providers/authentication.notifier.dart';
import 'package:ai_chat_bot/view/authentication/providers/create_account_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/base_state/base_state.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage>
    with SingleTickerProviderStateMixin
    implements CreateAccountI, AuthenticationI {
  final TextEditingController _emailEditingController =
      TextEditingController(text: 'amit@gmail.com');
  final TextEditingController _passwordEditingController =
      TextEditingController(text: '12345678');
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  var createAccountState;
  var authenticationSate;
  late final AnimationController _logoAnimationController;
  late final Animation<double> _logoAnimation;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    _logoAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    var curvedAnimation = CurvedAnimation(
        parent: _logoAnimationController, curve: Curves.bounceIn);
    _logoAnimation = Tween<double>(begin: 0, end: 100).animate(curvedAnimation);
    _logoAnimationController.forward();

    _logoAnimationController.addListener(() {
      setState(() {});
    });

    ref.read(createAccountProvider.notifier).createAccountI = this;
    ref.read(authenticateUserProvider.notifier).authenticationI = this;

    _emailFocusNode = FocusNode();
    _emailFocusNode.addListener(() {
      _emailFocusNode.hasFocus
          ? _logoAnimationController.reverse()
          : _logoAnimationController.forward();
    });

    _passwordFocusNode = FocusNode();
    _passwordFocusNode.addListener(() {
      _passwordFocusNode.hasFocus
          ? _logoAnimationController.reverse()
          : _logoAnimationController.forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    watchAllProviders();
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: _buildContent()),
    );
  }

  Widget _buildContent() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'chatbot'.toPng,
            height: _logoAnimation.value,
          ),
          // SvgPicture.asset('image'.toSvg, semanticsLabel: 'Acme Logo'),
          Text(
            !_isLogin ? "Create your account" : 'Welcome Back!',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          ),
          35.vPad,
          _emailField(),
          15.vPad,
          _passwordField(),
          40.vPad,
          _continue(),
          24.vPad,
          _createAccountOrLoginToAccount()
        ],
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: _emailEditingController,
      focusNode: _emailFocusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value != null) {
          final bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value);
          if (value.isEmpty) {
            return "Email address can't blank";
          }
          if (!emailValid) {
            return "Please enter valid email address";
          }
        }
        return null;
      },
      decoration: const InputDecoration(hintText: "Email Address"),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      focusNode: _passwordFocusNode,
      style: TextStyle(color: Theme.of(context).primaryColor),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value != null) {
          if (value.isEmpty) {
            return "Password can't blank";
          }
        }
        return null;
      },
      controller: _passwordEditingController,
      decoration: const InputDecoration(hintText: "Password"),
    );
  }

  Widget _continue() {
    return ElevatedButton(
        onPressed: (authenticationSate is LoadingState ||
                createAccountState is LoadingState)
            ? null
            : () {
                onContinueBtnPressed();
              },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isLogin ? 'Continue' : 'Create Account',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            15.hPad,
            if (authenticationSate is LoadingState ||
                createAccountState is LoadingState)
              const SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  )),
          ],
        ));
  }

  void onContinueBtnPressed() {
    if (_formKey.currentState!.validate()) {
      if (_isLogin) {
        ref.read(authenticateUserProvider.notifier).authenticateUser(
            email: _emailEditingController.text,
            password: _passwordEditingController.text);
      } else {
        ref.read(createAccountProvider.notifier).createAccount(
            email: _emailEditingController.text,
            password: _passwordEditingController.text);
      }
    }
  }

  Widget _createAccountOrLoginToAccount() {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          !_isLogin ? 'Already have an account?' : "Don't have account?",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _isLogin = !_isLogin;
            });
          },
          child: Text(
            !_isLogin ? 'Log in' : 'Create Account',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void onSuccessfullCreateAccount({User? user}) {
    Navigator.of(context).pop();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(email: user?.email ?? ''),
        ));
  }

  @override
  void onSuccessfulAuthentication({User? user}) {
    Navigator.of(context).pop();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(email: user?.email ?? ''),
        ));
  }

  void watchAllProviders() {
    createAccountState = ref.watch(createAccountProvider);
    authenticationSate = ref.watch(authenticateUserProvider);
  }
}

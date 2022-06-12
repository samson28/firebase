import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';

class Login extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const Login({Key? key, required this.onClickedSignUp}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginFormkey = GlobalKey<FormState>();
  final _email = TextEditingController();

  final _password = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void login() async {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
      try {
        await auth.signInWithEmailAndPassword(
            email: _email.value.text, password: _password.value.text);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }

      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }

    return Scaffold(
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: loginFormkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.access_alarm,
                  size: 100,
                ),
                const SizedBox(
                  height: 35,
                ),
                TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter you E-mail';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                    controller: _password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Password';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    if (loginFormkey.currentState!.validate()) {
                      login();
                    }
                  },
                  child: Container(
                    height: 50.0,
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.lightBlue[500],
                    ),
                    child: const Center(
                      child: Text('Log In'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/resetPassword');
                  },
                  child: const Text("Forgot Password?"),
                ),
                TextButton(
                  onPressed: () {
                    widget.onClickedSignUp();
                  },
                  child: const Text("You Don't Have Any Account ?"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

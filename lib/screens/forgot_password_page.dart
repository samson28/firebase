import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void showSnack(message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await auth.sendPasswordResetEmail(email: _emailController.value.text);
      showSnack("Password Reset Email Sent");
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);
      showSnack(e.message);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: forgotPasswordFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                "receive an email to \nreset your password",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                  controller: _emailController,
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
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  resetPassword();
                  /*Navigator.of(context).pushNamed('/verifyEmail');*/
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
                    child: Text('Reset Password'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

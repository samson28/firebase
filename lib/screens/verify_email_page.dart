import 'dart:async';
import 'package:firebase/screens/my_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerityEmailPage extends StatefulWidget {
  const VerityEmailPage({Key? key}) : super(key: key);

  @override
  State<VerityEmailPage> createState() => _VerityEmailPageState();
}

class _VerityEmailPageState extends State<VerityEmailPage> {
  bool isEmailVerify = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerify) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerify(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel;
    super.dispose();
  }

  Future checkEmailVerify() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerify) {
      timer?.cancel();
    }
  }

  Future sendVerificationEmail() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
    setState(() {
      canResendEmail = false;
    });
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      canResendEmail = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerify
        ? const MyHomePage(title: "Hello world")
        : Scaffold(
            appBar: AppBar(
              title: const Text("Verify Email"),
            ),
            body: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                        "An verification email have been send to your email"),
                    const SizedBox(
                      height: 35,
                    ),
                    GestureDetector(
                      onTap: () {
                        canResendEmail ? sendVerificationEmail() : null;
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
                          child: Text('Resent Email'),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: const Text("Cancel"),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

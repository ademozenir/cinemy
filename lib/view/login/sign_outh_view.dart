import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignOutView extends StatefulWidget {
  const SignOutView({super.key});

  @override
  State<SignOutView> createState() => _SignOutViewState();
}

class _SignOutViewState extends State<SignOutView> {

  void signOut() {
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}

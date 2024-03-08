import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:news_app/screens/authScreens/login_or_registration.dart';
import 'package:news_app/homepage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // if your is logged-in
            return const Homepage();
          } else {
            // if user is not logged in
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:news_app/repo/auth_repo.dart';

class AuthService {
  BuildContext context;
  AuthService({
    required this.context,
  });

  registerUser(String email, String password, String confirmPassword) {
    try {
      if (password == confirmPassword) {
        if (email.isNotEmpty) {
          AuthRepo().register(email, password);
        } else {
          debugPrint("Enter email");
        }
      } else {
        debugPrint("password-doesn't match");
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  loginUser(String email, String password) {
    try {
      AuthRepo().login(email, password);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      if (e.code == 'user-not-found') {
        throw 'Incorrect Email';
      } else if (e.code == 'wrong-password') {
        throw 'Incorrect Password';
      } else if (e.message == 'Given String is empty or null') {
        throw "Email or Password can't be empty";
      }
    }
  }

  //  void signout() async {
  //     await showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text(
  //           "Sign Out?",
  //           style: TextStyle(fontWeight: FontWeight.bold),
  //         ),
  //         content: const Text(
  //             "Do you want to sign out? All your transactions will be erased!"),
  //         actions: [
  //           MaterialButton(
  //             height: 50,
  //             elevation: 0,
  //             color: Colors.red.shade200,
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(15)),
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: const Text(
  //               "Cancel",
  //               style: TextStyle(fontSize: 18),
  //             ),
  //           ),
  //           MaterialButton(
  //             height: 50,
  //             elevation: 0,
  //             color: Colors.amber,
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(15)),
  //             onPressed: () {
  //               FirebaseAuth.instance.signOut();
  //               Navigator.pop(context);
  //             },
  //             child: const Text(
  //               "Sign Out",
  //               style: TextStyle(fontSize: 18),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
}

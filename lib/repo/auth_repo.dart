import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  // register new user
  void register(String email, String password) async {
    try {
      var resp = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final userName = email.split('@').first;

      await resp.user!.updateDisplayName(userName);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  // login user
  void login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException {
      rethrow;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/services/auth_service.dart';
import 'package:news_app/widgets/input_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.onTap});
  final Function()? onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passController = TextEditingController();

  void customAlert(String? textError) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(textError!),
        );
      },
    );
  }

  // void googleSignIn() {
  //   AuthService().signInWithGoogle();
  // }

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService(context: context);
    void login() async {
      try {
        authService.loginUser(
            emailController.text.trim(), passController.text.trim());
      } on FirebaseAuthException catch (e) {
        customAlert(e.message);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Icon(
                Icons.lock_rounded,
                size: MediaQuery.of(context).size.height / 4,
              ),
            ),
            const Text(
              textAlign: TextAlign.center,
              "Welcome back, we missed you",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
              textAlign: TextAlign.center,
              "Keep yourself updated",
              style: TextStyle(height: 2, fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 15,
            ),
            InputTextField(
                obscureText: false,
                hintText: "Email",
                textController: emailController,
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 15,
            ),
            InputTextField(
                obscureText: true,
                hintText: "Password",
                textController: passController,
                textInputType: TextInputType.visiblePassword),
            const SizedBox(
              height: 15,
            ),
            FilledButton.tonal(
              onPressed: login,
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 18),
              ),
            ),

            // const SizedBox(
            //   height: 30,
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(15.0),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Divider(
            //           endIndent: 5,
            //           thickness: 0.3,
            //           color: Colors.grey.shade600,
            //         ),
            //       ),
            //       const Text("Or Sign-in with"),
            //       Expanded(
            //         child: Divider(
            //           indent: 5,
            //           thickness: 0.3,
            //           color: Colors.grey.shade600,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(15.0),
            //   child: IconButton(
            //     iconSize: 40,
            //     color: Colors.red,
            //     padding: const EdgeInsets.all(0),
            //     onPressed: () => AuthService().signInWithGoogle(),
            //     icon: Image.asset(
            //       Constants.googleLogo,
            //     ),
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Not a member?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  TextButton(
                    onPressed: widget.onTap,
                    child: const Text(
                      "Register Now",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

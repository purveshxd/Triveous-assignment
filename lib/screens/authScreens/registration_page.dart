// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/services/auth_service.dart';
import 'package:news_app/widgets/input_text_field.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key, this.onTap});
  final Function()? onTap;

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final emailController = TextEditingController();
  final confirmpassController = TextEditingController();
  final passController = TextEditingController();
  final userNameController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService(context: context);

    registerUser() {
      try {
        authService.registerUser(emailController.text.trim(),
            passController.text.trim(), confirmpassController.text.trim());
      } on FirebaseAuthException catch (e) {
        customAlert(e.message);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
                // decoration: const BoxDecoration(
                //   image: DecorationImage(
                //     fit: BoxFit.contain,
                //     image: AssetImage(''),
                //   ),
                // ),
                child: Icon(
                  Icons.account_circle,
                  size: MediaQuery.of(context).size.height / 6.5,
                ),
              ),
              const Text(
                textAlign: TextAlign.center,
                "Welcome to theNewsPortal",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                textAlign: TextAlign.center,
                "Stay updated with the latest news & trends",
                style: TextStyle(height: 2, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 10,
              ),
              InputTextField(
                  obscureText: false,
                  hintText: "Username",
                  textController: userNameController,
                  textInputType: TextInputType.name),
              const SizedBox(
                height: 10,
              ),
              InputTextField(
                  obscureText: false,
                  hintText: "Email",
                  textController: emailController,
                  textInputType: TextInputType.emailAddress),
              const SizedBox(
                height: 10,
              ),
              InputTextField(
                  obscureText: true,
                  hintText: "Password",
                  textController: passController,
                  textInputType: TextInputType.visiblePassword),
              const SizedBox(
                height: 10,
              ),
              InputTextField(
                obscureText: true,
                hintText: "Confirm Password",
                textController: confirmpassController,
                textInputType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 15,
              ),
              FilledButton.tonal(
                // onPressed: () {},
                onPressed: registerUser,
                child: const Text(
                  "SignUp",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already a member? ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: widget.onTap,
                    child: const Text(
                      "Sign-up",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

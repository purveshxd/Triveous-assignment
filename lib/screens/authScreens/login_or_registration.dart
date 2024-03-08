import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/screens/authScreens/login_page.dart';
import 'package:news_app/screens/authScreens/registration_page.dart';

final pageSwitchProvider = StateProvider<bool>((ref) => true);

class LoginOrRegister extends ConsumerWidget {
  const LoginOrRegister({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final pageSwitch = ref.watch(pageSwitchProvider);

    togglePages() {
      ref.watch(pageSwitchProvider.notifier).update((state) => !state);
    }

    // void customAlert(String textError) {
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         title: Text(textError),
    //       );
    //     },
    //   );
    // }

    if (pageSwitch) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegistrationPage(
        onTap: togglePages,
      );
    }
  }
}

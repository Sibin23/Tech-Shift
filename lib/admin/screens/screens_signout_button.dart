import 'package:flutter/material.dart';
import 'package:prosample_1/login.dart';

class SignoutButton extends StatelessWidget {
  const SignoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    void signOut() {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => const ScreenLogin()),
        (route) => false,
      );
    }

    return IconButton(
        onPressed: () {
          signOut();
        },
        icon: const Icon(Icons.exit_to_app));
  }
}

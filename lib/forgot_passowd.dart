import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/commonfile.dart';

class ScreenforgotPassword extends StatefulWidget {
  const ScreenforgotPassword({super.key});

  @override
  State<ScreenforgotPassword> createState() => _ScreenforgotPasswordState();
}

class _ScreenforgotPasswordState extends State<ScreenforgotPassword> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            UiHelper.customTextField(
                _emailController, 'Email', Icons.mail_rounded),
            const SizedBox(height: 10),
            UiHelper.customTextField(
                _passwordController, 'Password', Icons.security_outlined)
          ],
        ),
      ),
    );
  }
}

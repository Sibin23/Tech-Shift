// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/utils/commonfile.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class ScreenPassword extends StatefulWidget {
  const ScreenPassword({super.key});

  @override
  State<ScreenPassword> createState() => _ScreenPasswordState();
}

class _ScreenPasswordState extends State<ScreenPassword> {
  final _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      UiHelper.customAlertBox(
          context, 'Password reset Link send ! Check your Email');
    } on FirebaseAuthException catch (ex) {
      
      UiHelper.customAlertBox(context, ex.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reset your Password',
                  style: TextStyling.titleText,
                ),
                Text(
                  "Enter the Email Address you used when you joined and We'll send you instructions to reset your password",
                  style: TextStyling.subtitle,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.14,
                  child: Lottie.asset(
                      'assets/forgot pasword/Animation - 1706880370842.json'),
                ),
                const SizedBox(height: 30),
                UiHelper.customTextField(
                    controller: _emailController,
                    labeltext: 'Email',
                    iconData: Icons.email_rounded,
                    keyboardType: TextInputType.emailAddress,
                    validate: 'Email Adress is required'),
                const SizedBox(height: 30),
                UiHelper.customButton(context, () { 
                  resetPassword();
                }, text: 'Next')
              ],
            ),
          ),
        ),
      ),
    );
  }
}

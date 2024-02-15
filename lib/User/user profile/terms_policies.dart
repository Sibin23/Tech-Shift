import 'package:flutter/material.dart';

class TermsAndPolicy extends StatelessWidget {
  const TermsAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Center(child: Text('Terms and conditions'),)),
    );
  }
}
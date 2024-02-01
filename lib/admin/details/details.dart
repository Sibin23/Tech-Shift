import 'package:flutter/material.dart';

class ScreenDetails extends StatefulWidget {
  const ScreenDetails({super.key});

  @override
  State<ScreenDetails> createState() => _ScreenDetailsState();
}

class _ScreenDetailsState extends State<ScreenDetails> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: Container(child: Text('Terms and Conditions'))),
    );
  }
}
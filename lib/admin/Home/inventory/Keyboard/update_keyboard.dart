import 'package:flutter/material.dart';

class UpdateKeyboard extends StatefulWidget {
  const UpdateKeyboard({super.key});

  @override
  State<UpdateKeyboard> createState() => _UpdateKeyboardState();
}

class _UpdateKeyboardState extends State<UpdateKeyboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Column(
          children: [
            Center(child: Text('Update Keyboard')),
          ],
        ),
      ),
    );
  }
}
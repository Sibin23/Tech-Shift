import 'package:flutter/material.dart';

class ListKeyboard extends StatefulWidget {
  const ListKeyboard({super.key});

  @override
  State<ListKeyboard> createState() => _ListKeyboardState();
}

class _ListKeyboardState extends State<ListKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Center(child: Text('List Keyboard'))),
    );
  }
}
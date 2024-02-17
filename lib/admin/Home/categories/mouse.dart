import 'package:flutter/material.dart';

class ListMouse extends StatefulWidget {
  const ListMouse({super.key});

  @override
  State<ListMouse> createState() => _ListMouseState();
}

class _ListMouseState extends State<ListMouse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(child: Center(child: Text('List Mouse'))),
    );
  }
}
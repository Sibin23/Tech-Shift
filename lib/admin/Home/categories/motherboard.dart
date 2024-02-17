import 'package:flutter/material.dart';

class ListMotherboard extends StatefulWidget {
  const ListMotherboard({super.key});

  @override
  State<ListMotherboard> createState() => _ListMotherboardState();
}

class _ListMotherboardState extends State<ListMotherboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(child: Text('List Mother Board')),
      ),
    );
  }
}
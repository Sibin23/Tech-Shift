import 'package:flutter/material.dart';

class ListCables extends StatefulWidget {
  const ListCables({super.key});

  @override
  State<ListCables> createState() => _ListCablesState();
}

class _ListCablesState extends State<ListCables> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Center(child: Text('list cables'),)),
    );
  }
}
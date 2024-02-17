import 'package:flutter/material.dart';

class ListCoolers extends StatefulWidget {
  const ListCoolers({super.key});

  @override
  State<ListCoolers> createState() => _ListCoolersState();
}

class _ListCoolersState extends State<ListCoolers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Center(child: Text('list coolers'),)),
    );
  }
}
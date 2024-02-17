import 'package:flutter/material.dart';

class ListRam extends StatefulWidget {
  const ListRam({super.key});

  @override
  State<ListRam> createState() => _ListRamState();
}

class _ListRamState extends State<ListRam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
body: SafeArea(child: Center(child: Text('List RAM'),)),    );
  }
}
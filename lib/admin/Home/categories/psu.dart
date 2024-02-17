import 'package:flutter/material.dart';

class ListPsu extends StatefulWidget {
  const ListPsu({super.key});

  @override
  State<ListPsu> createState() => _ListPsuState();
}

class _ListPsuState extends State<ListPsu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Center(child: Text('PSU'))),
    );
  }
}
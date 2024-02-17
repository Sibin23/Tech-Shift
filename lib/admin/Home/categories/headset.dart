import 'package:flutter/material.dart';

class ListHeadset extends StatefulWidget {
  const ListHeadset({super.key});

  @override
  State<ListHeadset> createState() => _ListHeadsetState();
}

class _ListHeadsetState extends State<ListHeadset> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Center(child: Text('List Headsets'))),
    );
  }
}
import 'package:flutter/material.dart';

class ListCabinet extends StatefulWidget {
  const ListCabinet({super.key});

  @override
  State<ListCabinet> createState() => _ListCabinetState();
}

class _ListCabinetState extends State<ListCabinet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Center(child: Text('List cabinet'),)),
    );
  }
}
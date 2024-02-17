import 'package:flutter/material.dart';

class ListChair extends StatefulWidget {
  const ListChair({super.key});

  @override
  State<ListChair> createState() => __ListChairState();
}

class __ListChairState extends State<ListChair> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SafeArea(child: Center(child: Text('List chairs'),)),
    );
  }
}
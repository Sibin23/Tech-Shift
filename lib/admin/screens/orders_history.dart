import 'package:flutter/material.dart';

class ScreenOrdersList extends StatefulWidget {
  const ScreenOrdersList({super.key});

  @override
  State<ScreenOrdersList> createState() => _ScreenOrdersListState();
}

class _ScreenOrdersListState extends State<ScreenOrdersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(child: Text('orders List'))),
    );
  }
}
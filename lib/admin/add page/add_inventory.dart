import 'package:flutter/material.dart';

class ScreenInventory extends StatefulWidget {
  const ScreenInventory({super.key});

  @override
  State<ScreenInventory> createState() => _ScreenInventoryState();
}

class _ScreenInventoryState extends State<ScreenInventory> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: Text('Add Inventory')),
    );
  }
}
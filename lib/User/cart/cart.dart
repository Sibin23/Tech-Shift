import 'package:flutter/material.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

class ScreenCart extends StatefulWidget {
  const ScreenCart({super.key});

  @override
  State<ScreenCart> createState() => _ScreenCartState();
}

class _ScreenCartState extends State<ScreenCart> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Center(child: Column(
        children: [
         
          Text('Screen CArt'),
        ],
      )),
    );
  }
}
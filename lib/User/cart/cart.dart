import 'package:flutter/material.dart';


class ScreenCart extends StatefulWidget {
  
  const ScreenCart({super.key});

  @override
  State<ScreenCart> createState() => _ScreenCartState();
}

class _ScreenCartState extends State<ScreenCart> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Cart page'),
      ),
      body: SafeArea(child: Column(children: [
        
      ]),)
    );
  }
}
import 'package:flutter/material.dart';

class ScreenPC extends StatefulWidget {
  const ScreenPC({super.key});

  @override
  State<ScreenPC> createState() => _ScreenPreBuildState();
}

class _ScreenPreBuildState extends State<ScreenPC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Pre-Builds')),);
  }
}
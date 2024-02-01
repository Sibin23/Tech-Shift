import 'package:flutter/material.dart';

class ScreenPreBuild extends StatefulWidget {
  const ScreenPreBuild({super.key});

  @override
  State<ScreenPreBuild> createState() => __ScreenPreBuildStateState();
}

class __ScreenPreBuildStateState extends State<ScreenPreBuild> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Container(child: Text('Prebuilds')),
      ),
    );
  }
}
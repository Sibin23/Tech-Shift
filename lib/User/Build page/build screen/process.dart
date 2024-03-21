import 'package:flutter/material.dart';

class ProcessDetails extends StatelessWidget {
  const ProcessDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Column(
        children: [
          Text('Process'),
        ],
      )),
    );
  }
}
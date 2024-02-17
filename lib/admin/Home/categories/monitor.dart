import 'package:flutter/material.dart';

class ListMonitor extends StatefulWidget {
  const ListMonitor({super.key});

  @override
  State<ListMonitor> createState() => _ListMonitorState();
}

class _ListMonitorState extends State<ListMonitor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(child: Center(child: Text('List Monitor'),)),
    );
  }
}
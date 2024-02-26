import 'package:flutter/material.dart';

class UpdateMonitor extends StatefulWidget {
  const UpdateMonitor({super.key});

  @override
  State<UpdateMonitor> createState() => _UpdateMonitorState();
}

class _UpdateMonitorState extends State<UpdateMonitor> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Column(
          children: [
            Center(child: Text('Update Monitor')),
          ],
        ),
      ),
    );
  }
}
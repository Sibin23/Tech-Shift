import 'package:flutter/material.dart';

class UpdateSsd extends StatefulWidget {
  const UpdateSsd({super.key});

  @override
  State<UpdateSsd> createState() => _UpdateSsdState();
}

class _UpdateSsdState extends State<UpdateSsd> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Column(
          children: [
            Center(child: Text('Update SSD')),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class UpdateMouse extends StatefulWidget {
  const UpdateMouse({super.key});

  @override
  State<UpdateMouse> createState() => _UpdateMouseState();
}

class _UpdateMouseState extends State<UpdateMouse> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Column(
          children: [
            Center(child: Text('Update Mouse')),
          ],
        ),
      ),
    );
  }
}
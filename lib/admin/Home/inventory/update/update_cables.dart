import 'package:flutter/material.dart';

class UpdateCable extends StatefulWidget {
  const UpdateCable({super.key});

  @override
  State<UpdateCable> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UpdateCable> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Column(
          children: [
            Center(child: Text('Update Cable')),
          ],
        ),
      ),
    );
  }
}
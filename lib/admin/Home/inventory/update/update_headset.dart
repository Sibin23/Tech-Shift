import 'package:flutter/material.dart';

class UpdateHeadset extends StatefulWidget {
  const UpdateHeadset({super.key});

  @override
  State<UpdateHeadset> createState() => _UpdateHeadsetState();
}

class _UpdateHeadsetState extends State<UpdateHeadset> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Column(
          children: [
            Center(child: Text('Update Headset')),
          ],
        ),
      ),
    );
  }
}
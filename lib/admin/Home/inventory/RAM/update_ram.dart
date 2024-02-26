import 'package:flutter/material.dart';

class UpdateRam extends StatefulWidget {
  const UpdateRam({super.key});

  @override
  State<UpdateRam> createState() => _UpdateRamState();
}

class _UpdateRamState extends State<UpdateRam> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Column(
          children: [
            Center(child: Text('Update RAM')),
          ],
        ),
      ),
    );
  }
}
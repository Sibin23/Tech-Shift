import 'package:flutter/material.dart';

class UpdateCooler extends StatefulWidget {
  const UpdateCooler({super.key});

  @override
  State<UpdateCooler> createState() => _UpdateCoolerState();
}

class _UpdateCoolerState extends State<UpdateCooler> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Column(
          children: [
            Center(child: Text('Update Cooler')),
          ],
        ),
      ),
    );
  }
}
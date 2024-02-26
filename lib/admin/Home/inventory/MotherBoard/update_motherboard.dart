import 'package:flutter/material.dart';

class UpdateMotherboard extends StatefulWidget {
  const UpdateMotherboard({super.key});

  @override
  State<UpdateMotherboard> createState() => _UpdateMotherboardState();
}

class _UpdateMotherboardState extends State<UpdateMotherboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Column(
          children: [
            Center(child: Text('Update MotherBoard')),
          ],
        ),
      ),
    );
  }
}
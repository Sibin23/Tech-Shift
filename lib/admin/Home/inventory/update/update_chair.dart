import 'package:flutter/material.dart';

class UpdateChair extends StatefulWidget {
  const UpdateChair({super.key});

  @override
  State<UpdateChair> createState() => _UpdateChairState();
}

class _UpdateChairState extends State<UpdateChair> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Column(
          children: [
            Center(child: Text('Update Chair')),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class UpdatePsu extends StatefulWidget {
  final String itemId;
  const UpdatePsu({super.key,required this.itemId});

  @override
  State<UpdatePsu> createState() => _UpdatePsuState();
}

class _UpdatePsuState extends State<UpdatePsu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Column(
          children: [
            Center(child: Text('Update PSU')),
          ],
        ),
      ),
    );
  }
}
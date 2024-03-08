import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/widget2.dart';

class CabinetConfig extends StatefulWidget {
  final Map<String,dynamic> config;
  const CabinetConfig({super.key, required this.config});

  @override
  State<CabinetConfig> createState() => _CabinetConfigState();
}

class _CabinetConfigState extends State<CabinetConfig> {
  @override
  Widget build(BuildContext context) {
    print(widget.config);
    return Scaffold(
      bottomNavigationBar: UiCustom.bottomNextButton(context, () {
        Navigator.pop(context);
      }, () { }, amt: '7777'),
      body: SafeArea(child: Center(child:Text('Cabinet'),)),
    );
  }
}
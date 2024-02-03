import 'package:flutter/material.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class ScreenInventory extends StatefulWidget {
  const ScreenInventory({super.key});

  @override
  State<ScreenInventory> createState() => _ScreenInventoryState();
}

class _ScreenInventoryState extends State<ScreenInventory> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.appTheme,
        title: Text('Add Inventory',style: CustomText.apptitle,),
      ),
      body: ,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class ScreenUpdateItems extends StatefulWidget {
  const ScreenUpdateItems({super.key});

  @override
  State<ScreenUpdateItems> createState() => _ScreenUpdateItemsState();
}

class _ScreenUpdateItemsState extends State<ScreenUpdateItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.appTheme,
        title: Text('Update Inventory', style: CustomText.apptitle,),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
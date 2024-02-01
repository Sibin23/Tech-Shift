import 'package:flutter/material.dart';
import 'package:prosample_1/admin/utils/common_widgets.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
      
        child: Column(
          children: [
            Row(
              children: [
              AdminUi.customCard(Icons.add,context, 'Add Items'),
              AdminUi.customCard(Icons.upload_rounded, context, 'Update Items'),
              ],
            ),
            Row(
              children: [
                AdminUi.customCard(Icons.layers_sharp, context,'Add Category'),
                AdminUi.customCard(Icons.ad_units_outlined,context, 'Add Promotions')
              ],
            )
          ],
        ),
      ),
    );
  }
}

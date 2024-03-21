import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/colors.dart';

class Cabinetinfo2 extends StatefulWidget {
  final Map<String,dynamic> cabinet;
  const Cabinetinfo2({super.key, required this.cabinet});

  @override
  State<Cabinetinfo2> createState() => _Cabinetinfo2State();
}

class _Cabinetinfo2State extends State<Cabinetinfo2> {
  @override
  Widget build(BuildContext context) {
    final cab = widget.cabinet;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
            Navigator.pop(context); 
          }, icon: Icon(Icons.close,color: AppColors.appTheme)),
      ),
      body: SafeArea(child: Column(children: [
      Text(cab['name'])
    ],),),);
  }
}
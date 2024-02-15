import 'package:flutter/material.dart';
import 'package:prosample_1/admin/Home/inventory/update/update_Psu.dart';
import 'package:prosample_1/admin/Home/inventory/update/update_cabinet.dart';
import 'package:prosample_1/admin/Home/inventory/update/update_cables.dart';
import 'package:prosample_1/admin/Home/inventory/update/update_chair.dart';
import 'package:prosample_1/admin/Home/inventory/update/update_cooler.dart';
import 'package:prosample_1/admin/Home/inventory/update/update_headset.dart';
import 'package:prosample_1/admin/Home/inventory/update/update_keyboard.dart';
import 'package:prosample_1/admin/Home/inventory/update/update_monitor.dart';
import 'package:prosample_1/admin/Home/inventory/update/update_motherboard.dart';
import 'package:prosample_1/admin/Home/inventory/update/update_mouse.dart';
import 'package:prosample_1/admin/Home/inventory/update/update_processor.dart';
import 'package:prosample_1/admin/Home/inventory/update/update_ram.dart';
import 'package:prosample_1/admin/Home/inventory/update/update_ssd.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class UpdateItem extends StatefulWidget {
  const UpdateItem({super.key});

  @override
  State<UpdateItem> createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {
  static const List<String> categorylist = <String>[
    'Cabinet',
    'Cables',
    'Chair',
    'Cooler',
    'Headset',
    'Keyboard',
    'Monitor',
    'MotherBoard',
    'Mouse',
    'Processor',
    'PSU',
    'RAM',
    'SSD',
  ];
  Widget? bodyContent;
  _UpdateItemState() {
    bodyContent = const UpdateCabinet();
  }

  String bodyIndex = '';

  Widget buildBodyContentForCategory(String category) {
    switch (category) {
      case 'Cabinet':
        return const UpdateCabinet(); // Replace with your actual widget
      case 'Cables':
        return const UpdateCable();
      case 'Chair':
        return const UpdateChair();
      case 'Cooler':
        return const UpdateCooler();
      case 'Headset':
        return const UpdateHeadset();
      case 'Keyboard':
        return const UpdateKeyboard();
      case 'Monitor':
        return const UpdateMonitor();
      case 'MotherBoard':
        return const UpdateMotherboard();
      case 'Mouse':
        return const UpdateMouse();
      case 'Processor':
        return const UpdateProcessor();
      case 'PSU':
        return const UpdatePsu();
      case 'RAM':
        return const UpdateRam();
      case 'SSD':
        return const UpdateSsd();
      default:
        return const UpdateCabinet(); 
    }
  }

  String categorydropdownvalue = categorylist.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(backgroundColor: CustomColors.appTheme, actions: [
            DropdownMenu<String>(
              hintText: 'Select Category',
              textStyle: CustomText.categoryTitleText,
              width: MediaQuery.of(context).size.width * .7,
              menuHeight: 300,
              inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0)),
                  fillColor: Colors.white,
                  filled: true),
              onSelected: (value) {
                setState(() {
                  categorydropdownvalue = value!;
                  bodyIndex = value;
                  bodyContent = buildBodyContentForCategory(bodyIndex);
                });
              },
              dropdownMenuEntries:
                  categorylist.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
          ] 
              ),
        ),
        body: bodyContent);
  }
}

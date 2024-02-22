import 'package:flutter/material.dart';
import 'package:prosample_1/admin/Home/inventory/add%20inventory/add_cabinet.dart';
import 'package:prosample_1/admin/Home/inventory/add%20inventory/add_cables.dart';
import 'package:prosample_1/admin/Home/inventory/add%20inventory/add_chair.dart';
import 'package:prosample_1/admin/Home/inventory/add%20inventory/add_coolers.dart';
import 'package:prosample_1/admin/Home/inventory/add%20inventory/add_headset.dart';
import 'package:prosample_1/admin/Home/inventory/add%20inventory/add_keyboard.dart';
import 'package:prosample_1/admin/Home/inventory/add%20inventory/add_monitor.dart';
import 'package:prosample_1/admin/Home/inventory/add%20inventory/add_motherboard.dart';
import 'package:prosample_1/admin/Home/inventory/add%20inventory/add_mouse.dart';
import 'package:prosample_1/admin/Home/inventory/add%20inventory/add_processor.dart';
import 'package:prosample_1/admin/Home/inventory/add%20inventory/add_psu.dart';
import 'package:prosample_1/admin/Home/inventory/add%20inventory/add_ram.dart';
import 'package:prosample_1/admin/Home/inventory/add%20inventory/add_ssd.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class ScreenItemDetails extends StatefulWidget {
  const ScreenItemDetails({super.key});

  @override
  State<ScreenItemDetails> createState() => _ScreenItemDetailsState();
}

class _ScreenItemDetailsState extends State<ScreenItemDetails> {
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
  _ScreenItemDetailsState() {
    bodyContent = const ScreenAddCabinet();
  }
  String bodyIndex = '';

  Widget buildBodyContentForCategory(String category) {
    switch (category) {
      case 'Cabinet':
        return const ScreenAddCabinet(); // Replace with your actual widget
      case 'Cables':
        return const ScreenAddCables();
      case 'Chair':
        return const ScreenAddChairs();
      case 'Cooler':
        return const ScreenAddCoolers();
      case 'Headset':
        return const ScreenAddHeadset();
      case 'Keyboard':
       return const ScreenAddKeyboard();
      case 'Monitor':
       return const ScreenAddMonitor();
      case 'MotherBoard':
       return const ScreenAddMotherboard();
      case 'Mouse':
       return const ScreenAddMouse();
      case 'Processor':
       return const ScreenAddProcessor();
      case 'PSU':
       return const ScreenAddPsu();
      case 'RAM':
       return const ScreenAddRam();
      case 'SSD':
       return const ScreenAddSsd();
      default:
        return const ScreenAddCabinet(); // Or a generic "Not Found" widget
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
          ] // Update based on selected option (optional)
              ),
        ),
        body: bodyContent);
  }
}

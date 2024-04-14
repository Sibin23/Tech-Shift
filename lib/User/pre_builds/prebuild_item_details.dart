import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget4.dart';
import 'package:prosample_1/admin/const/variables.dart';

class ScreenPrebuildInfo extends StatelessWidget {
  final Map<String, dynamic> pc;
  const ScreenPrebuildInfo({super.key, required this.pc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          surfaceTintColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: AppColors.appTheme,
              ))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              decoration:
                  const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4.0,
                    spreadRadius: 2.0,
                    offset: Offset(4, 4))
              ]),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Specifications', style: TextStyling.detailMain),
                    h30,
                    Custom3.details(context,
                        title: 'Category', detail: pc[category]),
                    h10,
                    Custom3.details(context,
                        title: 'Cabinet', detail: pc[cabinet]),
                    h10,
                    Custom3.details(context,
                        title: 'Processor', detail: pc[processor]),
                    h10,
                    Custom3.details(context,
                        title: 'Motherboard', detail: pc[motherboard]),
                    h10,
                    Custom3.details(context,
                        title: 'RAM (Memory)', detail: pc[ram]),
                    h10,
                    Custom3.details(context,
                        title: 'SSD (Storage)', detail: pc[ssd]),
                    h10,
                    Custom3.details(context,
                        title: 'Expandable', detail: pc[expStorage]),
                    h10,
                    Custom3.details(context,
                        title: 'Graphics Card', detail: pc[gpu]),
                    h10,
                    Custom3.details(context,
                        title: 'Features', detail: pc[features]),
                    h10,
                    Custom3.details(context,
                        title: 'CPU Cooler', detail: pc[cooler]),
                    h10,
                    Custom3.details(context, title: 'PSU', detail: pc[psu]),
                    h10,
                    Custom3.details(context,
                        title: 'Warranty', detail: pc[warranty]),
                    h10,
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

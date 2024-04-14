import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget4.dart';
import 'package:prosample_1/admin/const/variables.dart';

class ScreenRamInfo extends StatefulWidget {
  final Map<String, dynamic> ram;
  const ScreenRamInfo({super.key, required this.ram});

  @override
  State<ScreenRamInfo> createState() => _ScreenRamInfoState();
}

class _ScreenRamInfoState extends State<ScreenRamInfo> {
  @override
  Widget build(BuildContext context) {
    final ram = widget.ram;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Product Details', style: TextStyling.appTitle),
        surfaceTintColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close, color: AppColors.appTheme)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Container(
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
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
                        title: 'Product Name', detail: ram[name]),
                    h10,
                    Custom3.details(context,
                        title: 'Model Name', detail: ram[model]),
                    h10,
                    Custom3.details(context,
                        title: 'Manufacturer', detail: ram[manufacturer]),
                    h10,
                    Custom3.details(context,
                        title: 'RAM Type', detail: ram[ramType]),
                    h10,
                    Custom3.details(context,
                        title: 'RAM Size', detail: ram[ramSize]),
                    h10,
                    Custom3.details(context,
                        title: 'Clock Speed', detail: ram[speed]),
                    h10,
                    Custom3.details(context,
                        title: 'Form Factor', detail: ram[formFactor]),
                    h10,
                    Custom3.details(context,
                        title: 'Product Dimension', detail: ram[dimension]),
                    h10,
                    Custom3.details(context,
                        title: 'Country', detail: ram[country]),
                    h10,
                    Custom3.details(context,
                        title: 'Item Weight', detail: ram[weight]),
                    h10,
                    Custom3.details(context,
                        title: 'Warranty', detail: ram[warranty]),
                    h10,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

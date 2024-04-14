import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget4.dart';
import 'package:prosample_1/admin/const/variables.dart';

class ScreenCableInfo extends StatefulWidget {
  final Map<String, dynamic> cable;
  const ScreenCableInfo({super.key, required this.cable});

  @override
  State<ScreenCableInfo> createState() => _ScreenCableInfoState();
}

class _ScreenCableInfoState extends State<ScreenCableInfo> {
  @override
  Widget build(BuildContext context) {
    final cable = widget.cable;
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
            padding: const EdgeInsets.all(16.0),
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
                    Text('General', style: TextStyling.subtitle3),
                    h10,
                    Custom3.details(context,
                        title: 'Product Name', detail: cable[name]),
                    h10,
                    Custom3.details(context,
                        title: 'Model Name', detail: cable[model]),
                    h10,
                    Custom3.details(context,
                        title: 'Manufacturer', detail: cable[manufacturer]),
                    h10,
                    Custom3.details(context,
                        title: 'Colour', detail: cable[color]),
                    h10,
                    Custom3.details(context,
                        title: 'Speed', detail: cable[speed]),
                    h10,
                    Custom3.details(context,
                        title: 'No. of Pins', detail: cable[pins]),
                    h10,
                    Custom3.details(context,
                        title: 'Voltage', detail: cable[voltage]),
                    h10,
                    Custom3.details(context,
                        title: 'Wattage', detail: cable[wattage]),
                    h10,
                    Custom3.details(context,
                        title: 'Product Dimension', detail: cable[dimension]),
                    h10,
                    Custom3.details(context,
                        title: 'Country of Origin', detail: cable[country]),
                    h10,
                    Custom3.details(context,
                        title: 'Item Weight', detail: cable[weight]),
                    h10,
                    Custom3.details(context,
                        title: 'Warranty', detail: cable[warranty]),
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

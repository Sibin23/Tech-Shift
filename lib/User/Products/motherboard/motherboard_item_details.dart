import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget4.dart';
import 'package:prosample_1/admin/const/variables.dart';

class ScreenMotherboardInfo extends StatefulWidget {
  final Map<String, dynamic> board;
  const ScreenMotherboardInfo({super.key, required this.board});

  @override
  State<ScreenMotherboardInfo> createState() => _ScreenMotherboardInfoState();
}

class _ScreenMotherboardInfoState extends State<ScreenMotherboardInfo> {
  @override
  Widget build(BuildContext context) {
    final board = widget.board;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Text('Product Details', style: TextStyling.appTitle),
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
                    Custom3.details(context,
                        title: "Product Name", detail: board[name]),
                    h10,
                    Custom3.details(context,
                        title: "Model Name", detail: board[model]),
                    h10,
                    Custom3.details(context,
                        title: "Manufacturer", detail: board[manufacturer]),
                    h10,
                    Custom3.details(context,
                        title: "Form Factor", detail: board[formFactor]),
                    h10,
                    Custom3.details(context,
                        title: "Memory Clock Speed", detail: board[maxClock]),
                    h10,
                    Custom3.details(context,
                        title: "Socket Support", detail: board[cpuSocket]),
                    h10,
                    Custom3.details(context,
                        title: "RAM Type", detail: board[ramType]),
                    h10,
                    Custom3.details(context,
                        title: "Maximum Memory Support",
                        detail: '${board[ramSize]} Gb'),
                    h10,
                    Custom3.details(context,
                        title: "RAM Slots", detail: board[ramSlots]),
                    h10,
                    Custom3.details(context,
                        title: "SSD Type", detail: board[ssdType]),
                    h10,
                    Custom3.details(context,
                        title: "SSD Slots", detail: board[ssdSlots]),
                    h10,
                    Custom3.details(context,
                        title: "Wattage", detail: board[wattage]),
                    h10,
                    Custom3.details(context,
                        title: "Ports", detail: board[ports]),
                    h10,
                    Custom3.details(context,
                        title: "Features", detail: board[features]),
                    h10,
                    Custom3.details(context,
                        title: "Product Dimensions", detail: board[dimension]),
                    h10,
                    Custom3.details(context,
                        title: "Country of Origin", detail: board[country]),
                    h10,
                    Custom3.details(context,
                        title: "Item Weight", detail: board[weight]),
                    h10,
                    Custom3.details(context,
                        title: "Warranty", detail: board[warranty]),
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

import 'package:flutter/material.dart';

import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget4.dart';
import 'package:prosample_1/admin/const/variables.dart';

class ScreenChairInfo extends StatefulWidget {
  final Map<String, dynamic> chair;
  const ScreenChairInfo({super.key, required this.chair});

  @override
  State<ScreenChairInfo> createState() => _ScreenChairInfoState();
}

class _ScreenChairInfoState extends State<ScreenChairInfo> {
  @override
  Widget build(BuildContext context) {
    final chair = widget.chair;
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
                    Custom3.details(context,
                        title: 'Product Name', detail: chair[name]),
                    h10,
                    Custom3.details(context,
                        title: 'Model Name', detail: chair[model]),
                    h10,
                    Custom3.details(context,
                        title: 'Manufacturer', detail: chair[manufacturer]),
                    h10,
                    Custom3.details(context,
                        title: 'Colour', detail: chair[color]),
                    h10,
                    Custom3.details(context,
                        title: 'Materail', detail: chair[material]),
                    h10,
                    Custom3.details(context,
                        title: 'Fill Material', detail: chair[fillMaterial]),
                    h10,
                    Custom3.details(context,
                        title: 'Features', detail: chair[features]),
                    h10,
                    Custom3.details(context,
                        title: 'Item Weight', detail: chair[weight]),
                    h10,
                    Custom3.details(context,
                        title: 'Product Dimension', detail: chair[dimension]),
                    h10,
                    Custom3.details(context,
                        title: 'Country of Origin', detail: chair[country]),
                    h10,
                    Custom3.details(context,
                        title: 'Warranty', detail: chair[warranty]),
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

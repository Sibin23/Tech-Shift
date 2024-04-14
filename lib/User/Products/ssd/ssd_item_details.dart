import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget4.dart';
import 'package:prosample_1/admin/const/variables.dart';

class ScreenSsdInfo extends StatefulWidget {
  final Map<String, dynamic> ssd;
  const ScreenSsdInfo({super.key, required this.ssd});

  @override
  State<ScreenSsdInfo> createState() => _ScreenSsdInfoState();
}

class _ScreenSsdInfoState extends State<ScreenSsdInfo> {
  @override
  Widget build(BuildContext context) {
    final ssd = widget.ssd;
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
                        title: 'Product Name', detail: ssd[name]),
                    h10,
                    Custom3.details(context,
                        title: 'Model Name', detail: ssd[model]),
                    h10,
                    Custom3.details(context,
                        title: 'Manufacturer', detail: ssd[manufacturer]),
                    h10,
                    Custom3.details(context,
                        title: 'Form Factor', detail: ssd[formFactor]),
                    h10,
                    Custom3.details(context,
                        title: 'Gen Type', detail: ssd[genType]),
                    h10,
                    Custom3.details(context,
                        title: 'Interface', detail: ssd[hdwinterface]),
                    h10,
                    Custom3.details(context,
                        title: 'Storage', detail: ssd[storage]),
                    h10,
                    Custom3.details(context,
                        title: 'Transfer Speed', detail: ssd[speed]),
                    h10,
                    Custom3.details(context,
                        title: 'Wattage', detail: '${ssd[wattage]} W'),
                    h10,
                    Custom3.details(context,
                        title: 'Connectivity', detail: ssd[connectivity]),
                    h10,
                    Custom3.details(context,
                        title: 'Product Dimensions', detail: ssd[dimension]),
                    h10,
                    Custom3.details(context,
                        title: 'Country of Origin', detail: ssd[country]),
                    h10,
                    Custom3.details(context,
                        title: 'Item Weight', detail: ssd[weight]),
                    h10,
                    Custom3.details(context,
                        title: 'Warranty', detail: ssd[warranty]),
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

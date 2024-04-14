import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget4.dart';
import 'package:prosample_1/admin/const/variables.dart';

class ScreenMonitorInfo extends StatefulWidget {
  final Map<String, dynamic> monitor;
  const ScreenMonitorInfo({super.key, required this.monitor});

  @override
  State<ScreenMonitorInfo> createState() => _ScreenMonitorInfoState();
}

class _ScreenMonitorInfoState extends State<ScreenMonitorInfo> {
  @override
  Widget build(BuildContext context) {
    final monitor = widget.monitor;
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
                        title: 'Product Name', detail: monitor[name]),
                    h10,
                    Custom3.details(context,
                        title: 'Model Name', detail: monitor[model]),
                    h10,
                    Custom3.details(context,
                        title: 'Manufacturer', detail: monitor[manufacturer]),
                    h10,
                    Custom3.details(context,
                        title: 'Features', detail: monitor[features]),
                    h10,
                    Custom3.details(context,
                        title: 'Display Type', detail: monitor[displayType]),
                    h10,
                    Custom3.details(context,
                        title: 'Display Size', detail: monitor[displaySize]),
                    h10,
                    Custom3.details(context,
                        title: 'Screen Resolution', detail: monitor[resolution]),
                    h10,
                    Custom3.details(context,
                        title: 'Refresh Rate', detail: monitor[refRate]),
                    h10,
                    Custom3.details(context,
                        title: 'Response', detail: monitor[response]),
                    h10,
                    Custom3.details(context,
                        title: 'View Angle', detail: monitor[viewAngle]),
                    h10,
                    Custom3.details(context,
                        title: 'Hardware Interface',
                        detail: monitor[hdwinterface]),
                    h10,
                    Custom3.details(context,
                        title: 'Voltage', detail: monitor[voltage]),
                    h10,
                    Custom3.details(context,
                        title: 'Product Dimension', detail: monitor[dimension]),
                    h10,
                    Custom3.details(context,
                        title: 'Item Weight', detail: monitor[weight]),
                    h10,
                    Custom3.details(context,
                        title: 'Country of Origin', detail: monitor[country]),
                    h10,
                    Custom3.details(context,
                        title: 'Warranty', detail: monitor[warranty]),
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

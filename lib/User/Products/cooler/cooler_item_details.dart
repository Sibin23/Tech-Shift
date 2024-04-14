import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget4.dart';
import 'package:prosample_1/admin/const/variables.dart';

class ScreenCoolerInfo extends StatefulWidget {
  final Map<String, dynamic> cooler;
  const ScreenCoolerInfo({super.key, required this.cooler});

  @override
  State<ScreenCoolerInfo> createState() => _ScreenCoolerInfoState();
}

class _ScreenCoolerInfoState extends State<ScreenCoolerInfo> {
  @override
  Widget build(BuildContext context) {
    final cooler = widget.cooler;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Product Detials', style: TextStyling.appTitle),
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
                        title: "Product Name", detail: cooler[name]),
                    h10,
                    Custom3.details(context,
                        title: "Manufacturer", detail: cooler[manufacturer]),
                    h10,
                    Custom3.details(context,
                        title: "Material", detail: cooler[material]),
                    h10,
                    Custom3.details(context,
                        title: "Total Fans", detail: cooler[fancount]),
                    h10,
                    Custom3.details(context,
                        title: "Cooling Type", detail: cooler[cooling]),
                    h10,
                    Custom3.details(context,
                        title: "Connectivity", detail: cooler[connectivity]),
                    h10,
                    Custom3.details(context,
                        title: "Voltage", detail: cooler[voltage]),
                    h10,
                    Custom3.details(context,
                        title: "Wattage", detail: '${cooler[wattage]} W'),
                    h10,
                    Custom3.details(context,
                        title: "Features", detail: cooler[features]),
                    h10,
                    Custom3.details(context,
                        title: "Noise Level", detail: cooler[noise]),
                    h10,
                    Custom3.details(context,
                        title: "Rotaional Speed", detail: cooler[speed]),
                    h10,
                    Custom3.details(context,
                        title: "Cooler Size", detail: cooler[fansize]),
                    h10,
                    Custom3.details(context,
                        title: "Item Weight", detail: cooler[weight]),
                    h10,
                    Custom3.details(context,
                        title: "Product Dimension", detail: cooler[dimension]),
                    h10,
                    Custom3.details(context,
                        title: "Country of Origin", detail: cooler[country]),
                    h10,
                    Custom3.details(context,
                        title: "Warranty", detail: cooler[warranty]),
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

import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget4.dart';
import 'package:prosample_1/admin/const/variables.dart';

class ScreenPsuInfo extends StatefulWidget {
  final Map<String, dynamic> psu;
  const ScreenPsuInfo({super.key, required this.psu});

  @override
  State<ScreenPsuInfo> createState() => _ScreenPsuInfoState();
}

class _ScreenPsuInfoState extends State<ScreenPsuInfo> {
  @override
  Widget build(BuildContext context) {
    final psu = widget.psu;
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
                        title: 'Product Name', detail: psu[name]),
                    h10,
                    Custom3.details(context,
                        title: 'Model Name', detail: psu[model]),
                    h10,
                    Custom3.details(context,
                        title: 'Manufacturer', detail: psu[manufacturer]),
                    h10,
                    Custom3.details(context,
                        title: 'Cooling Method', detail: psu[coolingMethod]),
                    h10,
                    Custom3.details(context,
                        title: 'Form Factor', detail: psu[formFactor]),
                    h10,
                    Custom3.details(context,
                        title: 'Wattage', detail: '${psu[wattage]} W'),
                    h10,
                    Custom3.details(context,
                        title: 'Features', detail: psu[features]),
                    h10,
                    Custom3.details(context,
                        title: 'Product Dimension', detail: psu[dimension]),
                    h10,
                    Custom3.details(context,
                        title: 'Country of Origin', detail: psu[country]),
                    h10,
                    Custom3.details(context,
                        title: 'item Weight', detail: psu[weight]),
                    h10,
                    Custom3.details(context,
                        title: 'Warranty', detail: psu[warranty]),
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

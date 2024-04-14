import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget4.dart';
import 'package:prosample_1/admin/const/variables.dart';

class ScreenHeadsetsInfo extends StatefulWidget {
  final Map<String, dynamic> headset;
  const ScreenHeadsetsInfo({super.key, required this.headset});

  @override
  State<ScreenHeadsetsInfo> createState() => _ScreenHeadsetsInfoState();
}

class _ScreenHeadsetsInfoState extends State<ScreenHeadsetsInfo> {
  @override
  Widget build(BuildContext context) {
    final headset = widget.headset;
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
                        title: 'Product Name', detail: headset[name]),
                    h10,
                    Custom3.details(context,
                        title: 'Model Name', detail: headset[model]),
                    h10,
                    Custom3.details(context,
                        title: 'Series', detail: headset[series]),
                    h10,
                    Custom3.details(context,
                        title: 'Manufacutrer', detail: headset[manufacturer]),
                    h10,
                    Custom3.details(context,
                        title: 'Colour', detail: headset[color]),
                    h10,
                    Custom3.details(context,
                        title: 'Connectivity', detail: headset[connectivity]),
                    h10,
                    Custom3.details(context,
                        title: 'Features', detail: headset[features]),
                    h10,
                    Custom3.details(context,
                        title: 'Sound Features',
                        detail: headset[soundFeatures]),
                    h10,
                    Custom3.details(context,
                        title: 'Product Dimensions',
                        detail: headset[dimension]),
                    h10,
                    Custom3.details(context,
                        title: 'Item Weight', detail: headset[weight]),
                    h10,
                    Custom3.details(context,
                        title: 'Country', detail: headset[country]),
                    h10,
                    Custom3.details(context,
                        title: 'Warranty', detail: headset[warranty]),
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

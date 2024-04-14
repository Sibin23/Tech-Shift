import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget4.dart';
import 'package:prosample_1/admin/const/variables.dart';

class ScreenKeyboardInfo extends StatefulWidget {
  final Map<String, dynamic> keyboard;
  const ScreenKeyboardInfo({super.key, required this.keyboard});

  @override
  State<ScreenKeyboardInfo> createState() => _ScreenKeyboardInfoState();
}

class _ScreenKeyboardInfoState extends State<ScreenKeyboardInfo> {
  @override
  Widget build(BuildContext context) {
    final keyboard = widget.keyboard;
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
                        title: "Product Name", detail: keyboard[name]),
                    h10,
                    Custom3.details(context,
                        title: "Model Name", detail: keyboard[model]),
                    h10,
                    Custom3.details(context,
                        title: "Manufacturer", detail: keyboard[manufacturer]),
                    h10,
                    Custom3.details(context,
                        title: "Material", detail: keyboard[material]),
                    h10,
                    Custom3.details(context,
                        title: "Connectivity", detail: keyboard[connectivity]),
                    h10,
                    Custom3.details(context,
                        title: "Features", detail: keyboard[features]),
                    h10,
                    Custom3.details(context,
                        title: "Product Dimensions", detail: keyboard[dimension]),
                    h10,
                    Custom3.details(context,
                        title: "Item Weight", detail: keyboard[weight]),
                    h10,
                    Custom3.details(context,
                        title: "Country of Origin", detail: keyboard[country]),
                    h10,
                    Custom3.details(context,
                        title: "Warranty", detail: keyboard[warranty]),
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

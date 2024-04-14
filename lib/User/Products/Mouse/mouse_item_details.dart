import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget4.dart';
import 'package:prosample_1/admin/const/variables.dart';

class ScreenMouseInfo extends StatefulWidget {
  final Map<String, dynamic> mouse;
  const ScreenMouseInfo({super.key, required this.mouse});

  @override
  State<ScreenMouseInfo> createState() => _ScreenMouseInfoState();
}

class _ScreenMouseInfoState extends State<ScreenMouseInfo> {
  @override
  Widget build(BuildContext context) {
    final mouse = widget.mouse;
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
                        title: 'Product Name', detail: mouse[name]),
                    h10,
                    Custom3.details(context,
                        title: 'Model Name', detail: mouse[model]),
                    h10,
                    Custom3.details(context,
                        title: 'Manufacturer', detail: mouse[manufacturer]),
                    h10,
                    Custom3.details(context,
                        title: 'Series', detail: mouse[series]),
                    h10,
                    Custom3.details(context,
                        title: 'Colour', detail: mouse[color]),
                    h10,
                    Custom3.details(context,
                        title: 'Connectivity', detail: mouse[connectivity]),
                    h10,
                    Custom3.details(context, title: 'DPI', detail: mouse[dpi]),
                    h10,
                    Custom3.details(context,
                        title: 'Features', detail: mouse[features]),
                    h10,
                    Custom3.details(context,
                        title: 'Total Buttons', detail: mouse[buttons]),
                    h10,
                    Custom3.details(context,
                        title: 'Product Dimensions', detail: mouse[dimension]),
                    h10,
                    Custom3.details(context,
                        title: 'Country of Origin', detail: mouse[country]),
                    h10,
                    Custom3.details(context,
                        title: 'Item Weight', detail: mouse[weight]),
                    h10,
                    Custom3.details(context,
                        title: 'Warranty', detail: mouse[warranty]),
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

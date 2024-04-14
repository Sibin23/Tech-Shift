import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget4.dart';
import 'package:prosample_1/admin/const/variables.dart';

class ScreenGpuInfo extends StatefulWidget {
  final Map<String, dynamic> gpu;
  const ScreenGpuInfo({super.key, required this.gpu});

  @override
  State<ScreenGpuInfo> createState() => _ScreenGpuInfoState();
}

class _ScreenGpuInfoState extends State<ScreenGpuInfo> {
  @override
  Widget build(BuildContext context) {
    final gpu = widget.gpu;
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
                        title: 'Product Name', detail: gpu[name]),
                    h10,
                    Custom3.details(context,
                        title: 'Model Name', detail: gpu[model]),
                    h10,
                    Custom3.details(context,
                        title: 'Manufacturer', detail: gpu[manufacturer]),
                    h10,
                    Custom3.details(context, title: 'Colour', detail: gpu[color]),
                    h10,
                    Custom3.details(context,
                        title: 'Features', detail: gpu[features]),
                    h10,
                    Custom3.details(context,
                        title: 'Maximum Resoluion', detail: gpu[maxResolution]),
                    h10,
                    Custom3.details(context,
                        title: 'Graphics Ram Type', detail: gpu[ramType]),
                    h10,
                    Custom3.details(context,
                        title: 'Graphics Ram Size', detail: gpu[ramSize]),
                    h10,
                    Custom3.details(context,
                        title: 'Memory Clock Speed', detail: gpu[speed]),
                    h10,
                    Custom3.details(context,
                        title: 'Card Interface', detail: gpu[support]),
                    h10,
                    Custom3.details(context,
                        title: 'Wattage', detail: gpu[wattage]),
                    h10,
                    Custom3.details(context,
                        title: 'Product Dimension', detail: gpu[dimension]),
                    h10,
                    Custom3.details(context,
                        title: 'Item Weight', detail: gpu[weight]),
                    h10,
                    Custom3.details(context,
                        title: 'Country of Origin', detail: gpu[country]),
                    h10,
                    Custom3.details(context,
                        title: 'Warranty', detail: gpu[warranty]),
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

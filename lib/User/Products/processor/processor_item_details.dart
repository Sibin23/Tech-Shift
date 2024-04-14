import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget4.dart';
import 'package:prosample_1/admin/const/variables.dart';

class ScreenProcessorInfo extends StatefulWidget {
  final Map<String, dynamic> cpu;
  const ScreenProcessorInfo({super.key, required this.cpu});

  @override
  State<ScreenProcessorInfo> createState() => _ScreenProcessorInfoState();
}

class _ScreenProcessorInfoState extends State<ScreenProcessorInfo> {
  @override
  Widget build(BuildContext context) {
    final cpu = widget.cpu;
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
                        title: 'Product Name', detail: cpu[name]),
                    h10,
                    Custom3.details(context,
                        title: 'Manufacturer', detail: cpu[manufacturer]),
                    h10,
                    Custom3.details(context,
                        title: 'Socket', detail: cpu[socket]),
                    h10,
                    Custom3.details(context,
                        title: 'Cores', detail: cpu[cores]),
                    h10,
                    Custom3.details(context,
                        title: 'Threads', detail: cpu[threads]),
                    h10,
                    Custom3.details(context,
                        title: 'Cache Memory', detail: cpu[cache]),
                    h10,
                    Custom3.details(context,
                        title: 'Clock Speed', detail: cpu[speed]),
                    h10,
                    Custom3.details(context, title: 'TDP', detail: cpu[tdp]),
                    h10,
                    Custom3.details(context,
                        title: 'Integrated Graphics', detail: cpu[graphics]),
                    h10,
                    Custom3.details(context,
                        title: 'Cooler', detail: cpu[integratedCooler]),
                    h10,
                    Custom3.details(context,
                        title: 'Unlocked', detail: cpu[unlocked]),
                    h10,
                    Custom3.details(context,
                        title: 'Product Dimension', detail: cpu[dimension]),
                    h10,
                    Custom3.details(context,
                        title: 'Country of Origin', detail: cpu[country]),
                    h10,
                    Custom3.details(context,
                        title: 'Item Weight', detail: cpu[weight]),
                    h10,
                    Custom3.details(context,
                        title: 'Warranty', detail: cpu[warranty]),
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

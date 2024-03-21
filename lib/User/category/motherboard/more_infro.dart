import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/Text_decorations.dart';
import 'package:prosample_1/User/utils/colors.dart';

class MotherboardInfo2 extends StatefulWidget {
  final Map<String, dynamic> itemInfo;
  const MotherboardInfo2({super.key, required this.itemInfo});

  @override
  State<MotherboardInfo2> createState() => _MotherboardInfo2State();
}

class _MotherboardInfo2State extends State<MotherboardInfo2> {
  @override
  Widget build(BuildContext context) {
    final item = widget.itemInfo;
    const space = SizedBox(height: 10);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close, color: AppColors.appTheme),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Product Name', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(item['name'], style: TextStyling.subtitle),
              space,
              Text('Model Name', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(item['model'], style: TextStyling.subtitle),
              space,
              Text('Manufacturer', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(item['manufacturer'], style: TextStyling.subtitle),
              space,
              Text('Processor Socket', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(item['processorsocket'], style: TextStyling.subtitle),
              space,
              Text('RAM Type', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(item['ramType'], style: TextStyling.subtitle),
              space,
              Text('RAM Size', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(item['ramsize'], style: TextStyling.subtitle),
              space,
              Text('RAM Slots', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(item['ramslots'], style: TextStyling.subtitle),
              space,
              Text('Storage Type', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(item['ssdtype'], style: TextStyling.subtitle),
              space,
              Text('Storage Slots', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(item['ssdslots'], style: TextStyling.subtitle),
              space,
              Text('Product Dimensions', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(item['productdimension'], style: TextStyling.subtitle),
              space,
              Text('Product Features', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(item['features'], style: TextStyling.subtitle),
              space,
              Text('Wattage', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(item['wattage'], style: TextStyling.subtitle),
              space,
              Text('Form Factor', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(item['formfactor'], style: TextStyling.subtitle),
              space,
              Text('Country', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(item['country'], style: TextStyling.subtitle),
              space,
              Text('Item Weight', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(item['itemweight'], style: TextStyling.subtitle),
              space,
              Text('Warranty', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(item['warranty'], style: TextStyling.subtitle),
              space,
            ],
          ),
        ),
      )),
    );
  }
}

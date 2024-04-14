import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget4.dart';
import 'package:prosample_1/admin/const/variables.dart';

class ScreenCabinetInfo extends StatefulWidget {
  final Map<String, dynamic> cabinet;
  const ScreenCabinetInfo({super.key, required this.cabinet});

  @override
  State<ScreenCabinetInfo> createState() => _ScreenCabinetInfoState();
}

class _ScreenCabinetInfoState extends State<ScreenCabinetInfo> {
  @override
  Widget build(BuildContext context) {
    final cab = widget.cabinet;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Product Details',
          style: TextStyling.appTitle,
        ),
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
                    Text('General', style: TextStyling.subtitle3),
                    h10,
                    Custom3.details(context,
                        title: 'Product Name', detail: cab[name]),
                    h10,
                    Custom3.details(context,
                        title: 'Model Name', detail: cab[model]),
                    h10,
                    Custom3.details(context,
                        title: 'Manufacuter', detail: cab[manufacturer]),
                    h10,
                    Custom3.details(context,
                        title: 'Material', detail: cab[material]),
                    h10,
                    Custom3.details(context,
                        title: 'Fancount', detail: cab[fancount]),
                    h10,
                    Custom3.details(context,
                        title: 'Fan Size', detail: cab[fansize]),
                    h10,
                    Custom3.details(context,
                        title: 'USB Ports',
                        detail: '${cab[usb2]} x Usb2, ${cab[usb3]} x Usb3'),
                    h10,
                    Custom3.details(context,
                        title: 'Item Weight', detail: cab[weight]),
                    h10,
                    Custom3.details(context,
                        title: 'Product Dimensions', detail: cab[dimension]),
                    h10,
                    Custom3.details(context,
                        title: 'Country Of Origin', detail: cab[country]),
                    h10,
                    Custom3.details(context,
                        title: 'Warranty', detail: cab[warranty]),
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

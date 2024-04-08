import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

class ScreenCableInfo extends StatefulWidget {
  final Map<String, dynamic> cable;
  const ScreenCableInfo({super.key, required this.cable});

  @override
  State<ScreenCableInfo> createState() => _ScreenCableInfoState();
}

class _ScreenCableInfoState extends State<ScreenCableInfo> {
  @override
  Widget build(BuildContext context) {
    final cable = widget.cable;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Product Details',style: TextStyling.appTitle),
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
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 10, left: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: Text('Product Name',
                                    style: TextStyling.subtitle),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child: Text('Model Name',
                                      style: TextStyling.subtitle)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Manufacturer',
                                      style: TextStyling.subtitle)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Colour',
                                      style: TextStyling.subtitle)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Speed',
                                      style: TextStyling.subtitle)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Pins',
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Voltage',
                                      style: TextStyling.subtitle)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Wattage',
                                      style: TextStyling.subtitle)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: Text('Product Dimensions',
                                      style: TextStyling.subtitle)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Country of Origin',
                                      style: TextStyling.subtitle)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Item Weight',
                                      style: TextStyling.subtitle)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: Text('Warranty',
                                      style: TextStyling.subtitle)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 10, left: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: Text(cable['name'],
                                    style: TextStyling.details),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child: Text(cable['model'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text(cable['manufacturer'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text(cable['color'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text(cable['speed'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text(cable['pins'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text(cable['voltage'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text(cable['wattage'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: Text(cable['productdimension'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text(cable['country'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text(cable['itemweight'],
                                      style: TextStyling.details)),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * .1,
                                child: Text(cable['Warranty'],
                                    style: TextStyling.details),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

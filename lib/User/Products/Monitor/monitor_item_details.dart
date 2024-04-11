import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

class ScreenMonitorInfo extends StatefulWidget {
  final Map<String, dynamic> monitor;
  const ScreenMonitorInfo({super.key, required this.monitor});

  @override
  State<ScreenMonitorInfo> createState() => _ScreenMonitorInfoState();
}

class _ScreenMonitorInfoState extends State<ScreenMonitorInfo> {
  @override
  Widget build(BuildContext context) {
    final monitor = widget.monitor;
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
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .4,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Column(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Text('Product Name',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Text('Model Name',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('Manufacturer',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Text('Features',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('Display Type',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('Display Size',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('Screen Resolution',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('Refresh Rate',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('Response',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('View Angle',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('Hardware Interface',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child:
                                  Text('Voltage', style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Text('Product Dimension',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('Item Weight',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('Country of Origin',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: Text('Warranty',
                                  style: TextStyling.subtitle)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Column(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .08,
                              child: Text(monitor['name'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .08,
                              child: Text(monitor['model'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(monitor['manufacturer'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .08,
                              child: Text(monitor['features'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(monitor['displaytype'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(monitor['displaysize'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(monitor['resolution'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(monitor['refRate'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(monitor['response'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(monitor['viewingangle'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(monitor['hdwinterface'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(monitor['voltage'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(monitor['voltage'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .08,
                              child: Text(monitor['productdimension'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(monitor['itemweight'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(monitor['country'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .1,
                              child: Text(monitor['warranty'],
                                  style: TextStyling.details)),
                        ],
                      ),
                    ),
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

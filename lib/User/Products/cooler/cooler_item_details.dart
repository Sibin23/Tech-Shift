import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

class ScreenCoolerInfo extends StatefulWidget {
  final Map<String, dynamic> cooler;
  const ScreenCoolerInfo({super.key, required this.cooler});

  @override
  State<ScreenCoolerInfo> createState() => _ScreenCoolerInfoState();
}

class _ScreenCoolerInfoState extends State<ScreenCoolerInfo> {
  @override
  Widget build(BuildContext context) {
    final cooler = widget.cooler;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Product Detials',style: TextStyling.appTitle),
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
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Manufacturer',
                                      style: TextStyling.subtitle)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Material',
                                      style: TextStyling.subtitle)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Total Fans',
                                      style: TextStyling.subtitle)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Cooling Type',
                                      style: TextStyling.subtitle)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Connectivity',
                                      style: TextStyling.subtitle)),
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
                                  child: Text('Features',
                                      style: TextStyling.subtitle)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Noise',
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
                                  child: Text('Cooler Size',
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
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: Text('Warranty',
                                      style: TextStyling.subtitle)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .5,
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Text(cooler['name'],
                                  style: TextStyling.details),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text(cooler['manufacturer'],
                                  style: TextStyling.details),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(cooler['material'],
                                  style: TextStyling.details),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text('${cooler['fans']} fans',
                                  style: TextStyling.details),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(cooler['cooling'],
                                  style: TextStyling.details),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(cooler['connectivity'],
                                  style: TextStyling.details),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(cooler['voltage'],
                                  style: TextStyling.details),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(cooler['wattage'],
                                  style: TextStyling.details),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .1,
                              child: Text(cooler['features'],
                                  style: TextStyling.details),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(cooler['noise'],
                                  style: TextStyling.details),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(cooler['speed'],
                                  style: TextStyling.details),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(cooler['size'],
                                  style: TextStyling.details),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(cooler['itemweight'],
                                  style: TextStyling.details),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .1,
                              child: Text(cooler['productdimension'],
                                  style: TextStyling.details),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(cooler['country'],
                                  style: TextStyling.details),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: Text(cooler['warranty'],
                                  style: TextStyling.details),
                            ),
                          ],
                        ),
                      )
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

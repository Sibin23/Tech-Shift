import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

class ScreenSsdInfo extends StatefulWidget {
  final Map<String, dynamic> ssd;
  const ScreenSsdInfo({super.key, required this.ssd});

  @override
  State<ScreenSsdInfo> createState() => _ScreenSsdInfoState();
}

class _ScreenSsdInfoState extends State<ScreenSsdInfo> {
  @override
  Widget build(BuildContext context) {
    final ssd = widget.ssd;
    return Scaffold(
      appBar: AppBar(
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
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: Column(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Text('Product Name',
                                  style: TextStyling.subtitle2)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Text('Model Name',
                                  style: TextStyling.subtitle2)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Text('Manufacturer',
                                  style: TextStyling.subtitle2)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Text('Form Factor',
                                  style: TextStyling.subtitle2)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child:
                                  Text('Gen Type', style: TextStyling.subtitle2)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Text('Interface',
                                  style: TextStyling.subtitle2)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child:
                                  Text('Storage', style: TextStyling.subtitle2)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Text('Transfer Speed',
                                  style: TextStyling.subtitle2)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child:
                                  Text('Wattage', style: TextStyling.subtitle2)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Text('Connectivity',
                                  style: TextStyling.subtitle2)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Text('Product Dimension',
                                  style: TextStyling.subtitle2)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Text('Country of Origin',
                                  style: TextStyling.subtitle2)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Text('Item Weight',
                                  style: TextStyling.subtitle2)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.1,
                              child:
                                  Text('Warranty', style: TextStyling.subtitle2)),
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
                              height: MediaQuery.of(context).size.height * .05,
                              child:
                                  Text(ssd['name'], style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .05,
                              child:
                                  Text(ssd['model'], style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .05,
                              child: Text(ssd['manufacturer'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .05,
                              child: Text(ssd['formfactor'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .05,
                              child: Text(ssd['gentype'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .05,
                              child: Text(ssd['interface'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .05,
                              child: Text(ssd['storage'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .05,
                              child: Text(ssd['transferspeed'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .05,
                              child: Text(ssd['wattage'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .05,
                              child: Text(ssd['connectivity'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .08,
                              child: Text(ssd['productdimension'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .05,
                              child: Text(ssd['country'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .05,
                              child: Text(ssd['itemweight'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .1,
                              child: Text(ssd['warranty'],
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

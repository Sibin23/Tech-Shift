import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

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
        title: Text('Product Details',style: TextStyling.appTitle),
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
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Column(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Text('Product Name',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child:
                                  Text('Model Name', style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('Manufacturer',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('Series', style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('Colour', style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('Connectivity',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('DPI', style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Text('Features', style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('Buttons', style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Text('Product Dimension',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('Country of Origin',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child:
                                  Text('Item Weight', style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: Text('Warranty', style: TextStyling.subtitle)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Column(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .08,
                              child:
                                  Text(mouse['name'], style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child:
                                  Text(mouse['model'], style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(mouse['manufacturer'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(mouse['series'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child:
                                  Text(mouse['color'], style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(mouse['connectivity'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child:
                                  Text(mouse['dpi'], style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .08,
                              child: Text(mouse['features'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(mouse['buttons'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .08,
                              child: Text(mouse['productdimension'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(mouse['country'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(mouse['itemweight'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .1,
                              child: Text(mouse['warranty'],
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

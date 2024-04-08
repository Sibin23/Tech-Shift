import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

class ScreenPsuInfo extends StatefulWidget {
  final Map<String, dynamic> psu;
  const ScreenPsuInfo({super.key, required this.psu});

  @override
  State<ScreenPsuInfo> createState() => _ScreenPsuInfoState();
}

class _ScreenPsuInfoState extends State<ScreenPsuInfo> {
  @override
  Widget build(BuildContext context) {
    final psu = widget.psu;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close, color: AppColors.appTheme)),
      ),
      body: SafeArea(
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
                      width: MediaQuery.of(context).size.width * .4,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Text('Product Name',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Text('Model Name',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Text('Manufacturer',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Text('Cooling Method',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Text('Form Factor',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Text('Wattage',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: Text('Product Dimension',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Text('Country of Origin',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
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
                      width: MediaQuery.of(context).size.width * .5,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, right: 10, left: 10),
                        child: Column(
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Text(psu['name'],
                                    style: TextStyling.details)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Text(psu['model'],
                                    style: TextStyling.details)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Text(psu['manufacturer'],
                                    style: TextStyling.details)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Text(psu['coolingmethod'],
                                    style: TextStyling.details)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Text(psu['formfactor'],
                                    style: TextStyling.details)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Text(psu['wattage'],
                                    style: TextStyling.details)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * .08,
                                child: Text(psu['productdimension'],
                                    style: TextStyling.details)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Text(psu['country'],
                                    style: TextStyling.details)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Text(psu['itemweight'],
                                    style: TextStyling.details)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * .1,
                                child: Text(psu['warranty'],
                                    style: TextStyling.details)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 10,
                        top: 0,
                          child: SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: Text('Features', style: TextStyling.subtitle2),
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .5,
                            child: Text(psu['features'],style: TextStyling.details),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

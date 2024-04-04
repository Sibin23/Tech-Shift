import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class ScreenMotherboardInfo extends StatefulWidget {
  final Map<String, dynamic> board;
  const ScreenMotherboardInfo({super.key, required this.board});

  @override
  State<ScreenMotherboardInfo> createState() => _ScreenMotherboardInfoState();
}

class _ScreenMotherboardInfoState extends State<ScreenMotherboardInfo> {
  @override
  Widget build(BuildContext context) {
    final board = widget.board;

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
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: Text('Product Name',
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child: Text('Model Name',
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Manufacturer',
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Form Factor',
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child: Text('Memory Clock Speed',
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Processor Socket',
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('RAM Type',
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child: Text('Maximum Memory Support',
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('RAM Slots',
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('SSD Type',
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('SSD Slots',
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Wattage',
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child: Text('Product Dimension',
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Country of Origin',
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Item Weight',
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  child: Text('Warranty',
                                      style: TextStyling.subtitle2)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .5,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .1,
                                  child: Text(board['name'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .08,
                                  child: Text(board['model'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .04,
                                  child: Text(board['manufacturer'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .04,
                                  child: Text(board['formfactor'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .08,
                                  child: Text(board['maxclock'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .04,
                                  child: Text(board['processorsocket'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .04,
                                  child: Text(board['ramType'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .08,
                                  child: Text('${board['ramsize']} Gb',
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .04,
                                  child: Text(board['ramslots'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .04,
                                  child: Text(board['ssdtype'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .04,
                                  child: Text(board['ssdslots'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .04,
                                  child: Text(board['wattage'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .08,
                                  child: Text(board['productdimension'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .04,
                                  child: Text(board['country'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .04,
                                  child: Text(board['itemweight'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .12,
                                  child: Text(board['warranty'],
                                      style: TextStyling.details)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 10,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * .4,
                            child:
                                Text('Ports', style: TextStyling.subtitle2)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * .5,
                              child: Text(board['ports'],
                                  style: TextStyling.details)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 10,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * .4,
                            child:
                                Text('Features', style: TextStyling.subtitle2)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * .5,
                              child: Text(board['features'],
                                  style: TextStyling.details)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

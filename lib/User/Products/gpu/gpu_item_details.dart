import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

class ScreenGpuInfo extends StatefulWidget {
  final Map<String, dynamic> gpu;
  const ScreenGpuInfo({super.key, required this.gpu});

  @override
  State<ScreenGpuInfo> createState() => _ScreenGpuInfoState();
}

class _ScreenGpuInfoState extends State<ScreenGpuInfo> {
  @override
  Widget build(BuildContext context) {
    final gpu = widget.gpu;
    return Scaffold(
      appBar: AppBar(
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
                              height: MediaQuery.of(context).size.height * 0.15,
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
                              height: MediaQuery.of(context).size.height * 0.04,
                              child:
                                  Text('Colour', style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.35,
                              child: Text('Features',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Text('Maximum Resolution',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('Ram Type',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('Ram Size',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child:
                                  Text('Speed', style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('Support Type',
                                  style: TextStyling.subtitle)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child:
                                  Text('Wattage', style: TextStyling.subtitle)),
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
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: Column(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .15,
                              child: Text(gpu['name'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .08,
                              child: Text(gpu['model'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(gpu['manufacturer'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(gpu['color'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .35,
                              child: Text(gpu['features'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .08,
                              child: Text(gpu['maxres'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(gpu['ramtype'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(gpu['ramsize'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(gpu['speed'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(gpu['support'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text('${gpu['wattage']} W',
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .08,
                              child: Text(gpu['productdimension'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(gpu['itemweight'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .04,
                              child: Text(gpu['country'],
                                  style: TextStyling.details)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .1,
                              child: Text(gpu['warranty'],
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

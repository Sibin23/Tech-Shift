import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

class ScreenRamInfo extends StatefulWidget {
  final Map<String, dynamic> ram;
  const ScreenRamInfo({super.key, required this.ram});

  @override
  State<ScreenRamInfo> createState() => _ScreenRamInfoState();
}

class _ScreenRamInfoState extends State<ScreenRamInfo> {
  @override
  Widget build(BuildContext context) {
    final ram = widget.ram;
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
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, ),
                        child: Column(
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: Text('Product Name',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: Text('Model Name',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: Text('Manufacturer',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Text('RAM Type',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Text('RAM Size',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Text('Clock Speed',
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
                                    MediaQuery.of(context).size.height * 0.08,
                                child: Text('Product Dimension',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Text('Country',
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
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    child: Column(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .08,
                            child:
                                Text(ram['name'], style: TextStyling.details)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .08,
                            child:
                                Text(ram['model'], style: TextStyling.details)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .08,
                            child: Text(ram['manufacturer'],
                                style: TextStyling.details)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .05,
                            child: Text(ram['ramtype'],
                                style: TextStyling.details)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .05,
                            child: Text('${ram['ramsize']} Gb',
                                style: TextStyling.details)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .05,
                            child: Text(ram['clockspeed'],
                                style: TextStyling.details)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .05,
                            child: Text(ram['formfactor'],
                                style: TextStyling.details)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .08,
                            child: Text(ram['productdimension'],
                                style: TextStyling.details)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .05,
                            child: Text(ram['country'],
                                style: TextStyling.details)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .05,
                            child: Text(ram['itemweight'],
                                style: TextStyling.details)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .1,
                            child: Text(ram['warranty'],
                                style: TextStyling.details)),
                      ],
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

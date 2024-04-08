import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

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
        title: Text('Product Details',style: TextStyling.appTitle,),
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
               decoration:
                      const BoxDecoration(color: Colors.white, boxShadow: [
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
                          padding:
                              const EdgeInsets.only(top: 10, right: 10, left: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.08,
                                child: Text('Product Name',
                                    style: TextStyling.subtitle),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.08,
                                  child: Text('Model Name',
                                      style: TextStyling.subtitle)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.07,
                                  child: Text('Fancount',
                                      style: TextStyling.subtitle)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Fan Size',
                                      style: TextStyling.subtitle)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.08,
                                  child: Text('Manufacturer',
                                      style: TextStyling.subtitle)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.04,
                                  child: Text('Material',
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.04,
                                  child:
                                      Text('Ports', style: TextStyling.subtitle)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.07,
                                  child: Text('Item Weight',
                                      style: TextStyling.subtitle)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.1,
                                  child: Text('Product Dimensions',
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
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 10, right: 10, left: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.08,
                                child:
                                    Text(cab['name'], style: TextStyling.details),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.08,
                                  child: Text(cab['model'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.07,
                                  child: Text(cab['fancount'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.04,
                                  child: Text(cab['fansize'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.08,
                                  child: Text(cab['manufacturer'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.04,
                                  child: Text(cab['material'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.04,
                                  child: Text(
                                      'Usb2 * ${cab['usb2']}, Usb3 *${cab['usb3']}',
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.07,
                                  child: Text(cab['itemweight'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.1,
                                  child: Text(cab['productdimension'],
                                      style: TextStyling.details)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.04,
                                  child: Text(cab['country'],
                                      style: TextStyling.details)),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * .1,
                                child: Text(cab['warranty'],
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

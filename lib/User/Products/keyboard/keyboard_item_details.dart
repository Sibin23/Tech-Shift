import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

class ScreenKeyboardInfo extends StatefulWidget {
  final Map<String, dynamic> keyboard;
  const ScreenKeyboardInfo({super.key, required this.keyboard});

  @override
  State<ScreenKeyboardInfo> createState() => _ScreenKeyboardInfoState();
}

class _ScreenKeyboardInfoState extends State<ScreenKeyboardInfo> {
  @override
  Widget build(BuildContext context) {
    final keyboard = widget.keyboard;
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
                            height: MediaQuery.of(context).size.height * 0.04,
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
                                Text('Material', style: TextStyling.subtitle)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: Text('Connectivity',
                                style: TextStyling.subtitle)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.08,
                            child:
                                Text('Features', style: TextStyling.subtitle)),
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
                            height: MediaQuery.of(context).size.height * 0.08,
                            child:
                                Text('Warranty', style: TextStyling.subtitle)),
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
                            child: Text(keyboard['name'],
                                style: TextStyling.details)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .04,
                            child: Text(keyboard['model'],
                                style: TextStyling.details)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .04,
                            child: Text(keyboard['manufacturer'],
                                style: TextStyling.details)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .04,
                            child: Text(keyboard['material'],
                                style: TextStyling.details)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .04,
                            child: Text(keyboard['connector'],
                                style: TextStyling.details)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .08,
                            child: Text(keyboard['features'],
                                style: TextStyling.details)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .08,
                            child: Text(keyboard['productdimension'],
                                style: TextStyling.details)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .04,
                            child: Text(keyboard['itemweight'],
                                style: TextStyling.details)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .04,
                            child: Text(keyboard['country'],
                                style: TextStyling.details)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .08,
                            child: Text(keyboard['warranty'],
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';


class PreBuildDetails extends StatelessWidget {
 final Map<String, dynamic> prebuild;
  const PreBuildDetails({super.key, required this.prebuild});

  @override
  Widget build(BuildContext context) {
    String name = prebuild['name'];
    String imageUrl = prebuild['image'];
    String idNum = prebuild['idnum'];
    String categoryName = prebuild['categoryid'];
    String cabinet = prebuild['case'];
    String oldPrice = prebuild['oldprice'];
    String newPrice = prebuild['newprice'];
    String processor = prebuild['processor'];
    String board = prebuild['motherboard']; 
    String ram = prebuild['ram'];
    String ssd = prebuild['ssd'];
    String expstorage = prebuild['expstorage'];
    String gpu = prebuild['gpu'];
    String features = prebuild['features'];
    String cooler = prebuild['cooler'];
    String psu = prebuild['psu'];
    String warranty = prebuild['warranty'];


    return Scaffold(
      appBar: AppBar(
          surfaceTintColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: AppColors.appTheme,
              ))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Product Details', style: TextStyling.subtitle3),
              const SizedBox(height: 20),
              Container(
                decoration:
                    const BoxDecoration(color: Colors.white, boxShadow: [
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
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, right: 10, left: 10),
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: Text('Category Name',
                                  style: TextStyling.subtitle),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.085,
                                child: Text('Cabinet',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Text('Processor',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: Text('Motherboard',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: Text('Memory',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: Text('Storage',
                                    style: TextStyling.subtitle2)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Text('Expandable',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Text('Graphics Card',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Text('Special Features',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: Text('CPU Cooler',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .08,
                                width: MediaQuery.of(context).size.width,
                                child: Text('Power Supply Unit (PSU)',
                                    style: TextStyling.subtitle)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .08,
                              child:
                                  Text('Warranty', style: TextStyling.subtitle),
                            )
                          ],
                        ),
                      ),
                    ), // Text row
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, right: 10, bottom: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Text(categoryName,
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height *
                                      0.085,
                                  child: Text(cabinet,
                                      style: TextStyling.subtitle2,
                                      maxLines: 3)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child: Text(processor,
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child: Text(board,
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child:
                                      Text(ram, style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child:
                                      Text(ssd, style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child: Text(expstorage)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child:
                                      Text(gpu, style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: Text(features,
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .08,
                                  child: Text(cooler,
                                      style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .08,
                                  child:
                                      Text(psu, style: TextStyling.subtitle2)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .08,
                                  child: Text(warranty,
                                      style: TextStyling.subtitle2)),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

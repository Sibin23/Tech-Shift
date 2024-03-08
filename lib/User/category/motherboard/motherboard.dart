import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/category/motherboard/more_infro.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';
import 'package:prosample_1/User/utils/widget2.dart';

class MotherboardInfo extends StatefulWidget {
  final Map<String, dynamic> itemInfo;
  const MotherboardInfo({super.key, required this.itemInfo});

  @override
  State<MotherboardInfo> createState() => _MotherboardInfoState();
}

class _MotherboardInfoState extends State<MotherboardInfo> {
  @override
  Widget build(BuildContext context) {
    String imageUrl = widget.itemInfo['image'];
    String categoryName = widget.itemInfo['category'];
    String idNum = widget.itemInfo['idnum'];
    String name = widget.itemInfo['name'];
    String maxClock = widget.itemInfo['maxclock'];
    String model = widget.itemInfo['model'];
    String manufacturer = widget.itemInfo['manufacturer'];
    String processorSocket = widget.itemInfo['processorsocket'];
    String ramType = widget.itemInfo['ramType'];
    String ramSize = widget.itemInfo['ramsize'];
    String ramSlots = widget.itemInfo['ramslots'];
    String ssdType = widget.itemInfo['ssdtype'];
    String ssdSlots = widget.itemInfo['ssdslots'];
    String oldPrice = widget.itemInfo['oldprice'];
    String newPrice = widget.itemInfo['newprice'];
    String dimension = widget.itemInfo['productdimension'];
    String features = widget.itemInfo['features'];
    String voltage = widget.itemInfo['voltage'];
    String formFactor = widget.itemInfo['formfactor'];
    String country = widget.itemInfo['country'];
    String weight = widget.itemInfo['itemweight'];
    String warranty = widget.itemInfo['warranty'];

    final motherBoard = {
      'idnum': idNum,
      'category': categoryName,
      'image': imageUrl,
      'name': name,
      'maxclock': maxClock,
      'model': model,
      'manufacturer': manufacturer,
      'processorsocket': processorSocket,
      'ramType': ramType,
      'ramsize': ramSize,
      'ramslots': ramSlots,
      'ssdtype': ssdType,
      'ssdslots': ssdSlots,
      'oldprice': oldPrice,
      'newprice': newPrice,
      'productdimension': dimension,
      'features': features,
      'voltage': voltage,
      'formfactor': formFactor,
      'country': country,
      'itemweight': weight,
      'warranty': warranty,
    };
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.appTheme),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)),
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Center(
                      child: Text('Buy Now', style: TextStyling.buttonB))),
              GestureDetector(
                onTap: () {},
                child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.appTheme,
                        borderRadius: BorderRadius.circular(6)),
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Center(
                        child:
                            Text('Add to Cart', style: TextStyling.buttonW))),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          surfaceTintColor: Colors.white,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Center(
                          child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              placeholder: (context, url) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }))),
                  Container(
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              color: Colors.grey,
                              spreadRadius: 2,
                              offset: Offset(2, 2))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                            right: Radius.elliptical(40, 20),
                            left: Radius.elliptical(40, 20))),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Text(
                                      name,
                                      style: TextStyling.subtitle3,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  UiCustom.rating(),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text('₹', style: TextStyling.subtitle),
                                      const SizedBox(width: 3),
                                      Text(
                                          newPrice.replaceAllMapped(
                                              RegExp(
                                                  r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                              (Match m) => "${m[1]},"),
                                          style: TextStyling.newPbig),
                                    ],
                                  ),
                                  const SizedBox(width: 15),
                                  Row(children: [
                                    Text('₹', style: TextStyling.subtitle),
                                    const SizedBox(width: 3),
                                    Text(
                                        oldPrice.replaceAllMapped(
                                            RegExp(
                                                r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                            (Match m) => "${m[1]},"),
                                        style: TextStyling.oldGreyinfo),
                                  ]),
                                ],
                              ),
                              const Divider(thickness: 1),
                              const SizedBox(height: 50),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.14,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.local_shipping,
                                                color: AppColors.appTheme,
                                                size: 30),
                                            const SizedBox(width: 5),
                                            Text(
                                              'All India Shiping',
                                              style: TextStyling.categoryText,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.payments_outlined,
                                                color: AppColors.appTheme,
                                                size: 25),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Competitive Price',
                                              style: TextStyling.categoryText,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.check_circle,
                                                color: AppColors.appTheme,
                                                size: 30),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Branded Products',
                                              style: TextStyling.categoryText,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                                Icons
                                                    .admin_panel_settings_rounded,
                                                color: AppColors.appTheme,
                                                size: 30),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Secured Shoping',
                                              style: TextStyling.categoryText,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => MotherboardInfo2(
                                                itemInfo: motherBoard)));
                                  },
                                  child: const Text(
                                    'View More',
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .05),
                      ],
                    ),
                  ),
                ]))));
  }
}

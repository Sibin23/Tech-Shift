import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/Pre%20Builds/details.dart';
import 'package:prosample_1/User/cart/cart.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';
import 'package:prosample_1/User/utils/widget2.dart';

// ignore: must_be_immutable
class PreBuildInfo extends StatefulWidget {
  Map<String, dynamic> prebuild;
  PreBuildInfo({super.key, required this.prebuild});

  @override
  State<PreBuildInfo> createState() => _PreBuildInfoState();
}

class _PreBuildInfoState extends State<PreBuildInfo> {
  bool wishlist = true;
  @override
  Widget build(BuildContext context) {
    String name = widget.prebuild['name'];
    String imageUrl = widget.prebuild['image'];
    String categoryName = widget.prebuild['name'];
    String cabinet = widget.prebuild['case'];
    String oldPrice = widget.prebuild['oldprice'];
    String newPrice = widget.prebuild['newprice'];
    String processor = widget.prebuild['processor'];
    String board = widget.prebuild['motherboard'];
    String ram = widget.prebuild['ram'];
    String ssd = widget.prebuild['ssd'];
    String expstorage = widget.prebuild['expstorage'];
    String gpu = widget.prebuild['gpu'];
    String features = widget.prebuild['features'];
    String cooler = widget.prebuild['cooler'];
    String psu = widget.prebuild['psu'];
    String warranty = widget.prebuild['warranty'];

    return Scaffold(
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
                                  Text(
                                    name,
                                    style: TextStyling.titleText,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        wishlist = !wishlist;
                                      });
                                    },
                                    child: wishlist == true ?
                                    const Icon(Icons.favorite_outline,size: 35): const Icon(Icons.favorite, size: 35,color: Colors.red)
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
                                      Text(newPrice.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},"),
                                          style: TextStyling.newPbig),
                                    ],
                                  ),
                                  const SizedBox(width: 15),
                                  Row(children: [
                                    Text('₹', style: TextStyling.subtitle),
                                    const SizedBox(width: 3),
                                    Text(oldPrice.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},"),
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
                                    Map<String, dynamic> prebuild = {
                                      'name': categoryName,
                                      'cabinet': cabinet,
                                      'processor': processor,
                                      'motherboard': board,
                                      'ram': ram,
                                      'ssd': ssd,
                                      'storage': ssd,
                                      'expstorage': expstorage,
                                      'gpu': gpu,
                                      'features': features,
                                      'cooler': cooler,
                                      'psu': psu,
                                      'warranty': warranty,
                                    };
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => PreBuildDetails(
                                                prebuild: prebuild)));
                                  },
                                  child: const Text(
                                    'View More',
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .05),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColors.appTheme),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6)),
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Center(
                                      child: Text('Buy Now',
                                          style: TextStyling.buttonB))),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              const ScreenCart()));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.appTheme,
                                        borderRadius: BorderRadius.circular(6)),
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: Center(
                                        child: Text('Add to Cart',
                                            style: TextStyling.buttonW))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]))));
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/Pre%20Builds/Screen%20prebuild/prebuild_cart.dart';
import 'package:prosample_1/User/Pre%20Builds/details.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';
import 'package:prosample_1/User/utils/widget2.dart';

class PreBuildInfo extends StatefulWidget {
  final Map<String, dynamic> prebuild;
  const PreBuildInfo({super.key, required this.prebuild});

  @override
  State<PreBuildInfo> createState() => _PreBuildInfoState();
}

class _PreBuildInfoState extends State<PreBuildInfo> {
  @override
  Widget build(BuildContext context) {
    print(widget.prebuild);
    String name = widget.prebuild['name'];
    String imageUrl = widget.prebuild['image'];
    String idNum = widget.prebuild['idnum'];
    String categoryName = widget.prebuild['categoryid'];
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
    Map<String, dynamic> prebuild = {
      'image': imageUrl,
      'idnum': idNum,
      'categoryid': categoryName,
      'name': name,
      'oldprice': oldPrice,
      'newprice': newPrice,
      'processor': processor,
      'motherboard': board,
      'ram': ram,
      'ssd': ssd,
      'expstorage': expstorage,
      'gpu': gpu,
      'features': features,
      'cooler': cooler,
      'psu': psu,
      'case': cabinet,
      'warranty': warranty
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
                onTap: () {
                  addToCart();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => CartPreBuild(
                                prebuild: prebuild,
                              )));
                },
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
                                  Text(
                                    name,
                                    style: TextStyling.titleText,
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
                      ],
                    ),
                  ),
                ]))));
  }

  Future<void> addToCart() async {
    try {
      final userEmail = FirebaseAuth.instance.currentUser!;
      final userDocRef = FirebaseFirestore.instance
          .collection('User')
          .doc(userEmail.toString());
      final uniqueId = widget.prebuild['idnum'].toString().toLowerCase();
      final cartCollectionRef =
          userDocRef.collection('PreBuildCart').doc(uniqueId);
      final cartItem = {
        'image': widget.prebuild['image'],
        'idnum': widget.prebuild['idnum'],
        'categoryid': widget.prebuild['categoryid'],
        'name': widget.prebuild['name'],
        'oldprice': widget.prebuild['oldprice'],
        'newprice': widget.prebuild['newprice'],
        'case': widget.prebuild['case'],
        'processor': widget.prebuild['processor'],
        'motherboard': widget.prebuild['motherboard'],
        'ram': widget.prebuild['ram'],
        'ssd': widget.prebuild['ssd'],
        'expstorage': widget.prebuild['expstorage'],
        'gpu': widget.prebuild['gpu'],
        'features': widget.prebuild['features'],
        'cooler': widget.prebuild['cooler'],
        'psu': widget.prebuild['psu'],
        'warranty': widget.prebuild['warranty'],
      };
      await cartCollectionRef.set(cartItem);
    } catch (error) {
      print('Error adding item to cart: $error');
    }
  }
}

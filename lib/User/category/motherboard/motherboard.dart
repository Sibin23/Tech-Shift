import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/category/motherboard/more_infro.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/commonfile.dart';
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
    final board = widget.itemInfo;
    final motherBoard = {
      'category': board['category'],
      'image': board['image'],
      'name': board['name'],
      'maxclock': board['maxclock'],
      'model': board['model'],
      'manufacturer': board['manufacturer'],
      'processorsocket': board['processorsocket'],
      'ramType': board['ramType'],
      'ramsize': board['ramsize'],
      'ramslots': board['ramslots'],
      'ssdtype': board['ssdtype'],
      'ssdslots': board['ssdslots'],
      'productdimension': board['productdimension'],
      'features': board['features'],
      'wattage': board['wattage'],
      'formfactor': board['formfactor'],
      'country': board['country'],
      'itemweight': board['itemweight'],
      'warranty': board['warranty'],
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
                  final selectedBoard = {
                    'image': board['image'],
                    'name': board['name'],
                    'idnum': board['idnum'],
                    'oldprice': board['oldprice'],
                    'newprice': board['newprice'],
                    'category': board['category'],
                  };
                  addToCart(selectedBoard);
                  showSnackbarWithAnimation();
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
                              imageUrl: board['image'],
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
                                      board['name'],
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
                                          board['newprice'].replaceAllMapped(
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
                                        board['oldprice'].replaceAllMapped(
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

  Future<void> addToCart(Map<String, dynamic> cartItem) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final userUid = user.uid;
      final userDocRef =
          FirebaseFirestore.instance.collection('User').doc(userUid);
      final cartCollectionRef = userDocRef.collection('others').doc();
      await cartCollectionRef.set(cartItem);
    } catch (error) {
      alert(error);
    }
  }

  alert(error) {
    UiHelper.customTextAlert(context, error.toString());
  }
   void showSnackbarWithAnimation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 2,
              color: Colors.grey
            )
          ], color: Colors.white,borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              Lottie.asset('assets/Animations/cart.json', width: 100, height: 100),
              const SizedBox(width: 10),
              Text('Added To Cart',
                  style: TextStyle(color: Colors.purple.shade800, fontSize: 16)),
            ],
          ),
        ),elevation: 5,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          textColor: AppColors.appTheme,
          label: 'Dismiss',
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }
}

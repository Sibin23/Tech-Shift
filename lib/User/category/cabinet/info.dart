import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/category/cabinet/product_details.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/commonfile.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';
import 'package:prosample_1/User/utils/widget2.dart';

class CabinetInfo extends StatefulWidget {
  final Map<String, dynamic> cabinet;
  const CabinetInfo({super.key, required this.cabinet});

  @override
  State<CabinetInfo> createState() => _CabinetInfoState();
}

class _CabinetInfoState extends State<CabinetInfo> {
  @override
  Widget build(BuildContext context) {
    final cabinet = widget.cabinet;
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
                  final selectedCabinet = {
                    'image': cabinet['image'],
                    'name': cabinet['name'],
                    'idnum': cabinet['idnum'],
                    'oldprice': cabinet['oldprice'],
                    'newprice': cabinet['newprice'],
                    'category': cabinet['category'],
                  };
                  addToCart(selectedCabinet);
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
                              imageUrl: cabinet['image'],
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
                                      cabinet['name'],
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
                                          cabinet['newprice'].replaceAllMapped(
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
                                        cabinet['oldprice'].replaceAllMapped(
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
                                            builder: (ctx) => Cabinetinfo2(
                                                cabinet: cabinet)));
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
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          textColor: AppColors.appTheme,
          label: 'Dismiss',
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/Pre%20Builds/prebuild_item_details.dart';
import 'package:prosample_1/User/Products/Chair/chairs_item_details.dart';
import 'package:prosample_1/User/Products/Monitor/monitor_item_details.dart';
import 'package:prosample_1/User/Products/Mouse/mouse_item_details.dart';
import 'package:prosample_1/User/Products/cabinet/cabinet_item_details.dart';
import 'package:prosample_1/User/Products/cables/cable_item_details.dart';
import 'package:prosample_1/User/Products/cooler/cooler_item_details.dart';
import 'package:prosample_1/User/Products/gpu/gpu_item_details.dart';
import 'package:prosample_1/User/Products/headset/headset_item_details.dart';
import 'package:prosample_1/User/Products/keyboard/keyboard_item_details.dart';
import 'package:prosample_1/User/Products/motherboard/motherboard_item_details.dart';
import 'package:prosample_1/User/Products/processor/processor_item_details.dart';
import 'package:prosample_1/User/Products/psu/psu_item_details.dart';
import 'package:prosample_1/User/Products/ram/ram_item_details.dart';
import 'package:prosample_1/User/Products/ssd/ssd_item_details.dart';
import 'package:prosample_1/User/cart/cart_buynow_address.dart';
import 'package:prosample_1/User/utils/Text_decorations.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/product_info1.dart';
import 'package:prosample_1/functions/fav_function.dart';

import '../../../functions/fuctions.dart';

class CheckDetails extends StatefulWidget {
  final String collection, idNum;

  const CheckDetails(
      {super.key, required this.collection, required this.idNum});

  @override
  State<CheckDetails> createState() => _CheckDetailsState();
}

class _CheckDetailsState extends State<CheckDetails> {
  bool isFavorite = false;
  List<Map<String, dynamic>> fetchedData = [];
  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    fetchData().then((data) {
      setState(() {
        fetchedData = data;
        isFavorite = fetchedData.any((item) =>
            item['uid'] == FirebaseAuth.instance.currentUser!.uid &&
            item['idnum'] == widget.idNum);
      });
    });
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    final favRef = FirebaseFirestore.instance
        .collection('User')
        .doc(user)
        .collection('Favorites')
        .get();

    final querySnapshot = await favRef;
    final fetchedData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return fetchedData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                final user = FirebaseAuth.instance.currentUser!.uid;
                final time = DateTime.now().toString();
                final item = Map<String, dynamic>.from(data);
                item['uid'] = user;
                addAmount(
                    newPrice: item['newprice'],
                    oldPrice: item['oldprice'],
                    idNum: item['idnum'],
                    time: time);
                buyNow(item, time);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const CartBuyNowAddress()));
              },
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.appTheme),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)),
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Center(
                      child: Text('Buy Now', style: TextStyling.buttonB))),
            ),
            GestureDetector(
              onTap: () {
                final user = FirebaseAuth.instance.currentUser!.uid;
                final time = DateTime.now().toString();
                final item = Map<String, dynamic>.from(data);
                item['uid'] = user;
                userDetails(idNum: item['idnum'], time: time);
                addAmount(
                    oldPrice: item['oldprice'],
                    newPrice: item['newprice'],
                    idNum: item['idnum'],
                    time: time);
                addInventoryCart(item, time);

                showSnackbarWithAnimation();
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.appTheme,
                      borderRadius: BorderRadius.circular(6)),
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Center(
                      child: Text('Add to Cart', style: TextStyling.buttonW))),
            ),
          ],
        ),
      ),
      appBar: AppBar(surfaceTintColor: Colors.white),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection(widget.collection)
                  .where('idnum', isEqualTo: widget.idNum)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  final document = snapshot.data!.docs.first.data();
                  data = {
                    'image': document['image'],
                    'name': document['name'],
                    'idnum': document['idnum'],
                    'oldprice': document['oldprice'],
                    'newprice': document['newprice'],
                    'category': document['category'],
                  };
                  Widget navigateToScreen;
                  if (document['category'] == 'cabinet') {
                    navigateToScreen = ScreenCabinetInfo(cabinet: document);
                  } else if (document['category'] == 'cables') {
                    navigateToScreen = ScreenCableInfo(cable: document);
                  } else if (document['category'] == 'chairs') {
                    navigateToScreen = ScreenChairInfo(chair: document);
                  } else if (document['category'] == 'cooler') {
                    navigateToScreen = ScreenCoolerInfo(cooler: document);
                  } else if (document['category'] == 'gpu') {
                    navigateToScreen = ScreenGpuInfo(gpu: document);
                  } else if (document['category'] == 'headsets') {
                    navigateToScreen = ScreenHeadsetsInfo(headset: document);
                  } else if (document['category'] == 'keyboard') {
                    navigateToScreen = ScreenKeyboardInfo(keyboard: document);
                  } else if (document['category'] == 'monitor') {
                    navigateToScreen = ScreenMonitorInfo(monitor: document);
                  } else if (document['category'] == 'motherboard') {
                    navigateToScreen = ScreenMotherboardInfo(board: document);
                  } else if (document['category'] == 'mouse') {
                    navigateToScreen = ScreenMouseInfo(mouse: document);
                  } else if (document['category'] == 'processor') {
                    navigateToScreen = ScreenProcessorInfo(cpu: document);
                  } else if (document['category'] == 'psu') {
                    navigateToScreen = ScreenPsuInfo(psu: document);
                  } else if (document['category'] == 'ram') {
                    navigateToScreen = ScreenRamInfo(ram: document);
                  } else if (document['category'] == 'ssd') {
                    navigateToScreen = ScreenSsdInfo(ssd: document);
                  } else if (document['category'] == 'prebuild') {
                    navigateToScreen = ScreenPrebuildInfo(prebuild: document);
                  } else {
                    navigateToScreen = const Text('Unknown category');
                  }

                  return Column(children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ProductDetails.productInfo1(context, () {
                          final time = DateTime.now().toString();
                          setState(() {
                            isFavorite = !isFavorite;
                            if (isFavorite) {
                              addToFav(
                                  image: document['image'],
                                  name: document['name'],
                                  category: document['category'],
                                  time: time,
                                  idNum: document['idnum'],
                                  oldPrice: document['oldprice'],
                                  newPrice: document['newprice']);
                            } else {
                              deleteFromFav(idNum: document['idnum']);
                            }
                          });
                        }, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => navigateToScreen));
                        }, isFavorite,
                            image: document['image'],
                            name: document['name'],
                            newPrice: document['newprice'],
                            oldPrice: document['oldprice'])),
                  ]);
                } else if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void showSnackbarWithAnimation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        animation: CurvedAnimation(
            parent: AnimationMax(
                kAlwaysCompleteAnimation, kAlwaysDismissedAnimation),
            curve: Curves.easeInOutCirc),
        content: Container(
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.grey)
          ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              Lottie.asset('assets/Animations/cart.json',
                  width: 100, height: 100),
              const SizedBox(width: 10),
              Text('Added To Cart',
                  style:
                      TextStyle(color: Colors.purple.shade800, fontSize: 16)),
            ],
          ),
        ),
        elevation: 5,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

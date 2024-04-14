import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/pre_builds/prebuild_item_details.dart';
import 'package:prosample_1/User/products/chairs/chairs_item_details.dart';
import 'package:prosample_1/User/products/monitor/monitor_item_details.dart';
import 'package:prosample_1/User/products/mouse/mouse_item_details.dart';
import 'package:prosample_1/User/products/cabinet/cabinet_item_details.dart';
import 'package:prosample_1/User/products/cables/cable_item_details.dart';
import 'package:prosample_1/User/products/cooler/cooler_item_details.dart';
import 'package:prosample_1/User/products/gpu/gpu_item_details.dart';
import 'package:prosample_1/User/products/headset/headset_item_details.dart';
import 'package:prosample_1/User/products/keyboard/keyboard_item_details.dart';
import 'package:prosample_1/User/products/motherboard/motherboard_item_details.dart';
import 'package:prosample_1/User/products/processor/processor_item_details.dart';
import 'package:prosample_1/User/products/psu/psu_item_details.dart';
import 'package:prosample_1/User/products/ram/ram_item_details.dart';
import 'package:prosample_1/User/products/ssd/ssd_item_details.dart';
import 'package:prosample_1/User/cart/cart_buynow_address.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_product_info1.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/admin/const/variables.dart';
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
            item[uid] == FirebaseAuth.instance.currentUser!.uid &&
            item[uniqueId] == widget.idNum);
      });
    });
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    final favRef = FirebaseFirestore.instance
        .collection(user)
        .doc(user)
        .collection(favorites)
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
                item[uid] = user;
                addAmount(
                    newPrice: item[newPrice],
                    oldPrice: item[oldPrice],
                    idNum: item[uniqueId],
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
                item[uid] = user;
                userDetails(idNum: item[uniqueId], time: time);
                addAmount(
                    oldPrice: item[oldPrice],
                    newPrice: item[newPrice],
                    idNum: item[uniqueId],
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
                  .where(uniqueId, isEqualTo: widget.idNum)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  final document = snapshot.data!.docs.first.data();
                  data = {
                    itemImage: document[itemImage],
                    name: document[name],
                    uniqueId: document[uniqueId],
                    oldPrice: document[oldPrice],
                    newPrice: document[newPrice],
                    category: document[category],
                  };
                  Widget navigateToScreen;
                  if (document[category] == cabinet) {
                    navigateToScreen = ScreenCabinetInfo(cabinet: document);
                  } else if (document[category] == cable) {
                    navigateToScreen = ScreenCableInfo(cable: document);
                  } else if (document[category] == chair) {
                    navigateToScreen = ScreenChairInfo(chair: document);
                  } else if (document[category] == cooler) {
                    navigateToScreen = ScreenCoolerInfo(cooler: document);
                  } else if (document[category] == gpu) {
                    navigateToScreen = ScreenGpuInfo(gpu: document);
                  } else if (document[category] == headset) {
                    navigateToScreen = ScreenHeadsetsInfo(headset: document);
                  } else if (document[category] == keyboard) {
                    navigateToScreen = ScreenKeyboardInfo(keyboard: document);
                  } else if (document[category] == monitor) {
                    navigateToScreen = ScreenMonitorInfo(monitor: document);
                  } else if (document[category] == motherboard) {
                    navigateToScreen = ScreenMotherboardInfo(board: document);
                  } else if (document[category] == mouse) {
                    navigateToScreen = ScreenMouseInfo(mouse: document);
                  } else if (document[category] == processor) {
                    navigateToScreen = ScreenProcessorInfo(cpu: document);
                  } else if (document[category] == psu) {
                    navigateToScreen = ScreenPsuInfo(psu: document);
                  } else if (document[category] == ram) {
                    navigateToScreen = ScreenRamInfo(ram: document);
                  } else if (document[category] == ssd) {
                    navigateToScreen = ScreenSsdInfo(ssd: document);
                  } else if (document[category] == preBuild) {
                    navigateToScreen = ScreenPrebuildInfo(pc: document);
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
                                  image: document[itemImage],
                                  name: document[name],
                                  category: document[category],
                                  time: time,
                                  idNum: document[uniqueId],
                                  oldPrice: document[oldPrice],
                                  newPrice: document[newPrice]);
                            } else {
                              deleteFromFav(idNum: document[uniqueId]);
                            }
                          });
                        }, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => navigateToScreen));
                        }, isFavorite,
                            image: document[itemImage],
                            name: document[name],
                            newPrice: document[newPrice],
                            oldPrice: document[oldPrice])),
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
              Lottie.asset('assets/animations/cart.json',
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

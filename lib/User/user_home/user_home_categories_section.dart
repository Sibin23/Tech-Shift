import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/Products/monitor/monitor_item_list.dart';
import 'package:prosample_1/User/Products/mouse/mouse_item_list.dart';
import 'package:prosample_1/User/Products/cabinet/cabinet_item_list.dart';
import 'package:prosample_1/User/Products/cables/cables_item_list.dart';
import 'package:prosample_1/User/Products/chairs/chairs_item_list.dart';
import 'package:prosample_1/User/Products/cooler/cooler_item_list.dart';
import 'package:prosample_1/User/Products/gpu/gpu_item_list.dart';
import 'package:prosample_1/User/Products/headset/headset_item_list.dart';
import 'package:prosample_1/User/Products/keyboard/keyboard_item_list.dart';
import 'package:prosample_1/User/Products/motherboard/motherboard_item_list.dart';
import 'package:prosample_1/User/Products/processor/processor_item_list.dart';
import 'package:prosample_1/User/Products/psu/psu_item_list.dart';
import 'package:prosample_1/User/Products/ram/ram_item_list.dart';
import 'package:prosample_1/User/Products/ssd/ssd_item_list.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text(
            'Categories',
            style: TextStyling.titleText,
          ),
          Text('Products From These Category Oftern Buy',
              style: TextStyling.categoryText),
          const SizedBox(height: 20),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.24,
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('admin').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        String imageUrl = document['image'];
                        String categoryName = document['name'];
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () {
                              if (document['categoryid'] == 'processor') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            const ProductProcessor()));
                              } else if (document['categoryid'] ==
                                  'motherboard') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            const ProductMotherboard()));
                              } else if (document['categoryid'] == 'cabinet') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            const ProductCabinet()));
                              } else if (document['categoryid'] == 'ssd') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => const ProductSSD()));
                              } else if (document['categoryid'] == 'ram') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => const ProductRam()));
                              } else if (document['categoryid'] == 'psu') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => const ProductPsu()));
                              } else if (document['categoryid'] == 'cable') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            const ProductCable()));
                              } else if (document['categoryid'] == 'gpu') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => const ProductGpu()));
                              } else if (document['categoryid'] == 'headset') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            const ProductHeadset()));
                              } else if (document['categoryid'] == 'chair') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            const ProductChair()));
                              } else if (document['categoryid'] == 'cooler') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            const ProductCooler()));
                              } else if (document['categoryid'] == 'keyboard') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            const ProductKeyboard()));
                              } else if (document['categoryid'] == 'monitor') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            const ProductMonitor()));
                              } else if (document['categoryid'] == 'mouse') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            const ProductMouse()));
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 4.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(2.0, 2.3),
                                    )
                                  ]),
                              width: MediaQuery.of(context).size.width * 0.38,
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.99,
                                      height: 120,
                                      child: CachedNetworkImage(
                                        imageUrl: imageUrl,
                                        fit: BoxFit.cover,
                                      )),
                                  Text(categoryName,
                                      style: TextStyling.categoryText),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/Home/add_category.dart';
import 'package:prosample_1/admin/Home/categories/cabinet.dart';
import 'package:prosample_1/admin/Home/categories/cables.dart';
import 'package:prosample_1/admin/Home/categories/cooler.dart';
import 'package:prosample_1/admin/Home/categories/chair.dart';
import 'package:prosample_1/admin/Home/categories/headset.dart';
import 'package:prosample_1/admin/Home/categories/keyboard.dart';
import 'package:prosample_1/admin/Home/categories/monitor.dart';
import 'package:prosample_1/admin/Home/categories/motherboard.dart';
import 'package:prosample_1/admin/Home/categories/mouse.dart';
import 'package:prosample_1/admin/Home/categories/processor.dart';
import 'package:prosample_1/admin/Home/categories/psu.dart';
import 'package:prosample_1/admin/Home/categories/ram.dart';
import 'package:prosample_1/admin/Home/categories/ssd.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class ListCategory extends StatefulWidget {
  const ListCategory({super.key});

  @override
  State<ListCategory> createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.appTheme,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const ScreenCategory()));
              },
              icon: const Icon(
                Icons.add_to_queue_rounded,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('admin')
                      .orderBy('name')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot document =
                              snapshot.data!.docs[index];
                          // ignore: unused_local_variable
                          String id = document['categoryid'];
                          String imageUrl = document['image'];
                          String categoryName = document['name'];

                          return GestureDetector(
                            onTap: () {
                              if (document['categoryid'] == 'cooler') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => const ListCooler()),
                                );
                              } else if (document['categoryid'] == 'cable') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => const ListCables()),
                                );
                              } else if (document['categoryid'] == 'cabinet') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const ListCabinet()),
                                );
                              }else if(document['categoryid'] == 'chair'){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const ListChair()),
                                );
                              }else if(document['categoryid'] == 'headset'){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const ListHeadset()),
                                );
                              }else if(document['categoryid'] == 'keyboard'){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const ListKeyboard()),
                                );
                              }else if(document ['categoryid'] == 'mouse'){
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const ListMouse()),
                                );
                              }else if(document['categoryid'] == 'monitor'){
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx1) =>
                                          const ListMonitor()),
                                );
                              }else if(document['categoryid'] == 'motherboard'){
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx1) =>
                                          const ListMotherboard()),
                                );
                              }else if(document['categoryid'] == 'psu'){
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const ListPsu()),
                                );
                              }else if(document['categoryid'] == 'processor'){
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const ListProcessor()),
                                );
                              }else if(document['categoryid'] == 'ram'){
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const ListRam()),
                                );
                              }else if(document['categoryid'] == 'ssd'){
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const ListSsd()),
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 4, bottom: 4, left: 10, right: 10),
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 10.0,
                                        spreadRadius: 1.0,
                                        offset: Offset(3.0, 3.0),
                                      )
                                    ],
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .3,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                                child: CachedNetworkImage(
                                                  imageUrl: imageUrl,fit: BoxFit.cover, placeholder: (context, url) {
                                                    return const Center(child: CircularProgressIndicator());
                                                  },
                                                  // child: Image.network(
                                                  //   imageUrl,
                                                  //   fit: BoxFit.cover,
                                                  // ),
                                                )),
                                            const SizedBox(width: 30),
                                            Text(
                                              categoryName,
                                              style:
                                                  CustomText.categoryTitleText,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }))),
    );
  }
}

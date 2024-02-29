import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/Home/categories/psu.dart';
import 'package:prosample_1/admin/Home/inventory/Cabinet/cabinet_list.dart';
import 'package:prosample_1/admin/Home/inventory/Cables/cable_list.dart';
import 'package:prosample_1/admin/Home/inventory/Chairs/chair_list.dart';
import 'package:prosample_1/admin/Home/inventory/Coolers/cooler_list.dart';
import 'package:prosample_1/admin/Home/inventory/Headset/details_headset.dart';
import 'package:prosample_1/admin/Home/inventory/Keyboard/list_keyboard.dart';
import 'package:prosample_1/admin/Home/inventory/Monitor/add_monitor.dart';
import 'package:prosample_1/admin/Home/inventory/MotherBoard/add_motherboard.dart';
import 'package:prosample_1/admin/Home/inventory/Mouse/add_mouse.dart';
import 'package:prosample_1/admin/Home/inventory/RAM/add_ram.dart';
import 'package:prosample_1/admin/Home/inventory/SSD/add_ssd.dart';
import 'package:prosample_1/admin/Home/inventory/processor/details.dart';
import 'package:prosample_1/admin/utils/colors.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class ScreenItemDetails extends StatefulWidget {
  const ScreenItemDetails({super.key});

  @override
  State<ScreenItemDetails> createState() => _ScreenItemDetailsState();
}

class _ScreenItemDetailsState extends State<ScreenItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Select Category',style: CustomText.apptitle),
        backgroundColor: CustomColors.appTheme,
       leading: IconButton(onPressed: (){
        Navigator.pop(context);
       }, icon: const Icon(Icons.arrow_back,color: Colors.white),),
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
                                      builder: (ctx) => const CoolerDetails()),
                                );
                              } else if (document['categoryid'] == 'cable') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => const CableDetails()),
                                );
                              } else if (document['categoryid'] == 'cabinet') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const CabinetDetails()),
                                );
                              }else if(document['categoryid'] == 'chair'){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const ChairDetails()),
                                );
                              }else if(document['categoryid'] == 'headset'){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const HeadsetDetails()),
                                );
                              }else if(document['categoryid'] == 'keyboard'){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const KeyboardDetails()),
                                );
                              }else if(document ['categoryid'] == 'mouse'){
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const ScreenAddMouse()),
                                );
                              }else if(document['categoryid'] == 'monitor'){
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx1) =>
                                          const ScreenAddMonitor()),
                                );
                              }else if(document['categoryid'] == 'motherboard'){
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx1) =>
                                          const ScreenAddMotherboard())
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
                                          const UpdateProcessor()));
                                
                              }else if(document['categoryid'] == 'ram'){
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const ScreenAddRam()),
                                );
                              }else if(document['categoryid'] == 'ssd'){
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const ScreenAddSsd()),
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
                                                  }
                                                 
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

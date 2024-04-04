import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/Home/inventory/Cabinet/cabinet_list.dart';
import 'package:prosample_1/admin/Home/inventory/Cables/cable_list.dart';
import 'package:prosample_1/admin/Home/inventory/Chairs/chair_list.dart';
import 'package:prosample_1/admin/Home/inventory/Coolers/cooler_list.dart';
import 'package:prosample_1/admin/Home/inventory/Headset/details_headset.dart';
import 'package:prosample_1/admin/Home/inventory/Keyboard/list_keyboard.dart';
import 'package:prosample_1/admin/Home/inventory/Monitor/monitor_list.dart';
import 'package:prosample_1/admin/Home/inventory/MotherBoard/motherboard_list.dart';
import 'package:prosample_1/admin/Home/inventory/Mouse/mouse_list.dart';
import 'package:prosample_1/admin/Home/inventory/PSU/psu_list.dart';
import 'package:prosample_1/admin/Home/inventory/RAM/ram_list.dart';
import 'package:prosample_1/admin/Home/inventory/SSD/ssd_list.dart';
import 'package:prosample_1/admin/Home/inventory/gpu/gpu_list.dart';
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
        backgroundColor: CustomColors.appTheme,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Select any Category here to Add Inventory', style: CustomText.title2),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('admin')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                mainAxisExtent: 180,
                              ),
                              itemBuilder: ((context, index) {
                                DocumentSnapshot document =
                                    snapshot.data!.docs[index];
                                
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5, top: 5, bottom: 5),
                                  child: GestureDetector(
                                      onTap: () {
                                        if (document['categoryid'] ==
                                            'cooler') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    const CoolerDetails()),
                                          );
                                        } else if (document['categoryid'] ==
                                            'cable') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    const CableDetails()),
                                          );
                                        } else if (document['categoryid'] ==
                                            'cabinet') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    const CabinetDetails()),
                                          );
                                        } else if (document['categoryid'] ==
                                            'chair') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    const ChairDetails()),
                                          );
                                        } else if (document['categoryid'] ==
                                            'headset') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    const HeadsetDetails()),
                                          );
                                        } else if (document['categoryid'] ==
                                            'keyboard') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    const KeyboardDetails()),
                                          );
                                        } else if (document['categoryid'] ==
                                            'mouse') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    const MouseDetails()),
                                          );
                                        } else if (document['categoryid'] ==
                                            'gpu') {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      const GpuDetails()));
                                        } else if (document['categoryid'] ==
                                            'monitor') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx1) =>
                                                    const MonitorDetails()),
                                          );
                                        } else if (document['categoryid'] ==
                                            'motherboard') {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ctx1) =>
                                                      const MotherboardDetails()));
                                        } else if (document['categoryid'] ==
                                            'psu') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    const PsuDetails()),
                                          );
                                        } else if (document['categoryid'] ==
                                            'processor') {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      const UpdateProcessor()));
                                        } else if (document['categoryid'] ==
                                            'ram') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    const RamDetails()),
                                          );
                                        } else if (document['categoryid'] ==
                                            'ssd') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    const SsdDetails()),
                                          );
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: const Offset(2, 2),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                            )
                                          ],
                                         
                                        ),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 1,
                                                    blurRadius: 2,
                                                    color: Colors.grey)
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.11,
                                                      child: CachedNetworkImage(
                                                        imageUrl: document['image'],
                                                        fit: BoxFit.cover,
                                                        placeholder:
                                                            (context, url) {
                                                          return const Center(child: CircularProgressIndicator());
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                               Text(document['name'],style: CustomText.title3,)
                                             
                                              ],
                                            ),
                                          ),
                                        ),
                                      )),
                                );
                              })),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

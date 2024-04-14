import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/const/variables.dart';
import 'package:prosample_1/admin/home/inventory/Cabinet/cabinet_list.dart';
import 'package:prosample_1/admin/home/inventory/Cables/cable_list.dart';
import 'package:prosample_1/admin/home/inventory/Chairs/chair_list.dart';
import 'package:prosample_1/admin/home/inventory/Coolers/cooler_list.dart';
import 'package:prosample_1/admin/home/inventory/Keyboard/list_keyboard.dart';
import 'package:prosample_1/admin/home/inventory/Monitor/monitor_list.dart';
import 'package:prosample_1/admin/home/inventory/MotherBoard/motherboard_list.dart';
import 'package:prosample_1/admin/home/inventory/Mouse/mouse_list.dart';
import 'package:prosample_1/admin/home/inventory/PSU/psu_list.dart';
import 'package:prosample_1/admin/home/inventory/RAM/ram_list.dart';
import 'package:prosample_1/admin/home/inventory/SSD/ssd_list.dart';
import 'package:prosample_1/admin/home/inventory/gpu/gpu_list.dart';
import 'package:prosample_1/admin/home/inventory/headset/headset_list.dart';
import 'package:prosample_1/admin/home/inventory/processor/processor_list.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';

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
        title: const Text('Select Category'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(admBoxImg),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('admin').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  child: GridView.builder(
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
                        DocumentSnapshot document = snapshot.data!.docs[index];

                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, top: 5, bottom: 5),
                          child: GestureDetector(
                              onTap: () {
                                if (document['categoryid'] == 'cooler') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            const CoolerDetails()),
                                  );
                                } else if (document['categoryid'] == 'cable') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => const CableDetails()),
                                  );
                                } else if (document['categoryid'] ==
                                    'cabinet') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            const CabinetDetails()),
                                  );
                                } else if (document['categoryid'] == 'chair') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => const ChairDetails()),
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
                                } else if (document['categoryid'] == 'mouse') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => const MouseDetails()),
                                  );
                                } else if (document['categoryid'] == 'gpu') {
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
                                } else if (document['categoryid'] == 'psu') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => const PsuDetails()),
                                  );
                                } else if (document['categoryid'] ==
                                    'processor') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              const UpdateProcessor()));
                                } else if (document['categoryid'] == 'ram') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => const RamDetails()),
                                  );
                                } else if (document['categoryid'] == 'ssd') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => const SsdDetails()),
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid),
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.11,
                                            child: CachedNetworkImage(
                                              imageUrl: document[itemImage],
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        document[name],
                                        style: CustomText.subtitle,
                                      )
                                    ],
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
      )),
    );
  }
}

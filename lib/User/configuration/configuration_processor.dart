import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/configuration/configuration_screen/configuration_screen_details.dart';
import 'package:prosample_1/User/configuration/details/details_cpu.dart';
import 'package:prosample_1/User/configuration/configuration_motherboard.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget2.dart';

class ProcessorConfig extends StatefulWidget {
  const ProcessorConfig({
    super.key,
  });

  @override
  State<ProcessorConfig> createState() => _ProcessorConfigState();
}

class _ProcessorConfigState extends State<ProcessorConfig> {
  String? selectedSocket;
  String? selectedName;
  String? selectedDocumentId;
  String? seletectedPrice;
  String? selectedTdp;

  @override
  Widget build(BuildContext context) {
    seletectedPrice ??= '0';
    selectedName ??= 'Select a Processor';
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              Map<String, dynamic> pc = {
                'processor': selectedName.toString(),
                'processorprice': seletectedPrice.toString(),
              };
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => ConfigDetails1(pc: pc)));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(color: AppColors.appTheme, spreadRadius: 2)
                ]),
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.height * 0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info, color: AppColors.appTheme),
                    const SizedBox(width: 5),
                    Text(
                        '₹ $seletectedPrice'.toString().replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => "${m[1]},"),
                        style: TextStyling.subtitleapptheme)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: UiCustom.bottomNextButton(context, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => const ScreenBuild()));
      }, () {
        if (selectedDocumentId == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 3),
              content: Center(
                  child: Text(
                'Please select a processor',
                style: TextStyling.subtitleWhite,
              )),
              backgroundColor: const Color.fromARGB(255, 245, 62, 49),
            ),
          );
        } else {
          var processorSocket = selectedSocket.toString();
          Map<String, dynamic> pc = {
            'processor': selectedName.toString(),
            'processorprice': seletectedPrice.toString(),
          };
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => MotherboardConfig(
                        power: selectedTdp.toString(),
                        pc: pc,
                        socket: processorSocket,
                        price: seletectedPrice.toString(),
                      )));
        }
      }),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Processor', style: TextStyling.titleText),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('processor')
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
                                mainAxisExtent: 220,
                              ),
                              itemBuilder: ((context, index) {
                                DocumentSnapshot document =
                                    snapshot.data!.docs[index];
                                String imageUrl = document['image'];
                                String name = document['name'];
                                String cores = document['cores'];
                                String threads = document['threads'];
                                String speed = document['speed'];
                                String price = document['newprice'];
                                String socket = document['socket'];
                                String power = document['tdp'];
                                bool isSelected =
                                    document.id == selectedDocumentId;
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5, top: 5, bottom: 5),
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (isSelected) {
                                            selectedDocumentId = null;
                                            selectedSocket = null;
                                            selectedName = null;
                                            seletectedPrice = null;
                                            selectedTdp = null;
                                          } else {
                                            selectedDocumentId = document.id;
                                            selectedSocket = socket;
                                            selectedName = name;
                                            seletectedPrice = price;
                                            selectedTdp = power;
                                          }
                                          isSelected = !isSelected;
                                        });
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
                                          border: isSelected
                                              ? Border.all(
                                                  color: AppColors.appTheme,
                                                  width: 2,
                                                )
                                              : null,
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
                                                        imageUrl: imageUrl,
                                                        fit: BoxFit.cover,
                                                        placeholder:
                                                            (context, url) {
                                                          return Image.asset(
                                                              'assets/categories/processor.png',fit: BoxFit.cover);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(name,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            softWrap: false,
                                                            maxLines: 1,
                                                            style: TextStyling
                                                                .subtitle2),
                                                        const SizedBox(
                                                            height: 5),
                                                        Row(
                                                          children: [
                                                            Text('$cores,',
                                                                style: TextStyling
                                                                    .categoryText),
                                                            const SizedBox(
                                                                width: 2),
                                                            Text(threads,
                                                                style: TextStyling
                                                                    .categoryText)
                                                          ],
                                                        ),
                                                        Text(speed,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            softWrap: false,
                                                            style: TextStyling
                                                                .categoryText)
                                                      ],
                                                    )),
                                                const SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    const Text('₹'),
                                                    const SizedBox(width: 2),
                                                    Text(
                                                        price.replaceAllMapped(
                                                            RegExp(
                                                                r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                            (Match m) =>
                                                                "${m[1]},"),
                                                        style:
                                                            TextStyling.newP),
                                                  ],
                                                ),
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

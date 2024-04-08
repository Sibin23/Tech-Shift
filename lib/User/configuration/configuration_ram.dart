import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/configuration/details/details_ram.dart';
import 'package:prosample_1/User/configuration/configuration_ssd.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget2.dart';

class RamConfig extends StatefulWidget {
  final Map<String, dynamic> pc;
  final String power;
  final String ramType;
  final String ssdType;
  final String total;
  final Map<String, dynamic> config;
  const RamConfig(
      {super.key,
      required this.power,
      required this.total,
      required this.ramType,
      required this.ssdType,
      required this.pc,
      required this.config});

  @override
  State<RamConfig> createState() => _RamConfigState();
}

class _RamConfigState extends State<RamConfig> {
  String? selectedDocumentId;
  String? selectedPrice;
  String? selectedRam;
  String? selectedPower;
  @override
  Widget build(BuildContext context) {
    selectedPower ??= 0.toString();
    int totalPwr =
        int.parse(widget.power) + int.parse(selectedPower.toString()) + 50;
    final ram = widget.ramType;
    String amt = widget.total;
    selectedPrice ??= 0.toString();
    int total = int.parse(amt) + int.parse(selectedPrice.toString());
    selectedPrice ??= 0.toString();
    selectedRam ??= 'Select a RAM';
    return Scaffold(
      appBar: AppBar(
       
        surfaceTintColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              final pc = Map<String, dynamic>.from(widget.pc);
              pc['ram'] = selectedRam;
              pc['ramprice'] = selectedPrice;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => ConfigDetails3(
                            pc: pc,
                            total: total.toString(),
                          )));
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
                        '₹ $total'.replaceAllMapped(
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
        Navigator.pop(context);
      }, () {
        if (selectedDocumentId == null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 3),
            content: Center(
                child: Text(
              'Please select a RAM (Memory)',
              style: TextStyling.subtitleWhite,
            )),
            backgroundColor: const Color.fromARGB(255, 245, 62, 49),
          ));
        } else {
          final pc = Map<String, dynamic>.from(widget.pc);
          pc['ram'] = selectedRam;
          pc['ramprice'] = selectedPrice;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => SsdConfig(
                        power: totalPwr.toString(),
                        pc: pc,
                        total: total.toString(),
                        ssdType: widget.ssdType,
                      )));
        }
      }),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text('Random Access Memory (RAM)', style: TextStyling.titleText),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('ram')
                        .where('ramtype', isGreaterThanOrEqualTo: ram)
                        .where('ramtype', isLessThanOrEqualTo: '$ram.9')
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
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 5,
                                mainAxisExtent: 220,
                              ),
                              itemBuilder: ((context, index) {
                                DocumentSnapshot document =
                                    snapshot.data!.docs[index];
                                String imageUrl = document['image'];
                                String name = document['name'];
                                String speed = document['clockspeed'];
                                String type = document['ramtype'];
                                String size = document['ramsize'];
                                String price = document['newprice'];
                                bool isSelected =
                                    document.id == selectedDocumentId;
                                return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: GestureDetector(
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (isSelected) {
                                                selectedDocumentId = null;

                                                selectedRam = null;
                                                selectedPrice = null;
                                              } else {
                                                selectedDocumentId =
                                                    document.id;
                                                selectedRam = name;
                                                selectedPrice = price;
                                              }
                                              isSelected = !isSelected;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: const Offset(2, 2),
                                                  spreadRadius: 1,
                                                  blurRadius: 2,
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        spreadRadius: 1,
                                                        blurRadius: 2,
                                                        color: Colors.grey)
                                                  ]),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.35,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.11,
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: imageUrl,
                                                          fit: BoxFit.cover,
                                                          placeholder:
                                                              (context, url) => Image.asset('assets/categories/ram.png',fit: BoxFit.cover,)
                                                        )),
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                context)
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
                                                                maxLines: 1,
                                                                softWrap: false,
                                                                style: TextStyling
                                                                    .subtitle2),
                                                            const SizedBox(
                                                                height: 5),
                                                            Row(
                                                              children: [
                                                                Text('$size,',
                                                                    style: TextStyling
                                                                        .categoryText),
                                                                const SizedBox(
                                                                    width: 3),
                                                                Text(type,
                                                                    style: TextStyling
                                                                        .categoryText),
                                                              ],
                                                            ),
                                                            Text(speed,
                                                                style: TextStyling
                                                                    .categoryText),
                                                          ],
                                                        )),
                                                    const SizedBox(height: 10),
                                                    Row(
                                                      children: [
                                                        const Text('₹'),
                                                        const SizedBox(
                                                            width: 2),
                                                        Text(
                                                            price.replaceAllMapped(
                                                                RegExp(
                                                                    r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                                (Match m) =>
                                                                    "${m[1]},"),
                                                            style: TextStyling
                                                                .newP),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                    ));
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/Build%20page/details/fourth_detail.dart';
import 'package:prosample_1/User/Build%20page/gpu.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';
import 'package:prosample_1/User/utils/widget2.dart';

class SsdConfig extends StatefulWidget {
  final String power;
  final String total;
  final Map<String, dynamic> pc;
  final String ssdType;
  final Map<String, dynamic> config;
  const SsdConfig(
      {super.key,
      required this.ssdType,
      required this.total,
      required this.power,
      required this.pc,
      required this.config});

  @override
  State<SsdConfig> createState() => _SsdConfigState();
}

class _SsdConfigState extends State<SsdConfig> {
  String? selectedDocumentId;
  String? selectedSsd;
  String? selectedPrice;
  String? selectedGen;
  String? selectedPower;
  @override
  Widget build(BuildContext context) {
    final ssd = widget.ssdType;
    selectedPower ??= 0.toString();
    int totalPwr =
        int.parse(widget.power) + int.parse(selectedPower.toString());
    String amt = widget.total;
    selectedPrice ??= 0.toString();
    int total = int.parse(amt) + int.parse(selectedPrice.toString());
    selectedPrice ??= 0.toString();
    selectedSsd ??= 'Select a SSD (Storage)';
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              final pc = Map<String, dynamic>.from(widget.pc);
              pc['ssd'] = selectedSsd;
              pc['ssdprice'] = selectedPrice;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => ConfigDetail4(
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 3),
              content: Center(
                  child: Text(
                'Please select a SSD (Storage)',
                style: TextStyling.subtitleWhite,
              )),
              backgroundColor: const Color.fromARGB(255, 245, 62, 49),
            ),
          );
        } else {
          final updatedConfig = Map<String, dynamic>.from(widget.config);
          updatedConfig['ssd'] = selectedDocumentId;

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => GpuConfig(
                        power: totalPwr.toString(),
                        ssd: selectedGen.toString(),
                        config: updatedConfig,
                      )));
        }
      }),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('ssd')
                .where('gentype', isGreaterThanOrEqualTo: ssd)
                .where('gentype', isLessThanOrEqualTo: '$ssd.9')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  child: GridView.builder(
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
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        String imageUrl = document['image'];
                        String name = document['name'];
                        String price = document['newprice'];
                        String storage = document['storage'];
                        String speed = document['transferspeed'];
                        String gen = document['gentype'];
                        String wattage = document['wattage'];
                        final bool isSelected =
                            document.id == selectedDocumentId;
                        return Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: GestureDetector(
                              onTap: () => setState(() {
                                    selectedDocumentId = document.id;
                                    selectedSsd = name;
                                    selectedPrice = price;
                                    selectedGen = gen;
                                    selectedPower = wattage;
                                  }),
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
                                      color: Colors.grey.withOpacity(0.3),
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
                                          BorderRadius.all(Radius.circular(5)),
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
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.11,
                                          child: Image.network(imageUrl,
                                              fit: BoxFit.cover),
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    maxLines: 1,
                                                    style:
                                                        TextStyling.subtitle2),
                                                const SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Text('$storage,',
                                                        style: TextStyling
                                                            .categoryText),
                                                    const SizedBox(width: 3),
                                                    Text(gen,
                                                        style: TextStyling
                                                            .categoryText)
                                                  ],
                                                ),
                                                Text(speed,
                                                    style: TextStyling
                                                        .categoryText),
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
                                                    (Match m) => "${m[1]},"),
                                                style: TextStyling.newP),
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
      )),
    );
  }
}

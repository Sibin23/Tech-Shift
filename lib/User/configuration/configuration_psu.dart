import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/configuration/details/details_configured_page.dart';
import 'package:prosample_1/User/configuration/details/details_psu.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget2.dart';
import 'package:prosample_1/admin/const/variables.dart';

class PsuConfig extends StatefulWidget {
  final String power;
  final Map<String, dynamic> pc;
  final String price;
  const PsuConfig(
      {super.key, required this.pc, required this.power, required this.price});

  @override
  State<PsuConfig> createState() => _PsuConfigState();
}

class _PsuConfigState extends State<PsuConfig> {
  String? selectedDocumentId;
  String? selectedPsu;
  String? selectedPrice;
  String? selectedPower;
  @override
  Widget build(BuildContext context) {
    selectedPrice ??= 0.toString();
    selectedPsu ??= 'Select a PSU';
    int totalAmt =
        int.parse(widget.price) + int.parse(selectedPrice.toString());
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              final pc = Map<String, dynamic>.from(widget.pc);
              pc[psu] = selectedPsu;
              pc['psuprice'] = selectedPrice;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => ConfigDetail8(
                          pc: pc, totalAmt: totalAmt.toString())));
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
                        '₹ $totalAmt'.replaceAllMapped(
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
              content: Text(
                'Please select a Power Supply Unit',
                style: TextStyling.subtitleWhite,
              ),
              backgroundColor: const Color.fromARGB(255, 245, 62, 49)));
        } else {
          final pc = Map<String, dynamic>.from(widget.pc);
          pc[psu] = selectedPsu;
          pc['psuprice'] = selectedPrice;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) =>
                      ConfigDetail(pc: pc, totalAmt: totalAmt.toString())));
        }
      }),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Power Supply Unit (PSU)', style: TextStyling.titleText),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(psu)
                      .where(wattage, isGreaterThan: widget.power)
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
                              mainAxisExtent: 230,
                            ),
                            itemBuilder: ((context, index) {
                              DocumentSnapshot document =
                                  snapshot.data!.docs[index];

                              final bool isSelected =
                                  document.id == selectedDocumentId;
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, top: 5, bottom: 5),
                                child: GestureDetector(
                                    onTap: () => setState(() {
                                          if (isSelected) {
                                            selectedDocumentId = null;
                                            selectedPsu = null;
                                            selectedPrice = null;
                                            selectedPower = null;
                                          } else {
                                            selectedDocumentId = document.id;
                                            selectedPsu = document[name];
                                            selectedPrice = document[newPrice];
                                            selectedPower = document[wattage];
                                          }
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
                                                        imageUrl:
                                                            document[itemImage],
                                                        fit: BoxFit.cover,
                                                        placeholder: (context,
                                                                url) =>
                                                            Image.asset(
                                                                'assets/categories/psu.png',
                                                                fit: BoxFit
                                                                    .cover)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(document[name],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          softWrap: false,
                                                          maxLines: 1,
                                                          style: TextStyling
                                                              .subtitle2),
                                                      const SizedBox(height: 4),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              '${document[wattage]}W, ',style: TextStyling
                                                                .categoryText),
                                                          Text(document[
                                                              formFactor],style: TextStyling
                                                                .categoryText)
                                                        ],
                                                      ),
                                                      Text(document[certified],style: TextStyling
                                                                .categoryText)
                                                    ],
                                                  )),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  const Text('₹'),
                                                  const SizedBox(width: 2),
                                                  Text(
                                                      document[newPrice]
                                                          .replaceAllMapped(
                                                              RegExp(
                                                                  r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                              (Match m) =>
                                                                  "${m[1]},"),
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
            ),
          ],
        ),
      )),
    );
  }
}

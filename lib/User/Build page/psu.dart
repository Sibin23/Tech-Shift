import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class PsuConfig extends StatefulWidget {
  const PsuConfig({super.key});

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
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('psu').snapshots(),
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
                        mainAxisExtent: 220,
                      ),
                      itemBuilder: ((context, index) {
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        String imageUrl = document['image'];
                        String name = document['name'];
                        String cores = document['cores'];
                        String threads = document['threads'];
                        String speed = document['speed'];
                        String price = document['newprice'];
                        String socket = document['socket'];
                        String power = document['tdp'];
                        final bool isSelected =
                            document.id == selectedDocumentId;
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, top: 5, bottom: 5),
                          child: GestureDetector(
                              onTap: () => setState(() {
                                    selectedDocumentId = document.id;
                                    selectedPsu = name;
                                    selectedPrice = price;
                                    selectedPower = power;
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
                                                imageUrl: imageUrl,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) {
                                                  return Center(
                                                    child: Image.asset(
                                                        'assets/Processors/processor.png'),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
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
                                                    Text('$cores,',
                                                        style: TextStyling
                                                            .categoryText),
                                                    const SizedBox(width: 2),
                                                    Text(threads,
                                                        style: TextStyling
                                                            .categoryText)
                                                  ],
                                                ),
                                                Text(speed,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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

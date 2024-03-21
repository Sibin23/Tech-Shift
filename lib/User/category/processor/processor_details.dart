import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/category/processor/info.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class DetailsProcessor extends StatefulWidget {
  const DetailsProcessor({super.key});

  @override
  State<DetailsProcessor> createState() => _DetailsProcessorState();
}

class _DetailsProcessorState extends State<DetailsProcessor> {
  final Map<String, bool> favorites = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
        ),
        body: SafeArea(
            child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('processor')
                  .orderBy('name')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                mainAxisExtent: 230,
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          final document = snapshot.data!.docs[index];
                          Map<String, dynamic> cpu = {
                            'image': document['image'],
                            'name': document['name'],
                            'oldprice': document['oldprice'],
                            'newprice': document['newprice'],
                            'cache': document['cache'],
                            'category': document['category'],
                            'cooler': document['cooler'],
                            'cores': document['cores'],
                            'graghics': document['graphics'],
                            'idnum': document['idnum'],
                            'socket': document['socket'],
                            'speed': document['speed'],
                            'tdp': document['tdp'],
                            'threads': document['threads'],
                            'unlocked': document['unlocked'],
                            'warranty': document['warranty'],
                          };
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 5, bottom: 5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            ProcessorDetailScreen(cpu: cpu)));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2.0,
                                            spreadRadius: 1.0,
                                            offset: Offset(2.0, 2.0))
                                      ]),
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.13,
                                              child: CachedNetworkImage(
                                                  imageUrl: document['image'],
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      Image.asset(
                                                          'assets/Categories/processor.png',
                                                          fit: BoxFit.cover)),
                                            ),
                                            Text(document['category'],
                                                style:
                                                    TextStyling.categoryText),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .13,
                                              child: Row(
                                                children: [
                                                  Text('4.0',
                                                      style:
                                                          TextStyling.rating),
                                                  Icon(
                                                    Icons.star,
                                                    color: AppColors.appTheme,
                                                    size: 20,
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            Text(document['name'],
                                                softWrap: false,
                                                maxLines: 1,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            const SizedBox(height: 3),
                                            Row(children: [
                                              Row(children: [
                                                const Text(
                                                  '₹',
                                                ),
                                                const SizedBox(width: 2),
                                                Text(
                                                    document['oldprice']
                                                        .replaceAllMapped(
                                                            RegExp(
                                                                r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                            (Match m) =>
                                                                "${m[1]},"),
                                                    style: TextStyling
                                                        .lineThrough),
                                              ]),
                                              const SizedBox(width: 10),
                                              Row(
                                                children: [
                                                  const Text(
                                                    '₹',
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Text(
                                                      document['newprice']
                                                          .replaceAllMapped(
                                                              RegExp(
                                                                  r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                              (Match m) =>
                                                                  "${m[1]},"),
                                                      style: TextStyling.newP),
                                                ],
                                              )
                                            ])
                                          ]))),
                            ),
                          );
                        }),
                  );
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Lottie.asset(
                          'assets/Animations/Animation - 1708393071899.json')),
                );
              }),
        )));
  }
}

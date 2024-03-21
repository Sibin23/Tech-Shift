import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/Pre%20Builds/prebuild_screen.dart';
import 'package:prosample_1/User/utils/widget2.dart';

class PreBuildSection extends StatefulWidget {
  const PreBuildSection({super.key});

  @override
  State<PreBuildSection> createState() => _PreBuildSectionState();
}

class _PreBuildSectionState extends State<PreBuildSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
        ),
        body: SafeArea(
            child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('prebuild')
                  .orderBy('name')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                mainAxisExtent: 230,
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          DocumentSnapshot document =
                              snapshot.data!.docs[index];
                              String id = document.id;
                          String imageUrl = document['image'];
                          String idNum = document['idnum'];
                          String categoryName = document['categoryid'];
                          String name = document['name'];
                          String oldPrice = document['oldprice'];
                          String newPrice = document['newprice'];
                          String cabinet = document['case'];
                          String processor = document['processor'];
                          String board = document['motherboard'];
                          String ram = document['ram'];
                          String ssd = document['ssd'];
                          String expstorage = document['expstorage'];
                          String gpu = document['gpu'];
                          String features = document['features'];
                          String cooler = document['cooler'];
                          String psu = document['psu'];
                          String warranty = document['warranty'];
                          return UiCustom.preBuildCard(
                            context,
                            () {
                              Map<String, dynamic> prebuild = {
                                'docid': id,
                                'image': imageUrl,
                                'idnum': idNum,
                                'categoryid': categoryName,
                                'name': name,
                                'oldprice': oldPrice,
                                'newprice': newPrice,
                                'processor': processor,
                                'motherboard': board,
                                'ram': ram,
                                'ssd': ssd,
                                'expstorage': expstorage,
                                'gpu': gpu,
                                'features': features,
                                'cooler': cooler,
                                'psu': psu,
                                'case': cabinet,
                                'warranty': warranty
                              };
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          PreBuildInfo(prebuild: prebuild)));
                            },
                            imageUrl: imageUrl,
                            categoryName: categoryName,
                            oldPrice: oldPrice,
                            newPrice: newPrice,
                            cabinet: cabinet,
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/Products/product_details.dart';
import 'package:prosample_1/User/pre_builds/prebuild_item_list.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget2.dart';
import 'package:prosample_1/admin/const/variables.dart';

class HomePreBuildPC extends StatefulWidget {
  const HomePreBuildPC({super.key});

  @override
  State<HomePreBuildPC> createState() => _HomePreBuildPCState();
}

class _HomePreBuildPCState extends State<HomePreBuildPC> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 224, 208, 226),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.81,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text('Pre Build Pc', style: TextStyling.titleText),
          Text('Best in Class Brand Support ', style: TextStyling.categoryText),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.65,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(preBuild)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  mainAxisExtent: 230),
                          itemCount: 4,
                          itemBuilder: (ctx, index) {
                            DocumentSnapshot document =
                                snapshot.data!.docs[index];

                            return UiCustom.preBuildCard(context, () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => CheckDetails(
                                          collection: document[category],
                                          idNum: document[uniqueId])));
                            },
                                imageUrl: document[itemImage],
                                categoryName: document[category],
                                oldPrice: document[oldPrice],
                                newPrice: document[newPrice],
                                cabinet: document[cabinet]);
                          }),
                    );
                  } else {
                    const CircularProgressIndicator();
                  }
                  return const CircularProgressIndicator();
                }),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const ProductPrebuild()));
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('See All Deals', style: TextStyling.subtitle),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.purple,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

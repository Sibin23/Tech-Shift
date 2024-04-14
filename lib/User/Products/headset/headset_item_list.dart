import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/Products/product_details.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/admin/const/variables.dart';

class ProductHeadset extends StatefulWidget {
  const ProductHeadset({super.key});

  @override
  State<ProductHeadset> createState() => _ProductHeadsetState();
}

class _ProductHeadsetState extends State<ProductHeadset> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
        ),
        body: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(headset)
                    .orderBy(name)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  mainAxisExtent: 230,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            final document = snapshot.data!.docs[index];

                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 5, bottom: 5),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => CheckDetails(
                                              collection: document[category],
                                              idNum: document[uniqueId])));
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
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
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
                                                child: document[itemImage] !=
                                                        null
                                                    ? CachedNetworkImage(
                                                        imageUrl:
                                                            document[itemImage],
                                                        fit: BoxFit.cover,
                                                        placeholder: (context,
                                                                url) =>
                                                            Image.asset(
                                                                'assets/categories/headset.jpg',
                                                                fit: BoxFit
                                                                    .cover),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(
                                                                'assets/categories/headset.jpg',
                                                                fit: BoxFit
                                                                    .cover),
                                                      )
                                                    : Image.asset(
                                                        'assets/categories/headset.jpg',
                                                        fit: BoxFit.cover),
                                              ),
                                              Text(document[category],
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
                                              Text(document[name],
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
                                                      document[oldPrice]
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
                                                        document[newPrice]
                                                            .replaceAllMapped(
                                                                RegExp(
                                                                    r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                                (Match m) =>
                                                                    "${m[1]},"),
                                                        style:
                                                            TextStyling.newP),
                                                  ],
                                                )
                                              ])
                                            ]))),
                              ),
                            );
                          }),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                })));
  }
}

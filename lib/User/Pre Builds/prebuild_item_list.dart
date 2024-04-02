import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/Products/product_details.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class ProductPrebuild extends StatefulWidget {
  const ProductPrebuild({super.key});

  @override
  State<ProductPrebuild> createState() => _ProductPrebuildState();
}

class _ProductPrebuildState extends State<ProductPrebuild> {
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

                       
                          String oldPrice = document['oldprice'];
                          String newPrice = document['newprice'];
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            CheckDetails(collection: document['category'], idNum: document['idnum'])));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 4.0,
                                            spreadRadius: 1.0,
                                            offset: Offset(4.0, 4.0))
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
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.35,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.15,
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          document['image'],
                                                      fit: BoxFit.cover,
                                                      placeholder:
                                                          (context, url) {
                                                        return const Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      },
                                                    ),
                                                  )
                                                ]),
                                            Text(document['category'],
                                                style:
                                                    TextStyling.categoryText),
                                            Text(document['case'],
                                                softWrap: false,
                                                maxLines: 1,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            Text('****',
                                                style: TextStyling.subtitle),
                                            Row(children: [
                                              Row(children: [
                                                Text(
                                                  '₹',
                                                  style: TextStyling.subtitle3,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                    oldPrice.replaceAllMapped(
                                                        RegExp(
                                                            r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                        (Match m) =>
                                                            "${m[1]},"),
                                                    style: TextStyling
                                                        .lineThrough),
                                              ]),
                                              const SizedBox(width: 10),
                                              Text(
                                                  newPrice.replaceAllMapped(
                                                      RegExp(
                                                          r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                      (Match m) => "${m[1]},"),
                                                  style: TextStyling.newP)
                                            ])
                                          ]))));
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

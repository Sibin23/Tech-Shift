import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/Products/product_details.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';
import 'package:prosample_1/functions/fav_function.dart';

class ScreenFavorites extends StatefulWidget {
  const ScreenFavorites({super.key});

  @override
  State<ScreenFavorites> createState() => _ScreenFavoritesState();
}

class _ScreenFavoritesState extends State<ScreenFavorites> {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Favorites', style: TextStyling.appTitle),
        ),
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('User')
                  .doc(userId)
                  .collection('Favorites')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                      child: Text(
                    'No Favorites Yet',
                    style: TextStyling.subtitle3,
                  ));
                }
                if (snapshot.hasData) {
                  final cartItems = snapshot.data!.docs;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final document = snapshot.data!.docs[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => CheckDetails(
                                      collection: document['category'],
                                      idNum: document['idnum'])));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 8, bottom: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 3,
                                      spreadRadius: 1,
                                      offset: Offset(2, 2))
                                ]),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .3,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .12,
                                      child: CachedNetworkImage(
                                        imageUrl: document['image'],
                                        fit: BoxFit.contain,
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .55,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.165,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .4,
                                                    child:
                                                        Text(document['name'])),
                                                IconButton(
                                                    onPressed: () {
                                                      deleteFromFav(
                                                          idNum: document[
                                                              'idnum']);
                                                    },
                                                    icon: const Icon(
                                                        Icons.favorite,
                                                        color: Colors.red))
                                              ],
                                            ),
                                            Text('Qty: 1',
                                                style:
                                                    TextStyling.categoryText),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text('₹',
                                                    style:
                                                        TextStyling.subtitle),
                                                const SizedBox(width: 3),
                                                Text(
                                                    document['oldprice']
                                                        .replaceAllMapped(
                                                            RegExp(
                                                                r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                            (Match m) =>
                                                                "${m[1]},"),
                                                    style: TextStyling
                                                        .lineThrough),
                                                const SizedBox(width: 20),
                                                Text('₹',
                                                    style:
                                                        TextStyling.subtitle),
                                                const SizedBox(width: 3),
                                                Text(
                                                    document['newprice']
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ));
  }
}

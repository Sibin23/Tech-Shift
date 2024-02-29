import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class CartPreBuild extends StatefulWidget {
  final Map<String, dynamic> prebuild;
  const CartPreBuild({super.key, required this.prebuild});

  @override
  State<CartPreBuild> createState() => _CartPreBuildState();
}

class _CartPreBuildState extends State<CartPreBuild> {
  Future<List<Map<String, dynamic>>> getCartItems() async {
    final userEmail = FirebaseAuth.instance.currentUser!;
    final userDocRef =
        FirebaseFirestore.instance.collection('User').doc(userEmail.toString());
    final cartCollectionRef = userDocRef.collection('PreBuildCart');

    final querySnapshot = await cartCollectionRef.get();
    final cartItems = querySnapshot.docs.map((doc) => doc.data()).toList();
    return cartItems;
  }

  Future<void> deleteCartItem(String cartItemId) async {
    final userEmail = FirebaseAuth.instance.currentUser!;
    final userDocRef =
        FirebaseFirestore.instance.collection('User').doc(userEmail.toString());
    final cartCollectionRef = userDocRef.collection('PreBuildCart');

    // Reference the specific document to delete
    final cartItemRef = cartCollectionRef.doc(cartItemId);

    try {
      await cartItemRef.delete();
      print('Cart item deleted successfully.');
    } catch (error) {
      print('Error deleting cart item: $error');
    }
  }

  final String userEmail = FirebaseAuth.instance.currentUser!.toString();
  @override
  Widget build(BuildContext context) {
    print(widget.prebuild);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('User')
              .doc(userEmail)
              .collection('PreBuildCart')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final cartItems = snapshot.data!.docs;

              return ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  final name = item['name'];
                  final idNum = item['idnum'];
                  final cabinet = item['case'];
                  final oldPrice = item['oldprice'];
                  final newPrice = item['newprice'];
                  final image = item['image'];

                  return Padding(
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
                      height: MediaQuery.of(context).size.height * .18,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .3,
                                height:
                                    MediaQuery.of(context).size.height * .12,
                                child: CachedNetworkImage(
                                  imageUrl: image,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .55,
                                height:
                                    MediaQuery.of(context).size.height * 0.165,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(name),
                                          IconButton(
                                              onPressed: () =>
                                                  deleteCartItem(idNum),
                                              icon: const Icon(Icons.close))
                                        ],
                                      ),
                                      Text(cabinet,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          maxLines: 1),
                                      Text('Qty: 1',
                                          style: TextStyling.categoryText),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text('₹',
                                              style: TextStyling.subtitle),
                                          const SizedBox(width: 3),
                                          Text(
                                              oldPrice.replaceAllMapped(
                                                  RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => "${m[1]},"),
                                              style: TextStyling.lineThrough),
                                          const SizedBox(width: 20),
                                          Text('₹',
                                              style: TextStyling.subtitle),
                                          const SizedBox(width: 3),
                                          Text(newPrice,
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
    );
  }
}

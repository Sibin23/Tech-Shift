import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/commonfile.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class OthersCart extends StatefulWidget {
  const OthersCart({super.key});

  @override
  State<OthersCart> createState() => _OthersCartState();
}

class _OthersCartState extends State<OthersCart> {
  Future<List<Map<String, dynamic>>> getCartItems() async {
    final userUid = FirebaseAuth.instance.currentUser!.uid;

    final userDocRef =
        FirebaseFirestore.instance.collection('User').doc(userUid);
    final cartCollectionRef = userDocRef.collection('others');

    final querySnapshot = await cartCollectionRef.get();
    final cartItems = querySnapshot.docs.map((doc) => doc.data()).toList();
    return cartItems;
  }

  Future<void> deleteCartItem(String cartItemId) async {
    try {
      final userUid = FirebaseAuth.instance.currentUser!.uid;
      final userDocRef =
          FirebaseFirestore.instance.collection('User').doc(userUid);
      final cartCollectionRef = userDocRef.collection('others');
      final cartItemRef = cartCollectionRef.doc(cartItemId);
      await cartItemRef.delete();
    } catch (error) {
      alert(error);
    }
  }
  alert(error){
    UiHelper.customTextAlert(context, error.toString());
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('others')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final cartItems = snapshot.data!.docs;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final document = snapshot.data!.docs[index];
              final cartId = document.id;

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
                            height: MediaQuery.of(context).size.height * .12,
                            child: CachedNetworkImage(
                              imageUrl: document['image'],
                              fit: BoxFit.contain ,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .55,
                            height: MediaQuery.of(context).size.height * 0.165,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                     Text(document['category'].toString().toUpperCase()),
                                      IconButton(
                                          onPressed: () =>
                                              deleteCartItem(cartId),
                                          icon: const Icon(Icons.close))
                                    ],
                                  ),
                                  Text(document['name'],
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      maxLines: 1),
                                  Text('Qty: 1',
                                      style: TextStyling.categoryText),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text('₹', style: TextStyling.subtitle),
                                      const SizedBox(width: 3),
                                      Text(
                                          document['oldprice'].replaceAllMapped(
                                              RegExp(
                                                  r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                              (Match m) => "${m[1]},"),
                                          style: TextStyling.lineThrough),
                                      const SizedBox(width: 20),
                                      Text('₹', style: TextStyling.subtitle),
                                      const SizedBox(width: 3),
                                      Text(document['newprice'],
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
    );
  }
}

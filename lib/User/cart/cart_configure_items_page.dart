import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/cart/cart_configure_details.dart';
import 'package:prosample_1/admin/const/variables.dart';
import '../../../functions/fuctions.dart';
import 'package:prosample_1/User/utils/utils_widget1.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

class ConfigureCart extends StatefulWidget {
  const ConfigureCart({super.key});

  @override
  State<ConfigureCart> createState() => _ConfigureCartState();
}

class _ConfigureCartState extends State<ConfigureCart> {
  Future<List<Map<String, dynamic>>> getCartItems() async {
    final userUid = FirebaseAuth.instance.currentUser!.uid;

    final userDocRef =
        FirebaseFirestore.instance.collection('User').doc(userUid);
    final cartCollectionRef = userDocRef.collection('Configuration');

    final querySnapshot = await cartCollectionRef.get();
    final cartItems = querySnapshot.docs.map((doc) => doc.data()).toList();
    return cartItems;
  }

  Future<void> deleteCartItem(String docId) async {
    try {
      final userUid = FirebaseAuth.instance.currentUser!.uid;
      final userDocRef =
          FirebaseFirestore.instance.collection('User').doc(userUid);
      final cartCollectionRef = userDocRef.collection('Configuration');
      final cartItemRef = cartCollectionRef.doc(docId);
      await cartItemRef.delete();
    } catch (error) {
      alert(error);
    }
  }

  alert(error) {
    UiHelper.customTextAlert(
        context, 'Error Occured Deleting ${error.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection(user)
          .doc(userId)
          .collection(configure)
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
              final pc = document.data();
              return Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) =>
                                CartConfigureItemsDetails(pc: pc)));
                  },
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
                                imageUrl: document[itemImage],
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: Text(document['cabinet'])),
                                        IconButton(
                                            onPressed: () {
                                              deleteAmount(docId: cartId);
                                              deleteCartItem(cartId);
                                              deleteUserDetiails(cartId);
                                            },
                                            icon: const Icon(Icons.close))
                                      ],
                                    ),
                                    Text('Qty: 1',
                                        style: TextStyling.categoryText),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text('₹', style: TextStyling.subtitle),
                                        const SizedBox(width: 3),
                                        Text(
                                            document['totalprice'].replaceAllMapped(
                                                RegExp(
                                                    r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                (Match m) => "${m[1]},"),
                                            style: TextStyling.newP),
                                        const SizedBox(width: 20),
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
        return const Center(
            child: CircularProgressIndicator(color: Colors.transparent));
      },
    );
  }
}

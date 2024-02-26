import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    print(widget.prebuild);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: getCartItems(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final cartItems = snapshot.data!;
              return ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  final name = item['name'];
                  final oldPrice = item['oldprice'];
                  final newPrice = item['newprice'];
                  final image = item['image'];
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      color: Colors.amber,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              color: Colors.green,
                              width: MediaQuery.of(context).size.width * .3,
                              height: MediaQuery.of(context).size.height * .13,
                              child: CachedNetworkImage(
                                imageUrl: image,
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                              ),
                            ),
                            Container(
                              color: Colors.orange,
                              child: Column(
                                children: [
                                  Text(item['name']),
                                  Text(item['case']),
                                ],
                              ),
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
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

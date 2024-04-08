import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/cart/cart_configure_items_page.dart';
import 'package:prosample_1/User/cart/cart_other_items_page.dart';
import 'package:prosample_1/User/cart/cart_prebuild_items_page.dart';
import 'package:prosample_1/User/cart/cart_proceed_button.dart';
import 'package:prosample_1/User/cart/cart_total_amount.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

class ScreenCart extends StatefulWidget {
  const ScreenCart({super.key});

  @override
  State<ScreenCart> createState() => _ScreenCartState();
}

class _ScreenCartState extends State<ScreenCart> {
  bool hasPrebuild = false;
  bool? hasConfig;
  bool hasItem = false;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: const Padding(
              padding: EdgeInsets.only(left: 40, right: 40, bottom: 15),
              child: ProceedButton(),
            )),
        appBar: AppBar(
          centerTitle: true,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Cart Page'),
              SizedBox(width: 5),
              Icon(Icons.shopping_cart_outlined)
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('User').doc(userId).collection('CartDetails')
                  
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator(color: Colors.transparent));
                  default:
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .6,
                          child: Stack(
                            children: [
                              Lottie.asset('assets/animations/noCart.json',
                                  fit: BoxFit.cover),
                              Positioned(
                                  left: MediaQuery.of(context).size.width * .25,
                                  right:
                                      MediaQuery.of(context).size.width * .25,
                                  top: MediaQuery.of(context).size.height * .3,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Text('No Cart Items Yet',
                                          style: TextStyling.subtitle3),
                                    ),
                                  )),
                            ],
                          ));
                    }

                    return Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: const ConfigureCart(),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: const PreBuildCart(),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: const OthersCart(),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Total Amount',style: TextStyling.appTitle),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TotalAmout(),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                }
              }),
        ));
  }
}

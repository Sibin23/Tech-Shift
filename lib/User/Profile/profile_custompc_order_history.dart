import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/profile/profile_custonpc_order_details.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/admin/const/variables.dart';

class CustonPcOrderHistory extends StatefulWidget {
  const CustonPcOrderHistory({super.key});

  @override
  State<CustonPcOrderHistory> createState() => _CustonPcOrderHistoryState();
}

class _CustonPcOrderHistoryState extends State<CustonPcOrderHistory> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configure PC'),
      ),
      body: isLoading == true
          ? Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Loading',
                      style: GoogleFonts.roboto(
                          color: AppColors.appTheme, fontSize: 23)),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Lottie.asset('assets/animations/cart_loading.json',
                        filterQuality: FilterQuality.high, fit: BoxFit.cover),
                  ),
                ],
              ),
            )
          : SafeArea(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('OrderCustomPC')
                      .where('uid', isEqualTo: uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/order_box.png',
                                filterQuality: FilterQuality.high,
                                width: 200.0,
                                height: 200.0,
                              ),
                              Text('No Orders Yet',
                                  style: GoogleFonts.roboto(
                                      color: AppColors.appTheme, fontSize: 20)),
                            ],
                          ));
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data!.docs[index];
                            Map<String, dynamic> customPc = data.data();
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            CustomPcOderDetails(pc: customPc)));
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
                                  height:
                                      MediaQuery.of(context).size.height * .18,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top: 10,
                                          right: 20,
                                          child: Text(
                                            data[status],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: data[status] ==
                                                        confirmed
                                                    ? Colors.green
                                                    : data[status] ==
                                                            cancelled
                                                        ? Colors.red
                                                        : data[status] ==
                                                                pending
                                                            ? Colors.orange
                                                            : Colors.grey),
                                          )),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .3,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .12,
                                                child: CachedNetworkImage(
                                                  imageUrl: data[itemImage],
                                                  fit: BoxFit.contain,
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .55,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.165,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(data[username]
                                                          .toString()
                                                          .toUpperCase()),
                                                      Text(data[cabinet],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          softWrap: false,
                                                          maxLines: 1),
                                                      Text('Qty: 1',
                                                          style: TextStyling
                                                              .categoryText),
                                                      const SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          Text('₹',
                                                              style: TextStyling
                                                                  .subtitle),
                                                          const SizedBox(
                                                              width: 3),
                                                          Text(
                                                              data[totalPrice]
                                                                  .replaceAllMapped(
                                                                      RegExp(
                                                                          r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                                      (Match m) =>
                                                                          "${m[1]},"),
                                                              style: TextStyling
                                                                  .newP),
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
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Loading',
                              style: GoogleFonts.roboto(
                                  color: AppColors.appTheme, fontSize: 23)),
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: Lottie.asset(
                                'assets/animations/cart_loading.json',
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover),
                          ),
                        ],
                      ),
                    );
                  })),
    );
  }
}

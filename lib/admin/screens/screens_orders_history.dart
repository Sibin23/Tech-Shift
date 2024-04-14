import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/const/variables.dart';
import 'package:prosample_1/admin/orders/order_buttons.dart';
import 'package:prosample_1/admin/orders/order_details.dart';

class ScreenOrdersList extends StatefulWidget {
  const ScreenOrdersList({super.key});

  @override
  State<ScreenOrdersList> createState() => _ScreenOrdersListState();
}

class _ScreenOrdersListState extends State<ScreenOrdersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: OrderButtons(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(admBoxImg),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: const Text(
          'Orders History'
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection(orderOthers)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot document =
                              snapshot.data!.docs[index];
                          Map<String, dynamic> orderData =
                              document.data() as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 5, bottom: 5),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              OrderDetails(info: orderData)));
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
                                    width: MediaQuery.of(context).size.width,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .02,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .05,
                                          child: Text(
                                            document[status],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 17,
                                                color: document[status] ==
                                                        pending
                                                    ? Colors.orange
                                                    : document[status] ==
                                                            confirmed
                                                        ? Colors.green
                                                        : document[status] ==
                                                                cancelled
                                                            ? Colors.red
                                                            : Colors.black),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.12,
                                                        child: document[
                                                                    itemImage] !=
                                                                null
                                                            ? CachedNetworkImage(
                                                                imageUrl:
                                                                    document[
                                                                        itemImage],
                                                                fit: BoxFit
                                                                    .cover,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    const Center(
                                                                        child:
                                                                            CircularProgressIndicator()),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    const Icon(Icons
                                                                        .error),
                                                              )
                                                            : Image.asset(
                                                                'assets/categories/ssd.png',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Flexible(
                                                        child: SizedBox(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  '# ${document[orderId]}'),
                                                              Text(document[
                                                                      category]
                                                                  .toString()
                                                                  .toUpperCase()),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: Text(
                                                                    document[
                                                                        name]),
                                                              ),
                                                              Text(
                                                                document[
                                                                    newPrice],
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .green),
                                                              ),
                                                              Text(
                                                                  '${document[date]}/${document[month]}/${document[year]}'),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ])),
                                      ],
                                    ))),
                          );
                        }),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }
}

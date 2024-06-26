import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/const/variables.dart';
import 'package:prosample_1/admin/custompc_orders/custompc_order_buttons.dart';
import 'package:prosample_1/admin/custompc_orders/custompc_order_details.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';

class OrderConfiguration extends StatefulWidget {
  const OrderConfiguration({super.key});

  @override
  State<OrderConfiguration> createState() => _OrderConfigurationState();
}

class _OrderConfigurationState extends State<OrderConfiguration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text('Custom Build Orders'),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: CustomPCOrederButton(),
      ),
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:
                  FirebaseFirestore.instance.collection(customPc).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data!.docs[index];
                          Map<String, dynamic> info = data.data();

                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, bottom: 5, top: 5),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              CustomPCOrderDetails(
                                                  info: info)));
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
                                              0.01,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                          child: Text(
                                            data[status],
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400,
                                              color: data[status] == pending
                                                  ? Colors.orange
                                                  : data[status] == confirmed
                                                      ? Colors.green
                                                      : data[status] ==
                                                              cancelled
                                                          ? Colors.red
                                                          : Colors.black,
                                            ),
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
                                                        child: data[itemImage] !=
                                                                null
                                                            ? CachedNetworkImage(
                                                                imageUrl: data[
                                                                    itemImage],
                                                                fit: BoxFit
                                                                    .cover,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Image.asset(
                                                                  'assets/categories/ssd.png',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
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
                                                                  '# ${data[orderId]}'),
                                                              Text(
                                                                data[username],
                                                                style: CustomText
                                                                    .subtitle2,
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: Text(data[
                                                                    cabinet]),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Text(
                                                                      'Total Price:  '),
                                                                  Text(
                                                                    data[
                                                                        totalPrice],
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .green),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                  '${data[date]}/${data[month]}/${data[year]}'),
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
              })),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/Configured%20orders/custompc_order_detail_button.dart';
import 'package:prosample_1/admin/utils/text_style.dart';

class CustomPCOrderDetails extends StatefulWidget {
  final Map<String, dynamic> info;
  const CustomPCOrderDetails({super.key, required this.info});

  @override
  State<CustomPCOrderDetails> createState() => _CustomPCOrderDetailsState();
}

class _CustomPCOrderDetailsState extends State<CustomPCOrderDetails> {
  @override
  Widget build(BuildContext context) {
    final item = widget.info;
    const space = SizedBox(height: 10);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: CustomPCorderDetailButton(
            orderId: widget.info['orderid'], uid: widget.info['uid']),
      ),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: const Text('Order Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  decoration:
                      const BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(1, 3))
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .3,
                              height: MediaQuery.of(context).size.height * .15,
                              child: CachedNetworkImage(
                                imageUrl: item['userimage'],
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('Order Status:  ',
                                            style: CustomText.subtitle2),
                                        Text(
                                          item['status'],
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: item['status'] == 'Pending'
                                                  ? Colors.orange
                                                  : item['status'] == 'Confirmed'
                                                      ? Colors.green
                                                      : item['status'] ==
                                                              'Cancelled'
                                                          ? Colors.red
                                                          : Colors.black),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '# ${item['orderid']}',
                                      style: CustomText.subtitle2,
                                    ),
                                    Text(
                                        '${item['date']}/${item['month']}/${item['year']}',
                                        style: CustomText.subtitleG),
                                    Text(item['username'],
                                        style: CustomText.subtitle2),
                                    Text(
                                      item['phnum'],
                                      style: CustomText.subtitle2,
                                    ),
                                    Text(
                                      item['email'],
                                      style: CustomText.subtitle2,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Shipping Address',
                                  style: CustomText.subtitle),
                              const SizedBox(height: 10),
                              Text(
                                '${item['house']}, ${item['area']}, ${item['locality']}, ${item['city']}, ${item['state']}, ${item['pincode']}.',
                                style: CustomText.subtitle2,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text('Item Detiails', style: CustomText.subtitle),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .4,
                                height: MediaQuery.of(context).size.height * .2,
                                child: CachedNetworkImage(
                                  imageUrl: item['image'],
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['cabinet'],
                                          style: CustomText.subtitle2,
                                        ),
                                        Row(
                                          children: [
                                            Text('Total Price:  ',
                                                style: CustomText.subtitle2),
                                            Text(
                                              '${item['totalprice']}',
                                              style: const TextStyle(
                                                  color: Colors.green),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Text('Cabinet', style: CustomText.categoryTitleText),
                        Text(item['cabinet'], style: CustomText.subtitle2),
                        space,
                        Text('Processor', style: CustomText.categoryTitleText),
                        Text(item['processor'], style: CustomText.subtitle2),
                        space,
                        Text('Motherboard', style: CustomText.categoryTitleText),
                        Text(item['motherboard'], style: CustomText.subtitle2),
                        space,
                        Text('RAM', style: CustomText.categoryTitleText),
                        Text(item['ram'], style: CustomText.subtitle2),
                        space,
                        Text('SSD', style: CustomText.categoryTitleText),
                        Text(item['ssd'], style: CustomText.subtitle2),
                        space,
                        Text('GPU', style: CustomText.categoryTitleText),
                        Text(item['gpu'], style: CustomText.subtitle2),
                        space,
                        Text('CPU Cooler', style: CustomText.categoryTitleText),
                        Text(item['cooler'], style: CustomText.subtitle2),
                        space,
                        Text('PSU', style: CustomText.categoryTitleText),
                        Text(item['psu'], style: CustomText.subtitle2),
                        space,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

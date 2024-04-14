import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/admin/const/variables.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';

class ProfileOrderDetails extends StatefulWidget {
  final Map<String, dynamic> detail;
  const ProfileOrderDetails({
    super.key,
    required this.detail,
  });

  @override
  State<ProfileOrderDetails> createState() => _ProfileOrderDetailsState();
}

class _ProfileOrderDetailsState extends State<ProfileOrderDetails> {
  bool isLoading = false;
  Map<String, dynamic> item = {};

  @override
  Widget build(BuildContext context) {
    final data = widget.detail;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
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
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.person, size: 30),
                            imageUrl: data[userImage],
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
                                      data[status],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 17,
                                          color: data[status] == pending
                                              ? Colors.orange
                                              : data[status] == confirmed
                                                  ? Colors.green
                                                  : data[status] == cancelled
                                                      ? Colors.red
                                                      : Colors.black),
                                    ),
                                  ],
                                ),
                                Text(
                                  '# ${data[orderId]}',
                                  style: CustomText.subtitle2,
                                ),
                                Text(
                                    '${data[date]}/${data[month]}/${data[year]}',
                                    style: CustomText.subtitleG),
                                Text(data[username],
                                    style: CustomText.subtitle2),
                                Text(
                                  data[mobile],
                                  style: CustomText.subtitle2,
                                ),
                                Text(
                                  data[email],
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
                          Text('Shipping Address', style: CustomText.subtitle),
                          const SizedBox(height: 10),
                          Text(
                            '${data[house]}, ${data[area]}, ${data[locality]}, ${data[city]}, ${data[state]}, ${data[pincode]}.',
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
                              imageUrl: data[itemImage],
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[name],
                                      style: CustomText.subtitle2,
                                    ),
                                    Row(
                                      children: [
                                        Text('New Price:  ',
                                            style: CustomText.subtitle2),
                                        Text(
                                          '${data[newPrice]}',
                                          style: const TextStyle(
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Old Price:  ',
                                            style: CustomText.subtitle2),
                                        Text(data[oldPrice]),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

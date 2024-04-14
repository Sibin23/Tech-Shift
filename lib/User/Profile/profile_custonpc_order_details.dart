import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget3.dart';
import 'package:prosample_1/admin/const/variables.dart';

class CustomPcOderDetails extends StatelessWidget {
  final Map<String, dynamic> pc;
  const CustomPcOderDetails({super.key, required this.pc});

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(height: 15);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
                top: 0,
                right: 30,
                child: Text(
                  pc[status],
                  style: TextStyle(
                      fontSize: 18,
                      color: pc[status] == 'Confirmed'
                          ? Colors.green
                          : pc[status] == 'Cancelled'
                              ? Colors.red
                              : pc[status] == 'Pending'
                                  ? Colors.orange
                                  : Colors.grey),
                )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .25,
                    child: CachedNetworkImage(
                      imageUrl: pc['image'],
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Center(
                          child: Image.asset('assets/Categories/cabinet.png')),
                    ),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(pc['cabinet'], style: TextStyling.subtitle3),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text('Build Price: ',
                                      style: TextStyling.subtitle3),
                                  Text('₹', style: TextStyling.subtitle),
                                  const SizedBox(width: 3),
                                  Text(
                                      pc['totalprice'].replaceAllMapped(
                                          RegExp(
                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match m) => "${m[1]},"),
                                      style: TextStyling.newP),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                  space,
                  UiCustom2.custom1PcCard(context,
                      title: 'Processor',
                      name: pc['processor'],
                      price: pc['processorprice'],
                      image: 'assets/icons/cpu.jpg'),
                  space,
                  UiCustom2.custom1PcCard(context,
                      title: 'Motherboard',
                      name: pc['motherboard'],
                      price: pc['motherboardprice'],
                      image: 'assets/icons/motherboard.jpeg'),
                  space,
                  UiCustom2.custom1PcCard(context,
                      title: 'RAM',
                      name: pc['ram'],
                      price: pc['ramprice'],
                      image: 'assets/icons/ram.jpg'),
                  space,
                  UiCustom2.custom1PcCard(context,
                      title: 'SSD',
                      name: pc['ssd'],
                      price: pc['ssdprice'],
                      image: 'assets/icons/ssd.jpeg'),
                  space,
                  UiCustom2.custom1PcCard(context,
                      title: 'GPU',
                      name: pc['gpu'],
                      price: pc['gpuprice'],
                      image: 'assets/icons/gpu.jpeg'),
                  space,
                  UiCustom2.custom1PcCard(context,
                      title: 'CPU Cooler',
                      name: pc['cooler'],
                      price: pc['coolerprice'],
                      image: 'assets/icons/cooler.jpeg'),
                  space,
                  UiCustom2.custom1PcCard(context,
                      title: 'PSU',
                      name: pc['psu'],
                      price: pc['psuprice'],
                      image: 'assets/icons/psu.jpeg'),
                  space,
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

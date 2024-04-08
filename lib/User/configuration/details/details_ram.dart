import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget2.dart';
import 'package:prosample_1/User/utils/utils_widget3.dart';

class ConfigDetails3 extends StatefulWidget {
  final Map<String, dynamic> pc;
  final String total;
  const ConfigDetails3({super.key, required this.pc, required this.total});

  @override
  State<ConfigDetails3> createState() => _ConfigDetails3State();
}

class _ConfigDetails3State extends State<ConfigDetails3> {
  @override
  Widget build(BuildContext context) {
    final custom = widget.pc;
    String cpu = custom['processor'];
    String cpuPrice = custom['processorprice'];
    String board = custom['motherboard'];
    String boardPrice = custom['motherboardprice'];
    String ram = custom['ram'];
    String ramPrice = custom['ramprice'];
    

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Text('Your PC Configurations', style: TextStyling.subtitle3),
      ),
      bottomNavigationBar: UiCustom2.customBotNav(context),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Processor', style: TextStyling.subtitleapptheme),
              UiCustom.configDetail(context, name: cpu, price: cpuPrice),
              const SizedBox(height: 10),
              Text('Motherboard', style: TextStyling.subtitleapptheme),
              UiCustom.configDetail(context, name: board, price: boardPrice),
              const SizedBox(height: 10),
              Text('RAM (Memory)', style: TextStyling.subtitleapptheme),
              UiCustom.configDetail(context, name: ram, price: ramPrice),
              const SizedBox(height: 10),
              Text('SSD (Storage)', style: TextStyling.subtitleapptheme),
              UiCustom.configBox(context),
              const SizedBox(height: 10),
              Text('Graphics Card (GPU)', style: TextStyling.subtitleapptheme),
              UiCustom.configBox(context),
              const SizedBox(height: 10),
              Text('Power Supply Unit (PSU)',
                  style: TextStyling.subtitleapptheme),
              UiCustom.configBox(context),
              const SizedBox(height: 10),
              Text('Cabinet Case', style: TextStyling.subtitleapptheme),
              UiCustom.configBox(context),
              const SizedBox(height: 10),
              Text('CPU Coolers', style: TextStyling.subtitleapptheme),
              UiCustom.configBox(context),
              const SizedBox(height: 20),
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 1)],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                  color: Color.fromARGB(255, 231, 231, 231),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .065,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Total Amount',
                              style: TextStyling.subtitleapptheme),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .3,
                      decoration: const BoxDecoration(color: Colors.black),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '₹ ${widget.total}'.replaceAllMapped(
                                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match m) => "${m[1]},"),
                            style: TextStyling.subtitleWhite,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      )),
    );
  }
}

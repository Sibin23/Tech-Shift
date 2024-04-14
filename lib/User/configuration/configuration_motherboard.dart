import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosample_1/User/configuration/details/details_motherboard.dart';
import 'package:prosample_1/User/configuration/configuration_processor.dart';
import 'package:prosample_1/User/configuration/configuration_ram.dart';
import 'package:prosample_1/User/utils/utils_colors.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';
import 'package:prosample_1/User/utils/utils_widget2.dart';
import 'package:prosample_1/admin/const/variables.dart';

class MotherboardConfig extends StatefulWidget {
  final String power;
  final Map<String, dynamic> pc;
  final String socket;
  final String price;
  const MotherboardConfig(
      {super.key,
      required this.power,
      required this.socket,
      required this.price,
      required this.pc});

  @override
  State<MotherboardConfig> createState() => _MotherboardConfigState();
}

class _MotherboardConfigState extends State<MotherboardConfig> {
  String? selectedRam;
  String? selectedSsd;
  String? _selectedDocumentId;
  String? selectedBoard;
  String? selectedPrice;
  String? selectedPower;

  @override
  Widget build(BuildContext context) {
    selectedPower ??= 0.toString();
    int totalPwr =
        int.parse(widget.power) + int.parse(selectedPower.toString());
    final selectedSocket = widget.socket;
    String amt = widget.price;
    selectedPrice ??= 0.toString();
    int total = int.parse(amt) + int.parse(selectedPrice.toString());
    selectedPrice ??= 0.toString();
    selectedBoard ??= 'Select a Motherboard';
    return Scaffold(
      appBar: AppBar(surfaceTintColor: Colors.white, actions: [
        GestureDetector(
            onTap: () {
              final pc = Map<String, dynamic>.from(widget.pc);
              pc[motherboard] = selectedBoard;
              pc['motherboardprice'] = selectedPrice;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) =>
                          ConfigDetails2(pc: pc, total: total.toString())));
            },
            child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: AppColors.appTheme, spreadRadius: 2)
                    ]),
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.info, color: AppColors.appTheme),
                          const SizedBox(width: 5),
                          Text(
                              '₹ $total'.replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => "${m[1]},"),
                              style: TextStyling.subtitleapptheme)
                        ]))))
      ]),
      bottomNavigationBar: UiCustom.bottomNextButton(context, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => const ProcessorConfig()));
      }, () {
        if (_selectedDocumentId == null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 3),
              content: Center(
                  child: Text(
                'Please select a Motherboard',
                style: TextStyling.subtitleWhite,
              )),
              backgroundColor: const Color.fromARGB(255, 245, 62, 49)));
        } else {
          final updatedConfig = Map<String, dynamic>.from(widget.pc);
          updatedConfig['motherboard'] = _selectedDocumentId;
          final pc = Map<String, dynamic>.from(widget.pc);
          pc[motherboard] = selectedBoard;
          pc['motherboardprice'] = selectedPrice;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => RamConfig(
                      power: totalPwr.toString(),
                      total: total.toString(),
                      pc: pc,
                      ramType: selectedRam.toString(),
                      ssdType: selectedSsd.toString(),
                      config: updatedConfig)));
        }
      }),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Motherboard', style: TextStyling.titleText),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection(motherboard)
                        .where(cpuSocket, isEqualTo: selectedSocket)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 5,
                                mainAxisExtent: 240,
                              ),
                              itemBuilder: ((context, index) {
                                DocumentSnapshot document =
                                    snapshot.data!.docs[index];
                               
                                bool isSelected =
                                    document.id == _selectedDocumentId;
                                return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5, top: 5, bottom: 5),
                                    child: GestureDetector(
                                        onTap: () => setState(() {
                                              if (isSelected) {
                                                _selectedDocumentId = null;
                                                selectedBoard = null;
                                                selectedRam = null;
                                                selectedSsd = null;
                                                selectedPower = null;
                                                selectedPrice = null;
                                              } else {
                                                _selectedDocumentId =
                                                    document.id;
                                                selectedBoard = document[name];
                                                selectedRam = document[ramType];
                                                selectedSsd = document[ssdType];
                                                selectedPrice = document[newPrice];
                                                selectedPower = document[wattage];
                                              }
                                              isSelected = !isSelected;
                                            }),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset:
                                                          const Offset(2, 2),
                                                      spreadRadius: 1,
                                                      blurRadius: 2,
                                                      color: Colors.grey
                                                          .withOpacity(0.3))
                                                ],
                                                border: isSelected
                                                    ? Border.all(
                                                        color:
                                                            AppColors.appTheme,
                                                        width: 2,
                                                      )
                                                    : null),
                                            child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          spreadRadius: 1,
                                                          blurRadius: 2,
                                                          color: Colors.grey)
                                                    ]),
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.3,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.11,
                                                                    child: CachedNetworkImage(
                                                                        imageUrl:
                                                                            document[itemImage],
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        placeholder: (context, url) => Image.asset(
                                                                            'assets/categories/motherboard.png',
                                                                            fit:
                                                                                BoxFit.cover)))
                                                              ]),
                                                          SizedBox(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child: Text(document[name],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  softWrap:
                                                                      false,
                                                                  maxLines: 1,
                                                                  style: TextStyling
                                                                      .subtitle2)),
                                                          const SizedBox(
                                                              height: 5),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  '${document[cpuSocket]}, ',
                                                                  style: TextStyling
                                                                      .categoryText),
                                                              const SizedBox(
                                                                  width: 3),
                                                              Text(document[ramType],
                                                                  style: TextStyling
                                                                      .categoryText)
                                                            ],
                                                          ),
                                                          Text(document[ssdType],
                                                              style: TextStyling
                                                                  .categoryText),
                                                          SizedBox(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child: Text(document[maxClock],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  softWrap:
                                                                      false,
                                                                  maxLines: 1,
                                                                  style: TextStyling
                                                                      .categoryText)),
                                                          const SizedBox(
                                                              height: 8),
                                                          Row(children: [
                                                            const Text('₹'),
                                                            const SizedBox(
                                                                width: 2),
                                                            Text(
                                                                document[newPrice].replaceAllMapped(
                                                                    RegExp(
                                                                        r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                                    (Match m) =>
                                                                        "${m[1]},"),
                                                                style:
                                                                    TextStyling
                                                                        .newP)
                                                          ])
                                                        ]))))));
                              })),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
